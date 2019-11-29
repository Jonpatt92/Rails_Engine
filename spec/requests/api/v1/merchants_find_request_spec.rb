require 'rails_helper'

describe "Merchants API 'find' and 'find_all'" do
  before(:each) do
    @merchant_list = create_list(:merchant, 3)
  end

  it "Can find merchants based on id" do
    unique_merchant = create(:merchant, name: "Lemonade Stand")

    get "/api/v1/merchants/find?id=#{unique_merchant.id}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"].to_i).to eq(unique_merchant.id)
    expect(merchant["data"]["attributes"]["name"]).to eq("Lemonade Stand")
  end

  it "Can find_all merchants based on id" do
    unique_merchant = create(:merchant, name: "Lemonade Stand")

    get "/api/v1/merchants/find_all?id=#{unique_merchant.id}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(1)
    expect(merchants["data"][0]["id"].to_i).to eq(unique_merchant.id)
    expect(merchants["data"][0]["attributes"]["name"]).to eq("Lemonade Stand")
  end

  it "Can find merchants based on name" do
    unique_merchant = create(:merchant, name: "Lemonade Stand")

    get "/api/v1/merchants/find?name=lemonade%20stand"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"].to_i).to eq(unique_merchant.id)
    expect(merchant["data"]["attributes"]["name"]).to eq("Lemonade Stand")
  end

  it "Can find_all merchants based on name" do
    get "/api/v1/merchants/find_all?name=banana%20stand"
    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"][0]["id"].to_i).to eq(@merchant_list[0].id)
    expect(merchants["data"][1]["id"].to_i).to eq(@merchant_list[1].id)
    expect(merchants["data"][2]["id"].to_i).to eq(@merchant_list[2].id)
  end

  it "Can find merchants based on created_at" do
    unique_merchant = create(:merchant, name: "Lemonade Stand", created_at: Time.at(3343433343))

    get "/api/v1/merchants/find?created_at=#{unique_merchant.created_at}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"].to_i).to eq(unique_merchant.id)
    expect(merchant["data"]["attributes"]["name"]).to eq("Lemonade Stand")
  end

  it "Can find_all merchants based on created_at" do
    create(:merchant, name: "Lemonade Stand", created_at: Time.at(3343433343))

    get "/api/v1/merchants/find_all?created_at=#{@merchant_list[0].created_at}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"][0]["id"].to_i).to eq(@merchant_list[0].id)
    expect(merchants["data"][1]["id"].to_i).to eq(@merchant_list[1].id)
    expect(merchants["data"][2]["id"].to_i).to eq(@merchant_list[2].id)
  end

  it "Can find merchants based on updated_at" do
    unique_merchant = create(:merchant, name: "Lemonade Stand", updated_at: Time.at(3343433343))

    get "/api/v1/merchants/find?updated_at=#{unique_merchant.updated_at}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"].to_i).to eq(unique_merchant.id)
    expect(merchant["data"]["attributes"]["name"]).to eq("Lemonade Stand")
  end

  it "Can find_all merchants based on updated_at" do
    create(:merchant, name: "Lemonade Stand", updated_at: Time.at(3343433343))

    get "/api/v1/merchants/find_all?updated_at=#{@merchant_list[0].updated_at}"
    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"][0]["id"].to_i).to eq(@merchant_list[0].id)
    expect(merchants["data"][1]["id"].to_i).to eq(@merchant_list[1].id)
    expect(merchants["data"][2]["id"].to_i).to eq(@merchant_list[2].id)
  end
end
