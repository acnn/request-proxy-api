FactoryBot.define do
    factory :todo do
      client_id { Faker::Lorem.word }
      url { Faker::Lorem.word }
      headers { Faker::Lorem.word }
      http_method { Faker::Lorem.word }
      request_body { Faker::Lorem.word }
    end
  end