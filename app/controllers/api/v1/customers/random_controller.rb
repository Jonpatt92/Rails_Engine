class Api::V1::Customers::RandomController < ApplicationController
  def show
    render_json_random("Customer")
  end
end
