require 'rails_helper'

describe "Invoice Items API 'find' and 'find_all'" do
  before(:each) do
    @merchant_1          = create(:merchant, name: "Lemonade Stand")
    @merchant_2          = create(:merchant)

    @customer_1          = create(:customer)
    @customer_2          = create(:customer)

    @item_1              = create(:item, merchant: @merchant_1 )
    @item_2              = create(:item, merchant: @merchant_2 )

    @invoice_1           = create(:invoice, merchant: @merchant_1,
                                            customer: @customer_1 )
    @invoice_2           = create(:invoice, merchant: @merchant_2,
                                            customer: @customer_2 )

    @unique_invoice_item = create(:invoice_item, quantity: 2,
       unit_price: 11.00, item: @item_1, invoice: @invoice_1 )
    @invoice_item_list = create_list(:invoice_item, 3, item: @item_2,
                                                 invoice: @invoice_2 )
  end

  it "Can find invoice_items based on id" do
    get "/api/v1/invoice_items/find?id=#{@unique_invoice_item.id}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@unique_invoice_item.unit_price)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all invoice_items based on id" do
    get "/api/v1/invoice_items/find_all?id=#{@unique_invoice_item.id}"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(1)
    expect(invoice_items["data"][0]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq(@unique_invoice_item.unit_price)
    expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find invoice_items based on quantity" do
    get "/api/v1/invoice_items/find?quantity=2"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all invoice_items based on quantity" do
    get "/api/v1/invoice_items/find_all?quantity=1"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
    expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_list[0].id)
    expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_list[1].id)
    expect(invoice_items["data"][2]["id"].to_i).to eq(@invoice_item_list[2].id)
  end

  it "Can find invoice_items based on unit_price" do
    get "/api/v1/invoice_items/find?unit_price=11.00"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@unique_invoice_item.unit_price)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all invoice_items based on unit_price" do
    get "/api/v1/invoice_items/find_all?unit_price=5.00"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
    expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_list[0].id)
    expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_list[1].id)
    expect(invoice_items["data"][2]["id"].to_i).to eq(@invoice_item_list[2].id)
  end

  it "Can find invoice_items based on invoice_id" do
    get "/api/v1/invoice_items/find?invoice_id=#{@invoice_1.id}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@unique_invoice_item.unit_price)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all invoice_items based on invoice_id" do
    get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_2.id}"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
    expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_list[0].id)
    expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_list[1].id)
    expect(invoice_items["data"][2]["id"].to_i).to eq(@invoice_item_list[2].id)
  end

  it "Can find invoice_items based on item_id" do
    get "/api/v1/invoice_items/find?item_id=#{@item_1.id}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@unique_invoice_item.unit_price)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all invoice_items based on item_id" do
    get "/api/v1/invoice_items/find_all?item_id=#{@item_2.id}"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
    expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_list[0].id)
    expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_list[1].id)
    expect(invoice_items["data"][2]["id"].to_i).to eq(@invoice_item_list[2].id)
  end

  it "Can find invoice_items based on created_at" do
    get "/api/v1/invoice_items/find?created_at=#{@unique_invoice_item.created_at}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@unique_invoice_item.unit_price)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all invoice_items based on created_at" do
    get "/api/v1/invoice_items/find_all?created_at=#{@invoice_item_list[0].created_at}"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
    expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_list[0].id)
    expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_list[1].id)
    expect(invoice_items["data"][2]["id"].to_i).to eq(@invoice_item_list[2].id)
  end

  it "Can find invoice_items based on updated_at" do
    get "/api/v1/invoice_items/find?updated_at=#{@unique_invoice_item.updated_at}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@unique_invoice_item.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@unique_invoice_item.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@unique_invoice_item.unit_price)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item_1.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all invoice_items based on updated_at" do
    get "/api/v1/invoice_items/find_all?updated_at=#{@invoice_item_list[0].updated_at}"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
    expect(invoice_items["data"][0]["id"].to_i).to eq(@invoice_item_list[0].id)
    expect(invoice_items["data"][1]["id"].to_i).to eq(@invoice_item_list[1].id)
    expect(invoice_items["data"][2]["id"].to_i).to eq(@invoice_item_list[2].id)
  end
end
