class FavoriteMerchantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
  attributes :id

  attributes :customer_name do |object, params|
    params[:customer_name]
  end

  attributes :transactions do |object|
    object.successful_transactions
  end
end
