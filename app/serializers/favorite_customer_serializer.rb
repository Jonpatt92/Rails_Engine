class FavoriteCustomerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :merchant_name do |object, params|
    params[:merchant_name]
  end

  attributes :favorite_customer_id do |object|
    object.id
  end

  attributes :favorite_customer_first_name, &:first_name
  attributes :favorite_customer_last_name, &:last_name

  attributes :successful_transactions do |object|
    object.successful_transactions
  end
end
