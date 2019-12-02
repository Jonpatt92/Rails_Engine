class Api::V1::Items::FindController < ApplicationController
  def show
    render_json_query("Item")
    # render_find_by("Item")
  end

  def index
    render_json_query("Item")
    # render_find_all_by("Item")
  end

  private

  def valid_params
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at)
  end
end
