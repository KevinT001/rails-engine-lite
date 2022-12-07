class Api::V1::ItemsController < ApplicationController

  def index
        render json: ItemSerializer.new(Item.all)
  end

  def show 
    # render json: Item.find(params[:id]) 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    # render json: Item.create(item_params)

    render json: ItemSerializer.new(Item.create(item_params))
  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :description, :unit_price, :merchant_id)
  end


end 