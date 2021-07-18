class Api::V1::ItemsController < ApplicationController
  ITEMS_PER_PAGE = 20
  def index
    render json: Item.offset(0).limit(ITEMS_PER_PAGE)
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  end

  private 
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end