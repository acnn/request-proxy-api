require 'http'
module RequestHelper
    def make_request(user_request)
      request_headers = JSON.parse(user_request.headers)[0] if !user_request.headers.blank?
      HTTP.headers(request_headers).get(user_request.url)
    end
  end