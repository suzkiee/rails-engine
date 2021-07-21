require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
  end
  
  describe 'instance methods' do
    describe "::most_revenue" do
      it 'returns merchant with most revenue' do
        merchant_1 = create(:mock_merchant)
        merchant_2 = create(:mock_merchant)
        merchant_3 = create(:mock_merchant)
  
        customer_1 = create(:mock_customer)
        customer_2 = create(:mock_customer)
        customer_3 = create(:mock_customer)
  
        item_1 = create(:mock_item, merchant: merchant_1)
        item_2 = create(:mock_item, merchant: merchant_2)
        item_3 = create(:mock_item, merchant: merchant_3)
  
        invoice_1 = create(:mock_invoice, merchant: merchant_1, customer: customer_1, status: 'shipped')
        invoice_2 = create(:mock_invoice, merchant: merchant_2, customer: customer_2, status: 'shipped')
        invoice_3 = create(:mock_invoice, merchant: merchant_3, customer: customer_3, status: 'shipped')
  
        invoice_item_1 = create(:mock_invoice_item, item: item_1, invoice: invoice_1, quantity: 12, unit_price: 1)
        invoice_item_2 = create(:mock_invoice_item, item: item_2, invoice: invoice_2, quantity: 20, unit_price: 2)
        invoice_item_3 = create(:mock_invoice_item, item: item_3, invoice: invoice_3, quantity: 10, unit_price: 3)
  
        transaction_1 = create(:mock_transaction, invoice: invoice_1, result: 'success')
        transaction_2 = create(:mock_transaction, invoice: invoice_2, result: 'success')
        transaction_3 = create(:mock_transaction, invoice: invoice_3, result: 'success')
        
        first = Merchant.most_revenue.first
        last = Merchant.most_revenue.last

        expect(first.id).to eq(merchant_2.id)
        expect(first.name).to eq(merchant_2.name)
        expect(first.revenue).to eq(merchant_2.revenue)
        
        expect(last.id).to eq(merchant_1.id)
        expect(last.name).to eq(merchant_1.name)
        expect(last.revenue).to eq(merchant_1.revenue)
      end
    end
  end

  describe 'instance methods' do
    describe '#revenue' do
      it 'returns the revenue according of given merchant' do
        merchant = create(:mock_merchant)

        customer_1 = create(:mock_customer)
        customer_2 = create(:mock_customer)
        customer_3 = create(:mock_customer)

        item_1 = create(:mock_item, merchant: merchant)
        item_2 = create(:mock_item, merchant: merchant)
        item_3 = create(:mock_item, merchant: merchant)

        invoice_1 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_1, status: 'shipped')
        invoice_2 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_2, status: 'shipped')
        invoice_3 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'shipped')

        invoice_item_1 = create(:mock_invoice_item, item: item_1, invoice: invoice_1, quantity: 18, unit_price: 1000.00)
        invoice_item_2 = create(:mock_invoice_item, item: item_2, invoice: invoice_2, quantity: 12, unit_price: 20000.99)
        invoice_item_3 = create(:mock_invoice_item, item: item_3, invoice: invoice_3, quantity: 5, unit_price: 24403.91)
  
        transaction_1 = create(:mock_transaction, invoice: invoice_1, result: 'success')
        transaction_2 = create(:mock_transaction, invoice: invoice_2, result: 'success')
        transaction_3 = create(:mock_transaction, invoice: invoice_3, result: 'success')
        
        expect(merchant.revenue).to eq(380031.43)
      end
    end
  end
end
