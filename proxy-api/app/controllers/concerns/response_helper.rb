module ResponseHelper
    DEFAULT_MESSAGES = {
        'WELCOME_MESSAGE' => 'Welcome to Proxy API. Please POST your request to /proxy for using the service.',
        'METHOD_NOT_ALLOWED' => 'The API does not support the requested HTTP method',
        'ALLOWED_METHODS' => 'POST',
        'TIMED_OUT' => 'The URL you are requesting did not respond in a timely fashion',
        'INVALID_PARAMS' => 'One or more request parameters are invalid',
        'RATE_LIMIT' => 'You have exceeded the allowed number of requests per minute',
        'SERVER_ERROR' => 'An unexpected error occurred'
    }

    #instruct the user to post to /proxy instead of root
    def welcome_response(errorMessage = DEFAULT_MESSAGES['WELCOME_MESSAGE'])
        render body: errorMessage, status: :ok
    end

    #405 - for any GET, PUT or DELETE requests
    def method_not_allowed_response(errorMessage = DEFAULT_MESSAGES['METHOD_NOT_ALLOWED'], allowedMethods = DEFAULT_MESSAGES['ALLOWED_METHODS'])
        response.headers['Allow'] = allowedMethods
        render json: { error: errorMessage }, status: :method_not_allowed
    end

    #408 - request timed out
    def request_timeout_response(errorMessage = DEFAULT_MESSAGES['TIMED_OUT'])
        render json: { error: errorMessage }, status: :request_timeout
    end

    #422 - input is semantically incorrect
    def unprocessable_entity_response(errorMessage = DEFAULT_MESSAGES['INVALID_PARAMS'])
        render json: { error: errorMessage }, status: :unprocessable_entity
    end

    #429 - rate limiter - too many requests
    def rate_limiter_response(errorMessage = DEFAULT_MESSAGES['RATE_LIMIT'])
        render json: { error: errorMessage }, status: 429
    end

    #500 - server error - any unhandler errors
    def server_error_response(errorMessage = DEFAULT_MESSAGES['SERVER_ERROR'])
        render json: { error: errorMessage }, status: :internal_server_error
    end

    def relay_response(source_response)
        source_response.headers.each do |key, value|
            response.set_header(key, value)
        end
        render body: source_response.body.to_s, status: source_response.status
    end
  end