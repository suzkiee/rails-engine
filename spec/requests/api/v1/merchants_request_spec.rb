require 'rails_helper'

RSpec.describe "Merchants API" do
  before(:all) do
    @merchant = create(:mock_merchant)
  end

  context 'merchant index' do
    before(:each) do
      create_list(:mock_merchant, 500)
    end

    it 'sends 20 merchants max by default' do    
      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].size).to eq(20)
    end

    it 'takes limit param and returns corresponding number of items' do
      get '/api/v1/merchants', params: { per_page: 50 }

      body = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to be_successful
      expect(body[:data].size).to eq(50)
    end
    
    it 'takes page params' do
      get '/api/v1/merchants', params: { page: 2 }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data].size).to eq(20)
    end

    it 'takes both page and limit params' do
      get '/api/v1/merchants', params: { per_page: 33, page: 2 }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data].size).to eq(33)
    end
  end

  context 'merchant show' do
    it 'happy path: can find a single merchant' do
      create_list(:mock_merchant, 25)
      merchant = Merchant.first
      get "/api/v1/merchants/#{merchant.id}"
      
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      expect(body[:data][:id]).to eq("#{merchant.id}")
      expect(body[:data][:type]).to eq("merchant")
      expect(body[:data][:attributes][:name]).to eq(merchant.name)
    end

    it 'sad path: cannot find the merchant' do
      id = 0
      get "/api/v1/merchants/#{id}"
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:message]).to eq 'Not Found'
      expect(body[:errors]).to include 'Could not find merchant with id#0'
      expect(response.status).to eq(404)
    end
  end
end