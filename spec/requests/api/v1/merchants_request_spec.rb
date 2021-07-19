require 'rails_helper'

RSpec.describe "Items API" do
  before(:all) do
    @merchant = create(:mock_merchant)
  end

  context 'merchant index' do
    it 'sends 20 merchants max' do
      create_list(:mock_merchant, 25)
      
      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].size).to eq(20)
    end
  end
end