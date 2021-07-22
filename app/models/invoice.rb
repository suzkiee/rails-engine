class Invoice < ApplicationRecord
  validates :status, presence: true
  
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy
  has_many :merchants, through: :items

  def self.potential_revenue
    joins(:invoice_items)
    .select("invoices.id as id, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .where.not(status: 'shipped')
    .group(:id)
  end
end
