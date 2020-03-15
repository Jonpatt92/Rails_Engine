require './app/modules/queryable'
class ApplicationController < ActionController::API
  include Queryable
end
