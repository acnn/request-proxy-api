require 'redis'
module RateLimiter
    TRACKING_PERIOD_SECONDS = 60
    TRACKING_PERIOD_REQUEST_LIMIT = 50

    def is_request_permitted(user_request)
        client_key = user_request.client_id
        request_count = redis.get(client_key)   
        if request_count
            if request_count.to_i >= TRACKING_PERIOD_REQUEST_LIMIT
                return false
            else
                redis.incr(client_key)
            end
        else
            redis.set(client_key, 1)
            redis.expire(client_key, TRACKING_PERIOD_SECONDS)
        end
        return true
    end

    private
    def redis
        Redis.current
    end
end