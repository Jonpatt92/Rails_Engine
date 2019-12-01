require 'rails_helper'

describe "Customers API 'find' and 'find_all'" do
  before(:each) do
    @customer_list = create_list(:customer, 3, first_name: "Alan", last_name: "Turing")
    @unique_customer = create(:customer, first_name: "Tim", last_name: "Lee", created_at: Time.at(3343433343), updated_at: Time.at(3343433343))
  end

  it "Can find customers based on id" do
    get "/api/v1/customers/find?id=#{@unique_customer.id}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"].to_i).to eq(@unique_customer.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq("Tim")
    expect(customer["data"]["attributes"]["last_name"]).to eq("Lee")
  end

  it "Can find_all customers based on id" do
    get "/api/v1/customers/find_all?id=#{@unique_customer.id}"
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(1)
    expect(customers["data"][0]["id"].to_i).to eq(@unique_customer.id)
    expect(customers["data"][0]["attributes"]["first_name"]).to eq("Tim")
    expect(customers["data"][0]["attributes"]["last_name"]).to eq("Lee")
  end

  it "Can find customers based on first_name" do
    get "/api/v1/customers/find?first_name=tim"
    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"].to_i).to eq(@unique_customer.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq("Tim")
    expect(customer["data"]["attributes"]["last_name"]).to eq("Lee")
  end

  it "Can find_all customers based on first_name" do
    get "/api/v1/customers/find_all?first_name=alan"
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
    expect(customers["data"][0]["id"].to_i).to eq(@customer_list[0].id)
    expect(customers["data"][1]["id"].to_i).to eq(@customer_list[1].id)
    expect(customers["data"][2]["id"].to_i).to eq(@customer_list[2].id)
  end

  it "Can find customers based on last_name" do
    get "/api/v1/customers/find?last_name=lee"
    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"].to_i).to eq(@unique_customer.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq("Tim")
    expect(customer["data"]["attributes"]["last_name"]).to eq("Lee")
  end

  it "Can find_all customers based on last_name" do
    get "/api/v1/customers/find_all?last_name=turing"
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
    expect(customers["data"][0]["id"].to_i).to eq(@customer_list[0].id)
    expect(customers["data"][1]["id"].to_i).to eq(@customer_list[1].id)
    expect(customers["data"][2]["id"].to_i).to eq(@customer_list[2].id)
  end

  it "Can find customers based on created_at" do
    get "/api/v1/customers/find?created_at=#{@unique_customer.created_at}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"].to_i).to eq(@unique_customer.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq("Tim")
    expect(customer["data"]["attributes"]["last_name"]).to eq("Lee")
  end

  it "Can find_all customers based on created_at" do
    get "/api/v1/customers/find_all?created_at=#{@customer_list[0].created_at}"
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
    expect(customers["data"][0]["id"].to_i).to eq(@customer_list[0].id)
    expect(customers["data"][1]["id"].to_i).to eq(@customer_list[1].id)
    expect(customers["data"][2]["id"].to_i).to eq(@customer_list[2].id)
  end

  it "Can find customers based on updated_at" do
    get "/api/v1/customers/find?updated_at=#{@unique_customer.updated_at}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"].to_i).to eq(@unique_customer.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq("Tim")
    expect(customer["data"]["attributes"]["last_name"]).to eq("Lee")
  end

  it "Can find_all customers based on updated_at" do
    get "/api/v1/customers/find_all?updated_at=#{@customer_list[0].updated_at}"
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
    expect(customers["data"][0]["id"].to_i).to eq(@customer_list[0].id)
    expect(customers["data"][1]["id"].to_i).to eq(@customer_list[1].id)
    expect(customers["data"][2]["id"].to_i).to eq(@customer_list[2].id)
  end
end
