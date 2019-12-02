class Api::V1::InvoicesController < ApplicationController
  def show
    render_json_show("Invoice")
  end

  def index
    render_json_index("Invoice")
  end
end
