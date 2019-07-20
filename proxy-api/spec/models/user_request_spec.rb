require 'rails_helper'

RSpec.describe UserRequest, type: :model do
  it { should validate_presence_of(:client_id) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:http_method) }
end
