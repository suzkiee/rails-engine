require 'rails_helper'

RSpec.describe "Revenue API" do
  before(:each) do
    @merchant = create(:mock_merchant)
    @merchant_2 = create(:mock_merchant) 

    customer_1 = create(:mock_customer)
    customer_2 = create(:mock_customer)
    customer_3 = create(:mock_customer)

    item_1 = create(:mock_item, merchant: @merchant)
    item_2 = create(:mock_item, merchant: @merchant)
    item_3 = create(:mock_item, merchant: @merchant)

    @invoice_1 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_1, status: 'packaged')
    invoice_2 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_1, status: 'packaged')
    invoice_3 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_2, status: 'shipped')
    invoice_4 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_2, status: 'packaged')
    invoice_5 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'shipped')
    invoice_6 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_7 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_8 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_9 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_10 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_11 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_12 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_13 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_14 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_15 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_16 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_17 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_18 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_19 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')
    invoice_20 = create(:mock_invoice, merchant_id: @merchant.id, customer: customer_3, status: 'packaged')

    invoice_item_1 = create(:mock_invoice_item, item: item_1, invoice: @invoice_1, quantity: 18, unit_price: 1000.00)
    invoice_item_2 = create(:mock_invoice_item, item: item_2, invoice: invoice_2, quantity: 12, unit_price: 20000.99)
    invoice_item_3 = create(:mock_invoice_item, item: item_3, invoice: invoice_3, quantity: 5, unit_price: 24403.91)
    invoice_item_4 = create(:mock_invoice_item, item: item_1, invoice: invoice_4, quantity: 10, unit_price: 100)
    invoice_item_5 = create(:mock_invoice_item, item: item_2, invoice: invoice_5, quantity: 2, unit_price: 4000)
    invoice_item_6 = create(:mock_invoice_item, item: item_3, invoice: invoice_6, quantity: 5, unit_price: 80)
    invoice_item_7 = create(:mock_invoice_item, item: item_3, invoice: invoice_7, quantity: 5, unit_price: 80)
    invoice_item_8 = create(:mock_invoice_item, item: item_3, invoice: invoice_8, quantity: 5, unit_price: 80)
    invoice_item_9 = create(:mock_invoice_item, item: item_3, invoice: invoice_9, quantity: 5, unit_price: 80)
    invoice_item_10 = create(:mock_invoice_item, item: item_3, invoice: invoice_10, quantity: 5, unit_price: 80)
    invoice_item_11 = create(:mock_invoice_item, item: item_3, invoice: invoice_11, quantity: 5, unit_price: 80)
    invoice_item_12 = create(:mock_invoice_item, item: item_3, invoice: invoice_12, quantity: 5, unit_price: 80)
    invoice_item_13 = create(:mock_invoice_item, item: item_3, invoice: invoice_13, quantity: 5, unit_price: 80)
    invoice_item_14 = create(:mock_invoice_item, item: item_3, invoice: invoice_14, quantity: 5, unit_price: 80)
    invoice_item_15 = create(:mock_invoice_item, item: item_3, invoice: invoice_15, quantity: 5, unit_price: 80)
    invoice_item_16 = create(:mock_invoice_item, item: item_3, invoice: invoice_16, quantity: 5, unit_price: 80)
    invoice_item_17 = create(:mock_invoice_item, item: item_3, invoice: invoice_17, quantity: 5, unit_price: 80)
    invoice_item_18 = create(:mock_invoice_item, item: item_3, invoice: invoice_18, quantity: 5, unit_price: 80)
    invoice_item_19 = create(:mock_invoice_item, item: item_3, invoice: invoice_19, quantity: 5, unit_price: 80)
    invoice_item_20 = create(:mock_invoice_item, item: item_3, invoice: invoice_20, quantity: 5, unit_price: 80)

    transaction_1 = create(:mock_transaction, invoice: @invoice_1, result: 'success')
    transaction_2 = create(:mock_transaction, invoice: invoice_2, result: 'success')
    transaction_3 = create(:mock_transaction, invoice: invoice_3, result: 'success')
  end

  context 'revenue unshipped potential' do
    it 'happy path: returns 10 invoices by default' do
      get '/api/v1/revenue/unshipped'
      
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data].size).to eq(10)
      expect(body[:data].first[:id]).to eq("#{@invoice_1.id}")
      expect(body[:data].first[:type]).to eq("unshipped_order")
      expect(body[:data].first[:attributes][:potential_revenue]).to eq(18000.0)
    end

    it 'happy path: returns number of invoices according to quantity' do
      get '/api/v1/revenue/unshipped?quantity=15'
      
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data].size).to eq(15)
      expect(body[:data].first[:id]).to eq("#{@invoice_1.id}")
      expect(body[:data].first[:type]).to eq("unshipped_order")
      expect(body[:data].first[:attributes][:potential_revenue]).to eq(18000.0)
    end 

    it 'sad path: returns error message if quantity is 0 or lower' do
      get '/api/v1/revenue/unshipped?quantity=0'
      
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status)
      expect(body[:data]).to eq([])
    end
  end
  
  context 'revenue merchant total revenue' do
    it 'happy path: returns total revenue of given merchant' do
      merchant = Merchant.revenue(@merchant.id)

      get "/api/v1/revenue/merchants/#{@merchant.id}"

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data].first[:id]).to eq("#{@merchant.id}")
      expect(body[:data].first[:type]).to eq("merchant_name_revenue")
      expect(body[:data].first[:attributes][:name]).to eq("#{@merchant.name}")
      expect(body[:data].first[:attributes][:revenue]).to eq(merchant_revenue)
    end


  end

  context 'revenue merchants most revenue' do
    it 'happy path: returns all merchants with most revenue' do

      get "/api/v1/revenue/merchants"

      body = JSON.parse(response.body, symbolizes_names: true)
      require 'pry'; binding.pry

      expect()

    end
  end
end