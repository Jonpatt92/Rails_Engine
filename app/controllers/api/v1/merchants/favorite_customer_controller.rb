class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: FavoriteCustomerSerializer.new(merchant.favorite_customer,
    {params: {merchant_name: merchant.name}})
  end
end
