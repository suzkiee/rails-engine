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

      expect(items[:data].size).to eq(20)
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
      item = Item.find(new_item[:data][:id])

      expect(response).to be_successful
      expect(new_item[:data][:attributes][:name]).to eq(item.name)
      expect(new_item[:data][:attributes][:description]).to eq(item.description)
      expect(new_item[:data][:attributes][:unit_price]).to eq(item.unit_price)
      expect(new_item[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
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

  context 'items edit' do
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

    it 'sad path: cannot update item that cannot be found' do 
      id = 0
      patch "/api/v1/items/#{id}", params: {
        name: "updated"
      }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:message]).to eq 'Not Found'
      expect(body[:errors]).to include 'Could not find item with id#0'
      expect(response.status).to eq(404)
    end
  end

  context 'items delete' do
    it 'happy path: can destroy an item' do
      item = create(:mock_item, merchant: @merchant)

      expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
      expect(response).to be_successful
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'sad path: cannot find item to destroy' do
      item_id = 0 
      
      expect{ delete "/api/v1/items/#{item_id}" }.to change(Item, :count).by(0)
    end
  end

  context 'item show' do
    it 'happy path: can find a single item' do
      create_list(:mock_item, 5, merchant: @merchant)
      item = Item.first
      get "/api/v1/items/#{item.id}"
      
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data][:id]).to eq("#{item.id}")
      expect(body[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
      expect(body[:data][:attributes][:name]).to eq(item.name)
      expect(body[:data][:attributes][:description]).to eq(item.description)
      expect(body[:data][:attributes][:unit_price]).to eq(item.unit_price)
    end

    it 'sad path: cannot find the item' do
      id = 0
      get "/api/v1/items/#{id}"
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:message]).to eq 'Not Found'
      expect(body[:errors]).to include 'Could not find item with id#0'
      expect(response.status).to eq(404)
    end
  end
end