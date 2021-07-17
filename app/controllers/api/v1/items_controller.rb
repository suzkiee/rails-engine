class Api::V1::ItemsController < ApplicationController
  ITEMS_PER_PAGE = 20
  def index
    render json: Item.offset(0).limit(ITEMS_PER_PAGE)
  end
end