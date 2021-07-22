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
  end
end
