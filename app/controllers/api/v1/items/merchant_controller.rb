class Api::V1::Items::MerchantController < ApplicationController
  
  def index
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.new(item.merchant)
 
    rescue ActiveRecord::RecordNotFound
      render json: {
        message: 'Not Found',
        errors: ["Could not find merchant with id##{params[item.merchant.id]}"]
      }, status: :not_found
  end
end