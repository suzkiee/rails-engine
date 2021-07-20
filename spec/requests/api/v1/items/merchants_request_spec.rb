require 'rails_helper'

RSpec.describe "Item Merchant API" do
  context 'item merchant index' do
    it 'happy path: can find item/s merchant' do
      merchant = create(:mock_merchant)
      item = create(:mock_item, merchant: merchant)
      
      get "/api/v1/items/#{item.id}/merchants" 

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data][:id]).to eq(merchant.id.to_s)
    end

    # this test is actually instantiating a merchant
    xit 'sad path: cannot find item/s merchant' do
      merchant = create(:mock_merchant)
      item = create(:mock_item, merchant: merchant)

      get "/api/v1/items/#{item.id}/merchants" 

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(body[:message]).to eq 'Not Found'
      expect(body[:errors]).to include 'Could not find merchant with id#0'
      expect(response.status).to eq(404)
    end
  end
end