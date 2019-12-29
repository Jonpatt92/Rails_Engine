class Api::V1::Items::BestDayController < ApplicationController
  def show
    render json: BestDaySerializer.new(Item.best_day(item_id: params[:id]))
  end
end
