class Api::V1::InvoiceItemsController < ApplicationController
  def show
    render_json_show("InvoiceItem")
  end

  def index
    render_json_index("InvoiceItem")
  end
end
