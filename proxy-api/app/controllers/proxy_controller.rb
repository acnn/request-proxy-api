class ProxyController < ApplicationController
    include RequestHelper
    include ResponseHelper

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

    def create
        begin
            user_request = UserRequest.create!(request_params)
            source_response = make_request(user_request)
            relay_response(source_response)
        rescue ActiveRecord::RecordInvalid => e
            unprocessable_entity_response(e)
        end
        rescue HTTP::TimeoutError => e
            request_timeout_response(e)
        end

    def request_params
        params.permit(:client_id, :url, :headers, :http_method, :request_body)
    end

end
