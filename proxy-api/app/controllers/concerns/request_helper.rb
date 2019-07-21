require 'http'
module RequestHelper
    TIMEOUT_LIMIT = 5
    def make_request(user_request)
      request_headers = JSON.parse(user_request.headers)[0] if !user_request.headers.blank?
      httpChainWithHeaders = HTTP.timeout(TIMEOUT_LIMIT).headers(request_headers)
      #TODO - Refactor to use function pointer map?
      case user_request.http_method
        when 'GET'
          httpChainWithHeaders.get(user_request.url, :body => user_request.request_body)
        when 'POST'
          httpChainWithHeaders.post(user_request.url, :body => user_request.request_body)
        when 'PUT'
          httpChainWithHeaders.put(user_request.url, :body => user_request.request_body)
        when 'DELETE'
          httpChainWithHeaders.delete(user_request.url, :body => user_request.request_body)
        when 'OPTIONS'
          httpChainWithHeaders.options(user_request.url, :body => user_request.request_body)
        when 'HEAD'
          httpChainWithHeaders.head(user_request.url, :body => user_request.request_body)
        when 'CONNECT'
          httpChainWithHeaders.connect(user_request.url, :body => user_request.request_body)
        when 'TRACE'
          httpChainWithHeaders.trace(user_request.url, :body => user_request.request_body)
        when 'PATCH'
          httpChainWithHeaders.patch(user_request.url, :body => user_request.request_body)
        end
    end
  end