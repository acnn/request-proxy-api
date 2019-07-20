require 'rails_helper'

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
        # valid payload
        let(:valid_attributes) { { client_id: 'xyz', url: 'https://www.google.com/', headers: '', http_method: 'GET', request_body: '' } }
    
        context 'when the request is valid' do
          before { post '/proxy', params: valid_attributes }
    
          it 'returns status code 200 OK' do
            expect(response).to have_http_status(200)
          end
        end 

      end

end