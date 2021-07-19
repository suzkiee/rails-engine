class Api::V1::ItemsController < ApplicationController
  ITEMS_PER_PAGE = 20

  def index
    page = params.fetch(:page, 1).to_i
    items = Item.offset(page * ITEMS_PER_PAGE).limit(ITEMS_PER_PAGE)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item), status: 200

    rescue ActiveRecord::RecordNotFound
      render json: {
        message: 'Not Found',
        errors: ["Could not find item with id##{params[:id]}"]
      }, status: :not_found
  end

  def create
    item = Item.new(item_params)

    if item.save 
      render json: ItemSerializer.new(item), status: 201, status: :created
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
      render json: ItemSerializer.new(@item), status: 201
    end 

    rescue ActiveRecord::RecordNotFound
      render json: {
        message: 'Not Found',
        errors: ["Could not find item with id##{params[:id]}"]
      }, status: :not_found
  end

  def destroy
    render json: Item.delete(params[:id])

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