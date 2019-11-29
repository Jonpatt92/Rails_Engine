class Api::V1::MerchantsController < ApplicationController
  def show
    render_json_show("Merchant")
  end

  def index
    render_json_index("Merchant")
  end
end
