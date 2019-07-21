require 'rails_helper'

RSpec.describe UserRequest, type: :model do

  valid_urls = [
    'https://www.google.com', 
    'https://google.com', 
    'https://drive.google.com', 
    'https://www.reqres.com:3000/api/post', 
    'https://www.bigapi.com/api/v1/items?itemid=1&itemname=test',
    'https://m.fb.in/mapi/users?name=test%20name',
    'https://www.newsite.build/jobs/',
    'https://www1.newsite123.build/jobs/',
    'https://en.wikipedia.org/wiki/Möbius_strip',
    'https://zh.wikipedia.org/wiki/Wikipedia:%E5%85%B3%E4%BA%8E%E4%B8%AD%E6%96%87%E7%BB%B4%E5%9F%BA%E7%99%BE%E7%A7%91/en'
  ]

  invalid_urls = [
    'http://www.google.com',
    'https://www.google/com',
    'htttps://www.yahoo.com',
    'https://www.reddit,com',
    'www.google.com'
  ]

  valid_http_methods = ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'HEAD', 'CONNECT', 'TRACE', 'PATCH']

  invalid_http_methods = ['get', 'Post', 'pUT', 'HEAD ', 'INSERT', 'REQUEST']

  context "for client id" do
    it { should validate_presence_of(:client_id) }
  end

  context "for url" do
    it { should validate_presence_of(:url) }

    context "when url is valid" do
      valid_urls.each do |valid_url|
        it { should allow_value(valid_url).for(:url) }
      end
    end

    context "when url is invalid" do
      invalid_urls.each do |invalid_url|
        it { should_not allow_value(invalid_url).for(:url) }
      end
    end

  end

  context "for http method" do
    it { should validate_presence_of(:http_method) }

    context "when http method is valid" do
      valid_http_methods.each do |valid_http_method|
        it { should allow_value(valid_http_method).for(:http_method) }
      end
    end

    context "when http method is invalid" do
      invalid_http_methods.each do |invalid_http_method|
        it { should_not allow_value(invalid_http_method).for(:http_method) }
      end
    end

  end

end
