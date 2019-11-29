require 'rails_helper'

describe "Merchants API" do
  it "Can show a list of all merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(5)
  end

  it "Can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"].to_i).to eq(id)
    expect(merchant["data"]["attributes"]["name"]).to eq("Banana Stand")
  end

  it "Can show a Random merchant" do
    create_list(:merchant, 20)
    random_merchants = []

    10.times do
      get "/api/v1/merchants/random"
      expect(response).to be_successful
      merchant = JSON.parse(response.body)
      random_merchants << merchant["data"]["id"]
    end

    expect(random_merchants.uniq.count).to be >= 1
  end

  it "Can show items related to specific merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}/items"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(5)
    expect(items["data"][0]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(items["data"][1]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(items["data"][2]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(items["data"][3]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(items["data"][4]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
  end

  it "Can show invoices related to specific merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}/invoices"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(invoices["data"][1]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(invoices["data"][2]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
  end
end
