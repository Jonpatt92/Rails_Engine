class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  # IF params[:date_query] != nil #
  # assign an attribute called 'date_specified' #
  # equal to the date being queried #
  # which is passed in the param [:date_query] from the controller #
  attributes :total_revenue do |obj|
    "%.2f" % obj.total_revenue # String format operator to cap decimals at 2 digits and convert to string
  end

  # attribute :date_specified, if: Proc.new { |record, params|
  #   params[:date_query]
  #   } do |obj, params|
  #   params[:date_query]
  # end
end
