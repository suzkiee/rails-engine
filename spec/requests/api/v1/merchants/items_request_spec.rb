require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  context 'merchant items index' do
    merchant = create(:merchant)
    create_list(:item, 10, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(body[:data].size).to eq(10)
    expect(body[:data].first[:attributes][:name]).to eq(Item.first.name)
    expect(body[:data].last[:attributes][:name]).to eq(Item.last.name)
  end
end