require 'rails_helper'

describe "Invoice Items API" do
  before(:each) do
    @merchant          = create(:merchant, name: "Lemonade Stand")
    @customer          = create(:customer)
    @item              = create(:item, merchant: @merchant)
    @invoice           = create(:invoice, merchant: @merchant, customer: @customer )
    @invoice_item_1    = create(:invoice_item, quantity: 2, unit_price: 11.00, item: @item, invoice: @invoice )
    @invoice_item_2    = create(:invoice_item, quantity: 3, unit_price: 12.00, item: @item, invoice: @invoice )
    @invoice_item_3    = create(:invoice_item, quantity: 4, unit_price: 13.00, item: @item, invoice: @invoice )
    @invoice_item_list = create_list(:invoice_item, 10, invoice: @invoice )
  end

  it "Can show a list of all invoice_items" do
    get '/api/v1/invoice_items'
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(13)
    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(@invoice_item_1.quantity)
    expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq(@invoice_item_1.unit_price)
    expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(@item.id)
    expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(@invoice.id)

    expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(@invoice_item_2.quantity)
    expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq(@invoice_item_2.unit_price)
    expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(@item.id)
    expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(@invoice.id)

    expect(invoice_items["data"][2]["attributes"]["quantity"]).to eq(@invoice_item_3.quantity)
    expect(invoice_items["data"][2]["attributes"]["unit_price"]).to eq(@invoice_item_3.unit_price)
    expect(invoice_items["data"][2]["attributes"]["item_id"]).to eq(@item.id)
    expect(invoice_items["data"][2]["attributes"]["invoice_id"]).to eq(@invoice.id)
  end

  it "Can get one invoice_item by its id" do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}"
    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"].to_i).to eq(@invoice_item_1.id)
    expect(invoice_item["data"]["attributes"]["quantity"]).to eq(@invoice_item_1.quantity)
    expect(invoice_item["data"]["attributes"]["unit_price"]).to eq(@invoice_item_1.unit_price)
    expect(invoice_item["data"]["attributes"]["item_id"]).to eq(@item.id)
    expect(invoice_item["data"]["attributes"]["invoice_id"]).to eq(@invoice.id)
  end

  it "Can show a Random invoice_item" do
    random_invoice_items = []

    10.times do
      get "/api/v1/invoice_items/random"
      expect(response).to be_successful
      invoice_item = JSON.parse(response.body)
      random_invoice_items << invoice_item["data"]["id"]
    end

    expect(random_invoice_items.uniq.count).to be >= 1
  end

  it "Can show the invoice that a specific invoice_item belongs to" do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}/invoice"
    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json["data"]["id"]).to eq(@invoice.id.to_s)
    expect(invoice_json["data"]["attributes"]["status"]).to eq(@invoice.status)
    expect(invoice_json["data"]["attributes"]["customer_id"]).to eq(@customer.id)
    expect(invoice_json["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
  end

  it "Can show the item that a specific invoice_item belongs to" do
    get "/api/v1/invoice_items/#{@invoice_item_1.id}/item"
    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json["data"]["id"]).to eq(@item.id.to_s)
    expect(item_json["data"]["attributes"]["name"]).to eq(@item.name)
    expect(item_json["data"]["attributes"]["description"]).to eq(@item.description)
    expect(item_json["data"]["attributes"]["unit_price"]).to eq(@item.unit_price)
    expect(item_json["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
  end
end
