class UserRequest
    include ActiveModel::Validations

    URL_REGEXP = /^(https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    HTTP_METHODS_LIST = ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'HEAD', 'CONNECT', 'TRACE', 'PATCH']
    attr_accessor :client_id, :url, :headers, :http_method, :request_body

    validates :client_id, presence: true
    validates :url, presence: true
    validates :url, format: { with: URL_REGEXP, multiline: true, message: "is either invalid or non-https" }, allow_blank: true
    validates :http_method, presence: true
    validates :http_method, inclusion: { in: HTTP_METHODS_LIST, message: "is either invalid or unsupported" }, allow_blank: true

    def initialize(user_request)
        @client_id = user_request[:client_id]
        @url = user_request[:url]
        @headers = user_request[:headers]
        @http_method = user_request[:http_method]
        @request_body = user_request[:request_body]
    end
end
