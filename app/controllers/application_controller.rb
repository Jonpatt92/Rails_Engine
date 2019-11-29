class ApplicationController < ActionController::API
  # Checks if params include created_at query #
  def created_at?
    valid_params["created_at"] != nil
  end

  # Checks if params include updated_at query #
  def updated_at?
    valid_params["updated_at"] != nil
  end

  # Checks if params include time related query #
  def time_query?
    created_at? || updated_at?
  end

  # Checks if the type of query is 'find?' #
  def request_type_find?
    request.env["PATH_INFO"].gsub("/api/v1/merchants/", "") == "find"
  end

  # Checks if the type of query is 'find_all?' #
  def request_type_find_all?
    request.env["PATH_INFO"].gsub("/api/v1/merchants/", "") == "find_all"
  end
  # Parses date being used in time related query #
  def date_parsed
    if created_at?
      Date.parse(valid_params["created_at"])
    elsif updated_at?
      Date.parse(valid_params["updated_at"])
    end
  end

  # Generates date related query to be inserted after .where #
  def generate_date_query_argument(date = date_parsed)
    if created_at?
      "created_at BETWEEN '#{date.midnight}' AND '#{date.end_of_day}'"
    elsif updated_at?
      "updated_at BETWEEN '#{date.midnight}' AND '#{date.end_of_day}'"
    end
  end

  # Extracts 'TableSerializer' from 'table' argument string #
  def serializer(table)
    (table + "Serializer").classify.constantize
  end

  # Extracts working model from 'table' argument string #
  def model(table)
    table.classify.constantize
  end

  # Renders JSON using FastJSON_API based on the type of request (find || find_all) #
  # And whether the query is based on attributes || created/updated_at #
  def render_json_query(table)
    if request_type_find? && time_query?
      render json: serializer(table).new(model(table).where(generate_date_query_argument(date_parsed)).take)
    elsif request_type_find? && !time_query?
      render json: serializer(table).new(model(table).find_by(valid_params))
    elsif request_type_find_all? && time_query?
      render json: serializer(table).new(model(table).where(generate_date_query_argument(date_parsed)))
    elsif request_type_find_all? && !time_query?
      render json: serializer(table).new(model(table).where(valid_params))
    end
  end

  def render_json_show(table)
    render json: serializer(table).new(model(table).find(params[:id]))
  end

  def render_json_index(table)
    render json: serializer(table).new(model(table).all)
  end

  def render_json_random(table)
    render json: serializer(table).new(model(table).random)
  end
end

  # WARNING # Below methods are depricated, above methods are functional.
  ### 'find?' search queries for 'show' action ###
#   def render_find_by(table)
#     if time_query?
#       render_find_by_date(date_parsed, table)
#     else
#       render_find_by_attribute(table)
#     end
#   end
#
#   def render_find_by_date(date, table)
#     if created_at?
#       binding.pry
#       render json: serializer(table).new(
#         model(table).where(
#         created_at: (date.midnight..date.end_of_day)).take
#       )
#     elsif updated_at?
#       render json: serializer(table).new(
#         model(table).where(
#         updated_at: (date.midnight..date.end_of_day)).take
#       )
#     end
#   end
#
#   def render_find_by_attribute(table)
#     render json: serializer(table).new(
#       model(table).find_by(valid_params)
#     )
#   end
#
#   ### 'find_all?' search queries for 'index' action ###
#   def render_find_all_by(table)
#     if time_query?
#       render_find_all_by_date(date_parsed, table)
#     else
#       render_find_all_by_attribute(table)
#     end
#   end
#
#   def render_find_all_by_date(date, table)
#     if created_at?
#       render json: serializer(table).new(
#         model(table).where(
#         created_at: (date.midnight..date.end_of_day))
#       )
#     elsif updated_at?
#       render json: serializer(table).new(
#         model(table).where(
#         updated_at: (date.midnight..date.end_of_day))
#       )
#     end
#   end
#
#   def render_find_all_by_attribute(table)
#     render json: serializer(table).new(
#       model(table).where(valid_params)
#     )
#   end
# end
