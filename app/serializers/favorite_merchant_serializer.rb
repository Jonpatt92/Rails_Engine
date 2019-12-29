class FavoriteMerchantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
  attributes :id

  ##### Have this be rendered as a separate JSON object with all of that customers attributes, pass customer in as an object instead of value 
  attributes :customer_name do |object, params|
    params[:customer_name]
  end

  attributes :transactions do |object|
    object.successful_transactions
  end
end
