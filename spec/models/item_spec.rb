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
    describe "::search" do
      it 'returns items that match name query' do
        merchant = create(:mock_merchant)
        create_list(:mock_item, 5, merchant: merchant)
        item = create(:mock_item, merchant: merchant, name: "Turing")
        item_2 = create(:mock_item, merchant: merchant, name: "Ring Toss")
       
        expect(Item.search("ring")).to eq([item, item_2])
      end
    end

    describe '::rank_most_revenue' do
      it 'returns items with the most revenue' do
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

        invoice_item_1 = create(:mock_invoice_item, item: item_1, invoice: invoice_1, quantity: 10, unit_price: 1)
        invoice_item_2 = create(:mock_invoice_item, item: item_2, invoice: invoice_2, quantity: 10, unit_price: 2)
        invoice_item_3 = create(:mock_invoice_item, item: item_3, invoice: invoice_3, quantity: 10, unit_price: 3)

        transaction_1 = create(:mock_transaction, invoice: invoice_1, result: 'success')
        transaction_2 = create(:mock_transaction, invoice: invoice_2, result: 'success')
        transaction_3 = create(:mock_transaction, invoice: invoice_3, result: 'success')
        
        expect(Item.rank_most_revenue).to eq([item_3, item_2, item_1])
      end
    end
  end
end
