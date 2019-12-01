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
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)
    id = merchant.id

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
    merchant = create(:merchant)
    id = merchant.id
    create_list(:invoice, 3, merchant: merchant)

    get "/api/v1/merchants/#{id}/invoices"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(invoices["data"][1]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
    expect(invoices["data"][2]["relationships"]["merchant"]["data"]["id"].to_i).to eq(id)
  end

  describe "Business Intelligence endpoints for merchants." do
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
      @item_2  = create(:item, unit_price: 20.00, merchant: @merchant_1)
      @item_3  = create(:item, unit_price: 30.00, merchant: @merchant_2)
      @item_4  = create(:item, unit_price: 40.00, merchant: @merchant_2)
      @item_5  = create(:item, unit_price: 50.00, merchant: @merchant_3)
      @item_6  = create(:item, unit_price: 60.00, merchant: @merchant_3)
      @item_7  = create(:item, unit_price: 70.00, merchant: @merchant_4)
      @item_8  = create(:item, unit_price: 80.00, merchant: @merchant_4)

      @invoice_1  = create(:invoice, merchant: @merchant_1, customer: @customer_1, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_2  = create(:invoice, merchant: @merchant_1, customer: @customer_1, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_3  = create(:invoice, merchant: @merchant_2, customer: @customer_2, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_4  = create(:invoice, merchant: @merchant_2, customer: @customer_2, created_at: "2019-05-13T12:30:07.000Z")
      @invoice_5  = create(:invoice, merchant: @merchant_2, customer: @customer_3, created_at: "2019-05-22T12:30:07.000Z")
      @invoice_6  = create(:invoice, merchant: @merchant_2, customer: @customer_3, created_at: "2019-05-22T12:30:07.000Z")
      @invoice_7  = create(:invoice, merchant: @merchant_3, customer: @customer_4, created_at: "2019-05-22T12:30:07.000Z")
      @invoice_8  = create(:invoice, merchant: @merchant_4, customer: @customer_4, created_at: "2019-05-22T12:30:07.000Z")
      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 4, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 5, unit_price: 20.00)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 6, unit_price: 10.00)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 7, unit_price: 20.00)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 8, unit_price: 30.00)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 9, unit_price: 40.00)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 10, unit_price: 30.00)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 11, unit_price: 40.00)
      create(:invoice_item, invoice: @invoice_5, item: @item_5, quantity: 12, unit_price: 50.00)
      create(:invoice_item, invoice: @invoice_5, item: @item_6, quantity: 13, unit_price: 60.00)
      create(:invoice_item, invoice: @invoice_6, item: @item_5, quantity: 14, unit_price: 50.00)
      create(:invoice_item, invoice: @invoice_6, item: @item_6, quantity: 15, unit_price: 60.00)
      create(:invoice_item, invoice: @invoice_7, item: @item_7, quantity: 16, unit_price: 70.00)
      create(:invoice_item, invoice: @invoice_7, item: @item_8, quantity: 17, unit_price: 80.00)
      create(:invoice_item, invoice: @invoice_8, item: @item_7, quantity: 18, unit_price: 70.00)
      create(:invoice_item, invoice: @invoice_8, item: @item_8, quantity: 19, unit_price: 80.00)

      create(:transaction, invoice: @invoice_1, result: "success")
      create(:transaction, invoice: @invoice_2, result: "success")
      create(:transaction, invoice: @invoice_3, result: "failed")
      create(:transaction, invoice: @invoice_4, result: "success")
      create(:transaction, invoice: @invoice_5, result: "success")
      create(:transaction, invoice: @invoice_6, result: "success")
      create(:transaction, invoice: @invoice_7, result: "success")
      create(:transaction, invoice: @invoice_8, result: "success")
    end

    it "Returns the total revenue for specific date across all Merchants" do
      get "/api/v1/merchants/revenue?date=2019-05-13"
      expect(response).to be_successful

      business_logic = JSON.parse(response.body)

      expect(business_logic["data"]["attributes"]["total_revenue"]).to eq("1080.00")
      expect(business_logic["data"]["attributes"]["date_specified"]).to eq("2019-05-13")
    end

    it "Returns total revenue across all Merchants" do
        get "/api/v1/merchants/revenue"
        expect(response).to be_successful

        business_logic = JSON.parse(response.body)

        expect(business_logic["data"]["attributes"]["total_revenue"]).to eq("9320.00")
    end

    it "Returns the top 'x' merchants ranked by total revenue" do
      get "/api/v1/merchants/most_revenue?quantity=3"
      expect(response).to be_successful

      business_logic = JSON.parse(response.body)

      expect(business_logic["data"][0]["attributes"]["id"]).to eq(@merchant_2.id)
      expect(business_logic["data"][0]["attributes"]["name"]).to eq(@merchant_2.name)
      expect(business_logic["data"][1]["attributes"]["id"]).to eq(@merchant_4.id)
      expect(business_logic["data"][1]["attributes"]["name"]).to eq(@merchant_4.name)
      expect(business_logic["data"][2]["attributes"]["id"]).to eq(@merchant_3.id)
      expect(business_logic["data"][2]["attributes"]["name"]).to eq(@merchant_3.name)
    end

    it "Returns the customer who has conducted the most total transactions for a specific merchant" do
      get "/api/v1/merchants/#{@merchant_2.id}/favorite_customer"
      expect(response).to be_successful

      business_logic = JSON.parse(response.body)

      expect(business_logic["data"]["attributes"]["id"]).to eq(@customer_3.id)
      expect(business_logic["data"]["attributes"]["favorite_customer_first_name"]).to eq(@customer_3.first_name)
      expect(business_logic["data"]["attributes"]["favorite_customer_last_name"]).to eq(@customer_3.last_name)
      expect(business_logic["data"]["attributes"]["successful_transactions"]).to eq(4)
    end
  end
end
