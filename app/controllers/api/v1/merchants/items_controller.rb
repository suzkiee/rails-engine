class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    items = Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(items)
    
    rescue ActiveRecord::RecordNotFound
    render json: {
      message: 'Not Found',
      errors: ["Could not find merchant with id##{params[:merchant_id]}"]
    }, status: :not_found
  end
end