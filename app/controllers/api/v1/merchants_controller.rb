class Api::V1::MerchantsController < ApplicationController
  MERCHANTS_PER_PAGE = 20

  def index
    page = params.fetch(:page, 1).to_i
    merchants = Merchant.offset((page - 1) * MERCHANTS_PER_PAGE).limit(MERCHANTS_PER_PAGE)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant) 

  rescue ActiveRecord::RecordNotFound
    render json: {
      message: 'Not Found',
      errors: ["Could not find merchant with id##{params[:id]}"]
    }, status: :not_found
  end
end