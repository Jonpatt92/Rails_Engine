class Api::V1::Transactions::FindController < ApplicationController
  def show
    render_json_query("Transaction")
    # render_find_by("Transaction")
  end

  def index
    render_json_query("Transaction")
    # render_find_all_by("Transaction")
  end

  private

  def valid_params
    params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at, :invoice_id)
  end
end
