class Api::V1::Customers::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.where("customer_id = ?", params[:id]))
  end
end
