require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end
  
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant } 
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "class methods" do
    describe '::potential_revenue' do
      it 'returns potential revenue of invoices' do
        merchant = create(:mock_merchant)

        customer_1 = create(:mock_customer)
        customer_2 = create(:mock_customer)
        customer_3 = create(:mock_customer)

        item_1 = create(:mock_item, merchant: merchant)
        item_2 = create(:mock_item, merchant: merchant)
        item_3 = create(:mock_item, merchant: merchant)

        invoice_1 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_1, status: 'packaged')
        invoice_2 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_1, status: 'packaged')
        invoice_3 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_2, status: 'shipped')
        invoice_4 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_2, status: 'packaged')
        invoice_5 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'shipped')
        invoice_6 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')
        invoice_7 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')
        invoice_8 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')
        invoice_9 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')
        invoice_10 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')
        invoice_11 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')
        invoice_12 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')
        invoice_13 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_3, status: 'packaged')

        invoice_item_1 = create(:mock_invoice_item, item: item_1, invoice: invoice_1, quantity: 18, unit_price: 1000.00)
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
      
        transaction_1 = create(:mock_transaction, invoice: invoice_1, result: 'success')
        transaction_2 = create(:mock_transaction, invoice: invoice_2, result: 'success')
        transaction_3 = create(:mock_transaction, invoice: invoice_3, result: 'success')

        first = Invoice.potential_revenue.first

        expect(first.id).to eq(invoice_1.id)
        expect(first.potential_revenue).to eq(18000.0)
      end
    end
  end
end
