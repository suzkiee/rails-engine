require 'rails_helper'

RSpec.describe "Item Merchant API" do
  context 'item merchant index' do
    it 'happy path: ' do
      merchant = create(:mock_merchant)
      create_list(:mock_item, 25, merchant: merchant)
      
      get '/api/v1/items'

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].size).to eq(20)
    end
  end

end