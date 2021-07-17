require 'rails_helper'

RSpec.describe "Items API" do
  describe 'get all items' do
    it 'sends 20 items max' do
      merchant = create(:mock_merchant)
      create_list(:mock_item, 25, merchant: merchant)
 
      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      
      expect(items.size).to eq(20)
      
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(Integer)

        expect(item).to have_key(:merchant_id)
        expect(item[:merchant_id]).to be_an(Integer)

        expect(item).to have_key(:name)
        expect(item[:name]).to be_an(String)

        expect(item).to have_key(:description)
        expect(item[:description]).to be_an(String)
      end
    end
  end
end