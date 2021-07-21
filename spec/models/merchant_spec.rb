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
