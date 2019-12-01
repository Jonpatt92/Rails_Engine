class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(
      Customer.find(params[:id]).transactions
    )
  end
end
