class Api::V1::Invoices::FindController < ApplicationController
  def show
    render_json_query("Invoice")
  end

  def index
    render_json_query("Invoice")
  end

  private

  def valid_params
    params.permit(:id, :status, :created_at, :updated_at, :merchant_id, :customer_id)
  end
end
