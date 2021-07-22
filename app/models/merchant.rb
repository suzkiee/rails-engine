class Merchant < ApplicationRecord
  validates :name, presence: true
  
  has_many :items, dependent: :destroy  
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def revenue
    invoices
    .joins(:transactions)
    .joins(:invoice_items)
    .where("transactions.result = 'success' AND invoices.status = 'shipped'")
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.most_revenue
    joins(:transactions, :invoice_items)
    .select("merchants.name as name,
             merchants.id as id,
             sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .group(:name, :id)
    .order(revenue: :desc)
    .where("invoices.status = ? and transactions.result = ?", 'shipped', 'success')
  end

  def self.find(search_params)
    where("name ILIKE ?", "%#{search_params}%").first
  end
end
