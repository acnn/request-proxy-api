require 'http'
class ProxyController < ApplicationController

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
            source_response = HTTP.get(user_request.url)
            relay_response(source_response)
        rescue ActiveRecord::RecordInvalid => e
            unprocessable_entity_response(e)
        end
    end

    def request_params
        params.permit(:client_id, :url, :headers, :http_method, :request_body)
    end

end
