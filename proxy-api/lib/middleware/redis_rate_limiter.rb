require 'redis'

class RedisRateLimiter
    
    TRACKING_PERIOD_SECONDS = 60
    TRACKING_PERIOD_REQUEST_LIMIT = 3

    def initialize(app)
        @app = app
    end


    def call(env)
        request = Rack::Request.new(env)
        client_id = request.params['client_id']

        if(client_id.nil? || client_id.empty?)
            [ 422, {}, ['Client ID is required'] ]
        elsif(rate_exceeded?(client_id))
            [ 429, {}, ['You have exceeded the allowed number of requests. Please try after some time.'] ]
        else
            @app.call(env)
        end
    end

    def rate_exceeded?(client_key)
        request_count = redis.get(client_key)   
        if request_count
            if request_count.to_i >= TRACKING_PERIOD_REQUEST_LIMIT
                return true
            else
                redis.incr(client_key)
            end
        else
            redis.set(client_key, 1)
            redis.expire(client_key, TRACKING_PERIOD_SECONDS)
        end
        return false
    end

    private
    def redis
        Redis.current
    end
end