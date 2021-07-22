require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end
  
  describe 'relationships' do
    it { should belong_to :merchant  }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'class methods' do
    describe "::rank_most_revenue" do
      xit 'returns items ranked by revenue' do
        # merchant = create(:mock_merchant)
        # merchant_2 = create(:mock_merchant)

        # item_1 = create(:mock_item, merchant: merchant)
        # item_2 = create(:mock_item, merchant: merchant)
        # item_3 = create(:mock_item, merchant: merchant_2)

        # customer_1 = create(:mock_customer)
        # customer_2 = create(:mock_customer)
        # customer_3 = create(:mock_customer)

        # invoice_1 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_1)
        # invoice_2 = create(:mock_invoice, merchant_id: merchant.id, customer: customer_2)
        # invoice_3 = create(:mock_invoice, merchant_id: merchant_2.id, customer: customer_3)

        # invoice_item_1 = create(:mock_invoice_item, item: item_1, invoice: invoice_1, quantity: 18, unit_price: 1000.00)
        # invoice_item_2 = create(:mock_invoice_item, item: item_1, invoice: invoice_2, quantity: 12, unit_price: 20000.99)
        # invoice_item_3 = create(:mock_invoice_item, item: item_2, invoice: invoice_3, quantity: 5, unit_price: 24403.91)
  
        # transaction_1 = create(:mock_transaction, invoice: invoice_1, result: 'success')
        # transaction_2 = create(:mock_transaction, invoice: invoice_2, result: 'success')
        # transaction_3 = create(:mock_transaction, invoice: invoice_3, result: 'success')
        
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
  
        invoice_item_1 = create(:mock_invoice_item, item: item_1, invoice: invoice_1, unit_price: 1)
        invoice_item_2 = create(:mock_invoice_item, item: item_2, invoice: invoice_2, unit_price: 2)
        invoice_item_3 = create(:mock_invoice_item, item: item_3, invoice: invoice_3, unit_price: 3)
  
        transaction_1 = create(:mock_transaction, invoice: invoice_1, result: 'success')
        transaction_2 = create(:mock_transaction, invoice: invoice_2, result: 'success')
        transaction_3 = create(:mock_transaction, invoice: invoice_3, result: 'success')
        require 'pry'; binding.pry
        expect(Item.rank_most_revenue).to eq(0)
      end
    end
  end
end
