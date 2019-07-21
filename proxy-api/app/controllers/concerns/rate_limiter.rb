require 'redis'
module RateLimiter
    TRACKING_PERIOD_SECONDS = 60
    TRACKING_PERIOD_REQUEST_LIMIT = 50
    BLOCKING_PERIOD_SECONDS = 60

    def is_request_permitted(user_request)
        count_key = 'count:' + user_request.client_id
        blocked_key = 'blocked:' + user_request.client_id
        if redis.get(blocked_key)
            return false
        end
        if redis.get(count_key)
            request_count = redis.incr(count_key)   
            if request_count >= TRACKING_PERIOD_REQUEST_LIMIT
                redis.set(blocked_key, 1)
                redis.expire(blocked_key, BLOCKING_PERIOD_SECONDS)
            end
        
        else
            redis.set(count_key, 1)
            redis.expire(count_key, TRACKING_PERIOD_SECONDS)
        end
        return true
    end

    private
    def redis
        Redis.current
    end
end