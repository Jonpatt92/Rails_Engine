class MostRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name
  attributes :total_revenue do |obj|
    obj.revenue
  end
end
