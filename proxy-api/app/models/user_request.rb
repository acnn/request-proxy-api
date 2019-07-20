class UserRequest < ApplicationRecord
    validates_presence_of :client_id, :url, :http_method
end
