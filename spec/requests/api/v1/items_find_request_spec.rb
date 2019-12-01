require 'rails_helper'

describe "Items API 'find' and 'find_all'" do
  before(:each) do
    @item_list = create_list(:item, 3, name: "Docile Gorilla", description: "A docile gorilla", unit_price: 10.00)
  end

  it "Can find items based on id" do
    unique_item = create(:item, name: "Lemonade")

    get "/api/v1/items/find?id=#{unique_item.id}"
    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(unique_item.id)
    expect(item["data"]["attributes"]["name"]).to eq("Lemonade")
  end

  it "Can find_all items based on id" do
    unique_item = create(:item, name: "Lemonade")

    get "/api/v1/items/find_all?id=#{unique_item.id}"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(1)
    expect(items["data"][0]["id"].to_i).to eq(unique_item.id)
    expect(items["data"][0]["attributes"]["name"]).to eq("Lemonade")
  end

  it "Can find items based on name" do
    unique_item = create(:item, name: "Lemonade")

    get "/api/v1/items/find?name=lemonade"
    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(unique_item.id)
    expect(item["data"]["attributes"]["name"]).to eq("Lemonade")
  end

  it "Can find_all items based on name" do
    get "/api/v1/items/find_all?name=docile%20gorilla"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"][0]["id"].to_i).to eq(@item_list[0].id)
    expect(items["data"][1]["id"].to_i).to eq(@item_list[1].id)
    expect(items["data"][2]["id"].to_i).to eq(@item_list[2].id)
  end

  it "Can find items based on description" do
    unique_item = create(:item, description: "A tasty banana")

    get "/api/v1/items/find?description=a%20tasty%20banana"
    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(unique_item.id)
    expect(item["data"]["attributes"]["description"]).to eq("A tasty banana")
  end

  it "Can find_all items based on description" do
    get "/api/v1/items/find_all?description=a%20docile%20gorilla"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"][0]["id"].to_i).to eq(@item_list[0].id)
    expect(items["data"][1]["id"].to_i).to eq(@item_list[1].id)
    expect(items["data"][2]["id"].to_i).to eq(@item_list[2].id)
  end

  it "Can find items based on unit_price" do
    unique_item = create(:item, unit_price: 5.00)

    get "/api/v1/items/find?unit_price=5.00"
    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(unique_item.id)
    expect(item["data"]["attributes"]["unit_price"]).to eq(5.00)
  end

  it "Can find_all items based on unit_price" do
    get "/api/v1/items/find_all?unit_price=10.00"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"][0]["id"].to_i).to eq(@item_list[0].id)
    expect(items["data"][1]["id"].to_i).to eq(@item_list[1].id)
    expect(items["data"][2]["id"].to_i).to eq(@item_list[2].id)
  end

  it "Can find items based on created_at" do
    unique_item = create(:item, name: "Banana", created_at: Time.at(3343433343))

    get "/api/v1/items/find?created_at=#{unique_item.created_at}"
    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(unique_item.id)
    expect(item["data"]["attributes"]["name"]).to eq("Banana")
  end

  it "Can find_all items based on created_at" do
    create(:item, name: "Banana", created_at: Time.at(3343433343))

    get "/api/v1/items/find_all?created_at=#{@item_list[0].created_at}"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"][0]["id"].to_i).to eq(@item_list[0].id)
    expect(items["data"][1]["id"].to_i).to eq(@item_list[1].id)
    expect(items["data"][2]["id"].to_i).to eq(@item_list[2].id)
  end

  it "Can find items based on updated_at" do
    unique_item = create(:item, name: "Banana", updated_at: Time.at(3343433343))

    get "/api/v1/items/find?updated_at=#{unique_item.updated_at}"
    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(unique_item.id)
    expect(item["data"]["attributes"]["name"]).to eq("Banana")
  end

  it "Can find_all items based on updated_at" do
    create(:item, name: "Banana", updated_at: Time.at(3343433343))

    get "/api/v1/items/find_all?updated_at=#{@item_list[0].updated_at}"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"][0]["id"].to_i).to eq(@item_list[0].id)
    expect(items["data"][1]["id"].to_i).to eq(@item_list[1].id)
    expect(items["data"][2]["id"].to_i).to eq(@item_list[2].id)
  end
end
