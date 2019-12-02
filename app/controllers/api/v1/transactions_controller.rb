class Api::V1::TransactionsController < ApplicationController
  def show
    render_json_show("Transaction")
  end

  def index
    render_json_index("Transaction")
  end
end
