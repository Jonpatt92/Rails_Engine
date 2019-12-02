class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render_json_random("Invoice")
  end
end
