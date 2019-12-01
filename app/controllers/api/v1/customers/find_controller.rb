class Api::V1::Customers::FindController < ApplicationController
  def show
    render_json_query("Customer")
  end

  def index
    render_json_query("Customer")
  end

  private

  def valid_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
