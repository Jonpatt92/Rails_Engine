class Api::V1::Customers::FindController < ApplicationController
  def show
    render_json_query("Customer")
    # render_find_by("Customer")
  end

  def index
    render_json_query("Customer")
    # render_find_all_by("Customer")
  end

  private

  def valid_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
