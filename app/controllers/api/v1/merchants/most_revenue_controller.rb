class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    render json: MostRevenueSerializer.new(Merchant.most_revenue(params["quantity"]))
  end
end
