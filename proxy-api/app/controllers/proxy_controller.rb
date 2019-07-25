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

    def welcome
        welcome_response()
    end

    def create
        begin       
            user_request = UserRequest.new(
                client_id: request_params[:client_id],
                url: request_params[:url],
                headers: request_params[:headers],
                http_method: request_params[:http_method],
                request_body: request_params[:request_body]
            )
            if(user_request.valid?)
                source_response = make_request(user_request, { timeout_limit: 1 })
                relay_response(source_response)
            else
                validation_error = user_request.errors.full_messages.join(", ")
                unprocessable_entity_response(validation_error)
            end
                    
        rescue HTTP::TimeoutError => e
            request_timeout_response(e)    

        rescue StandardError => e
            Rails.logger.debug 'Error: ' + e.to_s
            server_error_response()
        end
    end

    def request_params
        params.permit(:client_id, :url, :headers, :http_method, :request_body)
    end

end
