class Api::V1::Customers::FindController < ApplicationController
  ##### Have this (and all other find controllers) < from a FindController that dictates the actions all find controllers take #####
  def show

    render_json_query("Customer")
  end

  def index
    render_json_query("Customer")
  end

  private

  def valid_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
