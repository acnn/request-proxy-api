class UserRequest < ApplicationRecord
    validates_presence_of :client_id, :url, :http_method, :request_body
end
