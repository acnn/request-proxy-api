module Response
    def method_not_allowed()
        head :method_not_allowed
    end
    def relay_response(source_response, status = :ok)
        source_response.headers.each do |key, value|
            response.set_header(key, value)
        end
        render body: source_response.body.to_s, status: status
    end
  end