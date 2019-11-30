class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    render json: FavoriteCustomerSerializer.new(Merchant.favorite_customer)
  end
end
