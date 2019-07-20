class ProxyController < ApplicationController

    def index
        method_not_allowed()
    end

    def show
        method_not_allowed()
    end

    def update
        method_not_allowed()
    end

    def destroy
        method_not_allowed()
    end

    def create
        require 'http'
        user_request = UserRequest.create!(request_params)
        source_response = HTTP.get(user_request.url)
        relay_response(source_response)
    end

    def request_params
        params.permit(:client_id, :url, :headers, :http_method, :request_body)
    end

end
