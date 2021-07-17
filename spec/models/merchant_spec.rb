require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoice_items }
    it { should have_many :invoices }
    it { should have_many :transactions }
    it { should have_many :customers }
  end
end 