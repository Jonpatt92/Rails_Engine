class Api::V1::Transactions::RandomController < ApplicationController
  def show
    render_json_random("Transaction")
  end
end
