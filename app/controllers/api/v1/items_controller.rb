class Api::V1::ItemsController < ApplicationController
  def show
    render_json_show("Item")
  end

  def index
    render_json_index("Item")
  end
end
