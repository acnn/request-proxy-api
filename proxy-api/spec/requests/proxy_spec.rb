require 'rails_helper'
require 'helpers/webmock_helper'

RSpec.describe 'Proxy API', type: :request do

    describe 'GET /proxy' do
        before { get "/proxy" }
    
        it 'returns status code 405 Method Not Allowed' do
          expect(response).to have_http_status(405)
        end
    end

    describe 'GET /proxy/:id' do
        before { get "/proxy/1" }
    
        it 'returns status code 405 Method Not Allowed' do
          expect(response).to have_http_status(405)
        end
    end

    describe 'PUT /proxy/:id' do
        before { put "/proxy/1" }
    
        it 'returns status code 405 Method Not Allowed' do
          expect(response).to have_http_status(405)
        end
    end

    describe 'DELETE /proxy/:id' do
        before { delete "/proxy/1" }
    
        it 'returns status code 405 Method Not Allowed' do
          expect(response).to have_http_status(405)
        end
    end

    describe 'POST /proxy' do
        
        valid_requests = [
            {
                ip: { client_id: 'xyz', url: 'https://www.passtest.com/', headers: '', http_method: 'GET', request_body: '' },
                op: { status: 200, headers: {}, body: 'get' } 
            },
            {
                ip: { client_id: 'xyz', url: 'https://www.passtest.com/', headers: '{ "req-hdr": "1" }', http_method: 'GET', request_body: '' },
                op: { status: 200, headers: { 'res-hdr' => '1' }, body: 'get with headers' } 
            },
            {
                ip: { client_id: 'xyz', url: 'https://www.passtest.com/', headers: '', http_method: 'POST', request_body: '' },
                op: { status: 200, headers: {}, body: 'post' } 
            },
            {
                ip: { client_id: 'xyz', url: 'https://www.passtest.com/', headers: '', http_method: 'POST', request_body: 'params' },
                op: { status: 201, headers: {}, body: 'post with body' } 
            },
            {
                ip: { client_id: 'xyz', url: 'https://www.passtest.com/', headers: '', http_method: 'DELETE', request_body: '' },
                op: { status: 405, headers: {}, body: 'delete' } 
            }
        ]

        invalid_requests = [
            {
                ip: { client_id: 'xyz', url: '', headers: '', http_method: 'GET', request_body: '' },
                op: { status: 422, headers: {}, body: '' } 
            },
            {
                ip: { client_id: 'xyz', url: 'https://www.failtest.com/', headers: '', http_method: 'GET', request_body: '' },
                op: { status: 500, headers: {}, body: '' } 
            },
            {
                ip: { client_id: 'xyz', url: 'https://www.failtest.com/', headers: '', http_method: 'POST', request_body: '' },
                op: { status: 408, headers: {}, body: '' } 
            }
        ]
        
        valid_requests.each do |valid_request|
            context 'when the request is valid' do
                before { post '/proxy', params: valid_request[:ip] }
                it 'returns relay response' do
                    expect(response).to have_http_status(valid_request[:op][:status])
                    if !valid_request[:op][:headers]['res-hdr'].nil?
                        expect(response.headers['res-hdr']).to eq(valid_request[:op][:headers]['res-hdr'])  
                    end
                    expect(response.body).to eq(valid_request[:op][:body])                
                end
            end
        end
        
        invalid_requests.each do |invalid_request|
            context 'when the request is invalid' do
                before { post '/proxy', params: invalid_request[:ip] }
        
                it 'returns error response' do
                    expect(response).to have_http_status(invalid_request[:op][:status])
                end
            end
        end

    end

end