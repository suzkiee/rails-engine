class Api::V1::RevenueController < ApplicationController

  def unshipped_potential
    if params[:quantity].present?
      invoices = Invoice.potential_revenue(params[:quantity])
    else 
      invoices = Invoice.potential_revenue
    end
    render json: UnshippedSerializer.new(invoices)
  end
end