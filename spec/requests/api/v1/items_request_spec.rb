require 'rails_helper'

RSpec.describe "Items API" do
  before(:all) do
    @merchant = create(:mock_merchant)
  end

  context 'items index' do
    it 'sends 20 items max' do
      create_list(:mock_item, 25, merchant: @merchant)
 
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

  context 'items create' do
    it "happy path: can create a new item" do
      post "/api/v1/items", params: {
        name: 'test',
        description: 'test description',
        unit_price: 12, 
        merchant_id: @merchant.id
      }

      new_item = JSON.parse(response.body, symbolize_names: true)
      item = Item.find(new_item[:id])

      expect(response).to be_successful
      expect(new_item[:name]).to eq(item[:name])
      expect(new_item[:description]).to eq(item[:description])
      expect(new_item[:unit_price]).to eq(item[:unit_price])
      expect(new_item[:merchant_id]).to eq(@merchant.id)
    end

    it "sad path: can't create item without all params" do
      post '/api/v1/items', params: {
        name: 'test',
        description: "test"
      }
   
      expect(response.status).to eq(400)

      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(body[:message]).to eq("Invalid")
      expect(body[:errors]).to include("can't be blank")
      expect(body[:errors]).to include("must exist")
    end
  end

  context 'items update' do
    it 'happy path: can update an existing item' do
      id = create(:mock_item, merchant: @merchant).id
      previous = Item.last.name
      patch "/api/v1/items/#{id}", params: {
        name: "updated"
      }

      updated = Item.find_by(id: id)
      expect(response).to be_successful
      expect(updated.name).to_not eq(previous)
      expect(updated.name).to eq("updated")
    end
  end
end