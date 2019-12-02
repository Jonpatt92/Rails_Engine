class Api::V1::Transactions::FindController < ApplicationController
  def show
    render_json_query("Transaction")
  end

  def index
    render_json_query("Transaction")
  end

  private

  def valid_params
    params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at, :invoice_id)
  end
end
