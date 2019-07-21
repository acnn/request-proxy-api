class ProxyController < ApplicationController
    include RequestHelper
    include ResponseHelper
    include RateLimiter

    def index
        method_not_allowed_response()
    end

    def show
        method_not_allowed_response()
    end

    def update
        method_not_allowed_response()
    end

    def destroy
        method_not_allowed_response()
    end

    def welcome
        welcome_response()
    end

    def create
        begin           
            user_request = UserRequest.create!(request_params)
            if(is_request_permitted(user_request))
                source_response = make_request(user_request)
                relay_response(source_response)
            else
                rate_limiter_response()
            end
        rescue ActiveRecord::RecordInvalid => e
            unprocessable_entity_response(e)        
        rescue HTTP::TimeoutError => e
            request_timeout_response(e)        
        rescue StandardError => e
            #puts e
            server_error_response()
        end
    end

    def request_params
        params.permit(:client_id, :url, :headers, :http_method, :request_body)
    end

end
