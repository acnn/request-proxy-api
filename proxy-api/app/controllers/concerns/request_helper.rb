require 'http'
module RequestHelper
    DEFAULT_TIMEOUT_LIMIT = 5
    def make_request(user_request, options = {})
      timeout_limit = options[:timeout_limit] || DEFAULT_TIMEOUT_LIMIT
      request_headers = JSON.parse(user_request.headers) if !user_request.headers.blank?
      HTTP.timeout(timeout_limit)
      .headers(request_headers)
      .send(user_request.http_method.downcase, *[user_request.url, :body => user_request.request_body])
    end
  end