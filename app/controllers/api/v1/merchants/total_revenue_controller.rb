class Api::V1::Merchants::TotalRevenueController < ApplicationController
  def show
    render json: TotalRevenueSerializer.new(
      Merchant.total_revenue(params[:date]),
      {params: {date_specified: params[:date]}})
  end

end
