require 'webmock/rspec'
RSpec.configure do |config|
    config.before(:each) do
        stub_request(:get, /passtest.com/).
            to_return(status: 200, body: "get", headers: {})

        stub_request(:get, /passtest.com/).
            with(headers: { 'req-hdr' => '1' }).
            to_return(status: 200, body: "get with headers", headers: { 'res-hdr' => '1' })
        
        stub_request(:post, /passtest.com/).
            to_return(status: 200, body: "post", headers: {})

        stub_request(:post, /passtest.com/).
            with(body: "params").
            to_return(status: 201, body: "post with body", headers: {})

        stub_request(:delete, /passtest.com/).
            to_return(status: 405, body: "delete", headers: {})

        stub_request(:get, /failtest.com/).to_raise(StandardError)
        
        stub_request(:post, /failtest.com/).to_timeout

    end
  end