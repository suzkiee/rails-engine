class Api::V1::ItemsController < ApplicationController
  ITEMS_PER_PAGE = 20
  def index
    render json: Item.offset(0).limit(ITEMS_PER_PAGE)
  end

  def create
    item = Item.new(item_params)
    if item.save 
      render json: item, status: :created
    else 
      render json: {
        message: 'Invalid',
        errors: item.errors.map { |_attr, msg| msg }
      }, status: :bad_request
    end
  end

  def update 
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: item 
    end 

    rescue ActiveRecord::RecordNotFound
      render json: {
        message: 'Not Found',
        errors: ["Could not find item with id##{params[:id]}"]
      }, status: :not_found
  end

  private 
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end