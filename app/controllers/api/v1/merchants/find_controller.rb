class Api::V1::Merchants::FindController < ApplicationController

  def show
    # render_json("Merchant")
    render_find_by("Merchant")
  end

  def index
    # render_json("Merchant")
    render_find_all_by("Merchant")
  end

  private

  def valid_params
    params.permit(:id, :name, :created_at, :updated_at)
  end

end
