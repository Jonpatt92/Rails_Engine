class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def show
    render json: InvoiceSerializer.new(InvoiceItem.find(params[:id]).invoice)
  end
end
