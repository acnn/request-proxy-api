require 'http'
module RequestHelper
    TIMEOUT_LIMIT = 5
    def make_request(user_request)
      request_headers = JSON.parse(user_request.headers) if !user_request.headers.blank?
      HTTP.timeout(TIMEOUT_LIMIT)
      .headers(request_headers)
      .send(user_request.http_method.downcase, *[user_request.url, :body => user_request.request_body])
    end
  end