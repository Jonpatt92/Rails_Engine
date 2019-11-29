class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render_json_random("Merchant")
  end
end
