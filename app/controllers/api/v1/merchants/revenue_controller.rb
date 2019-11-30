class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(
      Merchant.total_revenue(params[:date]),
      {params: {date_specified: params[:date]}})
  end

end
