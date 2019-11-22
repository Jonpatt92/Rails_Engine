class Api::V1::Merchants::FindController < ApplicationController
# Need to make searches case insensitive
  def show
    render json: MerchantSerializer.new(Merchant.find_by(valid_params))
  end

  def index
    render json: MerchantSerializer.new(Merchant.where(valid_params))
  end

  private

  def valid_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
  
end
