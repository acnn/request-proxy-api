class UserRequest < ApplicationRecord
    HTTPS_URL_REGEXP = /^https/
    URL_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
    HTTP_METHODS_LIST = ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'HEAD', 'CONNECT', 'TRACE', 'PATCH']
    validates :client_id, presence: true
    validates :url, presence: true, format: { with: URL_REGEXP, multiline: true, message: "is invalid" } 
    validates :url, format: { with: HTTPS_URL_REGEXP, multiline: true, message: "is invalid. Only HTTPS urls are supported." }  
    validates :http_method, presence: true, inclusion: { in: HTTP_METHODS_LIST, message: "is invalid or unsupported" }
end
