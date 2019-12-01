class Api::V1::CustomersController < ApplicationController
  def show
    render_json_show("Customer")
  end

  def index
    render_json_index("Customer")
  end
end
