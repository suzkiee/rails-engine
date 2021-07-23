class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  
  def self.rank_most_revenue(quantity = 10)
    joins(:invoices, :transactions, :invoice_items)
    .where("invoices.status = ? and transactions.result = ?", 'shipped', 'success')
    .select("items.*,
            sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .order(revenue: :desc)
    .group('items.id')
    .limit(quantity)
  end

  private 
    def self.search(search_params)
      where("name ILIKE ?", "%#{search_params}%")
    end
end
