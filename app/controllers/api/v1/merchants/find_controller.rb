class Api::V1::Merchants::FindController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by(request.query_parameters))
    # render_json_query("Merchant")
  end

  def index
    render json: MerchantSerializer.new(Merchant.where(request.query_parameters))
    # render_json_query("Merchant")
  end

  private

  def valid_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
