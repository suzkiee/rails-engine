require 'rails_helper'

RSpec.describe "Items API" do
  context 'get all items' do
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

    context 'items create' do
      it "can create a new item" do 
        item_params = ({
          name: Faker::Commerce.product_name,
          description: Faker::Hipster.paragraph,
          unit_price: Faker::Number.within(range: 1..1000)
        })
        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/items", headers: headers, params: JSON.generate(book: item_params)
        new_item = Item.last

        expect(response).to be_successful
        expect(new_item.name).to eq(item_params[:name])
        expect(new_item.description).to eq(item_params[:description])
        expect(new_item.unit_price).to eq(item_params[:unit_price])
      end
    end
  end
end