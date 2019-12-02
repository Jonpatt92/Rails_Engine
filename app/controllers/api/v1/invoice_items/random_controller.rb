class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    render_json_random("InvoiceItem")
  end
end
