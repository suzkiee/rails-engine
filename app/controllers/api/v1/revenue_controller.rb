class Api::V1::RevenueController < ApplicationController

  def unshipped_potential
    if params[:quantity].present?
      invoices = Invoice.potential_revenue(params[:quantity])
    else 
      invoices = Invoice.potential_revenue
    end

    render json: UnshippedSerializer.new(invoices)
  end

  def merchant_total_revenue
    merchant = Merchant.merchant_revenue(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end

  def merchants_most_revenue
    merchants = Merchant.most_revenue
    render json: MerchantsRevenueSerializer.new(merchants)
  end

  def items_revenue_ranked 
    items = Items.rank_most_revenue 
    render json: ItemsRevenueSerializer.new(items)
  end
end