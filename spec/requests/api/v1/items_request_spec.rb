require 'rails_helper'

describe "Items API" do
  it "Can show a list of all items" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1 )
    item_2 = create(:item, name: "Banana", description: "A tasty banana", unit_price: 5.00, merchant: merchant_1 )
    item_3 = create(:item, name: "Unicycle", description: "An extra large unicycle", unit_price: 8.00, merchant: merchant_2 )

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    expect(items["data"][0]["attributes"]["name"]).to eq(item_1.name)
    expect(items["data"][0]["attributes"]["description"]).to eq(item_1.description)
    expect(items["data"][0]["attributes"]["unit_price"]).to eq(item_1.unit_price)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(merchant_1.id)
    expect(items["data"][1]["attributes"]["name"]).to eq(item_2.name)
    expect(items["data"][1]["attributes"]["description"]).to eq(item_2.description)
    expect(items["data"][1]["attributes"]["unit_price"]).to eq(item_2.unit_price)
    expect(items["data"][1]["attributes"]["merchant_id"]).to eq(merchant_1.id)
    expect(items["data"][2]["attributes"]["name"]).to eq(item_3.name)
    expect(items["data"][2]["attributes"]["description"]).to eq(item_3.description)
    expect(items["data"][2]["attributes"]["unit_price"]).to eq(item_3.unit_price)
    expect(items["data"][2]["attributes"]["merchant_id"]).to eq(merchant_2.id)
  end

  it "Can get one item by its id" do
    merchant = create(:merchant)
    item_1 = create(:item, name: "Banana", description: "A tasty banana", unit_price: 5.00, merchant: merchant )


    get "/api/v1/items/#{id}"
    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(item_1.id)
    expect(item["data"]["attributes"]["name"]).to eq("Banana")
    expect(item["data"]["attributes"]["description"]).to eq("A tasty banana")
    expect(item["data"]["attributes"]["unit_price"]).to eq(5.00)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(merchant.id)
  end

  it "Can show a Random item" do
    merchant = create(:merchant)
    create_list(:item, 20, name: "Banana", description: "A tasty banana", unit_price: 5.00, merchant: merchant )
    random_items = []

    10.times do
      get "/api/v1/items/random"
      expect(response).to be_successful
      item = JSON.parse(response.body)
      random_items << item["data"]["id"]
    end

    item = JSON.parse(response.body)

    expect(random_items.uniq.count).to be >= 1
    expect(item["data"]["id"].to_i).to eq(item_1.id)
    expect(item["data"]["attributes"]["name"]).to eq("Banana")
    expect(item["data"]["attributes"]["description"]).to eq("A tasty banana")
    expect(item["data"]["attributes"]["unit_price"]).to eq(5.00)
    expect(item["data"]["attributes"]["merchant_id"]).to eq(merchant.id)
  end

  it "Can show invoice_items related to specific item" do
    item = create(:item)
    invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 6.00, item: item)
    invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 8.00, item: item)

    get "/api/v1/items/#{id}/items"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["relationships"]["invoice_item"]["data"]["id"].to_i).to eq(item.id)
    expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(invoice_item_1.quantity)
    expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq(invoice_item_1.unit_price)

    expect(invoice_items["data"][1]["relationships"]["invoice_item"]["data"]["id"].to_i).to eq(item.id)
    expect(invoice_items["data"][1]["attributes"]["id"]).to eq(invoice_item_2.id)
    expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(invoice_item_2.quantity)
    expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq(invoice_item_2.unit_price)
  end

  it "Can show the merchant that a specific item belongs to" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["relationships"]["item"]["data"]["id"].to_i).to eq(item.id)
    expect(merchant["data"]["attributes"]["id"]).to eq(merchant.id)
    expect(merchant["data"]["attributes"]["name"]).to eq(merchant.name)
  end

  describe "Business Intelligence endpoints for items." do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)

      @item_1  = create(:item, unit_price: 10.00, merchant: @merchant_1)
      @item_2  = create(:item, unit_price: 10.00, merchant: @merchant_2)
      @item_3  = create(:item, unit_price: 10.00, merchant: @merchant_3)
      @item_4  = create(:item, unit_price: 10.00, merchant: @merchant_4)

      @invoice_1  = create(:invoice, merchant: @merchant_1, customer: @customer_1, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_2  = create(:invoice, merchant: @merchant_1, customer: @customer_1, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_3  = create(:invoice, merchant: @merchant_2, customer: @customer_2, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_4  = create(:invoice, merchant: @merchant_2, customer: @customer_2, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_5  = create(:invoice, merchant: @merchant_2, customer: @customer_3, created_at: "2019-05-22T12:30:07.000Z")
      @invoice_6  = create(:invoice, merchant: @merchant_2, customer: @customer_3, created_at: "2019-05-22T12:30:07.000Z")
      @invoice_7  = create(:invoice, merchant: @merchant_3, customer: @customer_4, created_at: "2019-05-22T12:30:07.000Z")
      @invoice_8  = create(:invoice, merchant: @merchant_4, customer: @customer_4, created_at: "2019-05-22T12:30:07.000Z")
      @invoice_9  = create(:invoice, merchant: @merchant_4, customer: @customer_4, created_at: "2019-05-22T12:30:07.000Z")

      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_1, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_1, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_2, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_2, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_3, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_3, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_4, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_4, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_5, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_5, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_5, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_5, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_6, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_6, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_6, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_6, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_7, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_7, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_7, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_7, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_8, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_8, item: @item_2, quantity: 5, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_8, item: @item_3, quantity: 1, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_8, item: @item_4, quantity: 3, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_9, item: @item_1, quantity: 1, unit_price: 10.00)

      create(:transaction, invoice: @invoice_1, result: "success")
      create(:transaction, invoice: @invoice_2, result: "success")
      create(:transaction, invoice: @invoice_3, result: "failed")
      create(:transaction, invoice: @invoice_4, result: "success")
      create(:transaction, invoice: @invoice_5, result: "success")
      create(:transaction, invoice: @invoice_6, result: "failed")
      create(:transaction, invoice: @invoice_7, result: "success")
      create(:transaction, invoice: @invoice_8, result: "success")
      create(:transaction, invoice: @invoice_9, result: "success")
    end

    it "Returns the top 'x' items ranked by total revenue" do
      get "/api/v1/items/most_revenue?quantity=3"
      expect(response).to be_successful
      business_logic = JSON.parse(response.body)

      expect(business_logic["data"][0]["attributes"]["id"]).to eq(@item_2.id)
      expect(business_logic["data"][0]["attributes"]["name"]).to eq(@item_2.name)
      expect(business_logic["data"][1]["attributes"]["id"]).to eq(@item_1.id)
      expect(business_logic["data"][1]["attributes"]["name"]).to eq(@item_1.name)
      expect(business_logic["data"][2]["attributes"]["id"]).to eq(@item_4.id)
      expect(business_logic["data"][2]["attributes"]["name"]).to eq(@item_4.name)
    end

    it "Returns the date with the most sales for the given item using the invoice date." do
      get "/api/v1/items/#{@item_1.id}/best_day"
      expect(response).to be_successful
      business_logic = JSON.parse(response.body)

      expect(business_logic["data"]["attributes"]["best_day"]).to eq("2019-05-22")
    end

    it "Returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day." do
      get "/api/v1/items/#{@item_2.id}/best_day"
      expect(response).to be_successful
      business_logic = JSON.parse(response.body)

      expect(business_logic["data"]["attributes"]["best_day"]).to eq("2019-05-22")
    end
  end
end
