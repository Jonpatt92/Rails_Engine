class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attributes :date_specified do |obj, params|
    params[:date_specified]
  end

  attributes :total_revenue do |obj|
    obj.total_revenue
  end
end
