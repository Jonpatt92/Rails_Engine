class Api::V1::MerchantsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end
end
