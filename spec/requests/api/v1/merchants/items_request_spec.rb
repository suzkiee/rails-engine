require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  context 'merchant items index' do
    it 'happy path: returns all items belonging to merchant' do
      merchant = create(:mock_merchant)
      create_list(:mock_item, 10, merchant: merchant)
      items = merchant.items

      get "/api/v1/merchants/#{merchant.id}/items"
    
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data].size).to eq(10)
      expect(body[:data].first[:attributes][:name]).to eq(items.first.name)
      expect(body[:data].last[:attributes][:name]).to eq(items.last.name)
    end

    it 'sad path: cannot find merchant' do
      id = 0
      get "/api/v1/merchants/#{id}/items"
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:message]).to eq 'Not Found'
      expect(body[:errors]).to include 'Could not find merchant with id#0'
      expect(response.status).to eq(404)
    end
  end
end