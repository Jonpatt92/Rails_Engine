class BestDaySerializer
  include FastJsonapi::ObjectSerializer

  attributes :best_day do |obj|
    Date.parse(obj.created_at.to_s)
  end

  attributes :total_purchases do |obj|
    obj.purchases
  end
end
