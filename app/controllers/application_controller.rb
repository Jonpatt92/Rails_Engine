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

  # Parses date being used in time related query #
  def date_parsed
    if created_at?
      Date.parse(valid_params["created_at"])
    elsif updated_at?
      Date.parse(valid_params["updated_at"])
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

  ### 'find?' search queries for 'show' action ###
  
  def render_find_by(table)
    if time_query?
      render_find_by_date(date_parsed, table)
    else
      render_find_by_attribute(table)
    end
  end

  def render_find_by_date(date, table)
    if created_at?
      render json: serializer(table).new(
        model(table).where(
        created_at: (date.midnight..date.end_of_day)).take
      )
    elsif updated_at?
      render json: serializer(table).new(
        model(table).where(
        updated_at: (date.midnight..date.end_of_day)).take
      )
    end
  end

  def render_find_by_attribute(table)
    render json: serializer(table).new(
      model(table).find_by(valid_params)
    )
  end

  ### 'find_all?' search queries for 'index' action ###

  def render_find_all_by(table)
    if time_query?
      render_find_all_by_date(date_parsed, table)
    else
      render_find_all_by_attribute(table)
    end
  end

  def render_find_all_by_date(date, table)
    if created_at?
      render json: serializer(table).new(
        model(table).where(
        created_at: (date.midnight..date.end_of_day))
      )
    elsif updated_at?
      render json: serializer(table).new(
        model(table).where(
        updated_at: (date.midnight..date.end_of_day))
      )
    end
  end

  def render_find_all_by_attribute(table)
    render json: serializer(table).new(
      model(table).where(valid_params)
    )
  end
end
