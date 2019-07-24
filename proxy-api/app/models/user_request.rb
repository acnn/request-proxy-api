class UserRequest
    include ActiveModel::Model

    URL_REGEXP = /^(https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    HTTP_METHODS_LIST = ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'HEAD', 'CONNECT', 'TRACE', 'PATCH']
    
    attr_accessor :client_id, :url, :headers, :http_method, :request_body

    validates :client_id, presence: true
    validates :url, presence: true
    validates :url, format: { with: URL_REGEXP, multiline: true, message: "is either invalid or non-https" }, allow_blank: true
    validates :http_method, presence: true
    validates :http_method, inclusion: { in: HTTP_METHODS_LIST, message: "is either invalid or unsupported" }, allow_blank: true

end
