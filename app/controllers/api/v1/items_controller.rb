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
    
    render json: ItemSerializer.new(Item.create(item_params), status: 201)
  end

  def update
      # merchant = Merchant.find(params[:merchant_id])
      # item = Item.find(params[:id])

      # Item.update(item_params)
      
        Merchant.find(params[:item][:merchant_id]) if params[:item][:merchant_id] 
    # if Merchant(params[:merchant_id]).exists?
      render json: ItemSerializer.new(Item.update(params[:id], item_params))

    # else 
    #   render json: { error: 'Error Message' }, status: 404 
    # end
  end 


  private

  def item_params
    params.require(:item).permit(:id, :name, :description, :unit_price, :merchant_id)
  end


end 