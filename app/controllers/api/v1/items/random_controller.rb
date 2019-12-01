class Api::V1::Items::RandomController < ApplicationController
  def show
    render_json_random("Item")
  end
end
