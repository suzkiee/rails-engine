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
    .where("transactions.result = 'success' and invoices.status = 'shipped'")
    .sum('invoice_items.quantity * invoice_items.unit_price')
    
    # invoices
    # .joins(:transactions)
    # .joins(:invoice_items)
    # .where("invoices.status = 'shipped' and transactions.result = 'success'")
    # .select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue,
    #                     items.merchant_id as merchant_id")
    # .group('items.merchant_id')
  end
end
