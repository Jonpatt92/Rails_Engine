class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    customer = Customer.find(params[:id])

    render json: FavoriteMerchantSerializer.new(
      customer.favorite_merchant, {
        params: {
          customer_name:
            (customer.first_name + " " + customer.last_name)
    }})
  end
end
