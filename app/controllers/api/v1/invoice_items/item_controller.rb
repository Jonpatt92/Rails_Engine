class Api::V1::InvoiceItems::ItemController < ApplicationController
  def show
    render json: ItemSerializer.new(InvoiceItem.find(params[:id]).item)
  end
end
