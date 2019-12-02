class Api::V1::InvoiceItems::FindController < ApplicationController
  def show
    render_json_query("InvoiceItem")
    # render_find_by("InvoiceItem")
  end

  def index
    render_json_query("InvoiceItem")
    # render_find_all_by("InvoiceItem")
  end

  private

  def valid_params
    params.permit(:id, :quantity, :unit_price, :created_at, :updated_at, :item_id, :invoice_id)
  end
end
