class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where("item_id = ?", params[:id]))
  end
end
