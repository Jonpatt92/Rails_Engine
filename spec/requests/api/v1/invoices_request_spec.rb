require 'rails_helper'

describe "Invoices API" do
  before(:each) do
    @merchant     = create(:merchant, name: "Lemonade Stand")
    @customer     = create(:customer)
    @item         = create(:item, merchant: @merchant)
    @invoice      = create(:invoice, merchant: @merchant, customer: @customer )
    @invoice_1    = create(:invoice, status: "totally lost", merchant: @merchant, customer: @customer )
    @invoice_2    = create(:invoice, status: "nevermind, we got it", merchant: @merchant, customer: @customer )
    @invoice_list = create_list(:invoice, 10, merchant: @merchant, customer: @customer )
  end

  it "Can show a list of all invoices" do
    get '/api/v1/invoices'
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["attributes"]["status"]).to eq(@invoice.status)
    expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(@customer.id)

    expect(invoices["data"][1]["attributes"]["status"]).to eq(@invoice_1.status)
    expect(invoices["data"][1]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoices["data"][1]["attributes"]["customer_id"]).to eq(@customer.id)

    expect(invoices["data"][2]["attributes"]["status"]).to eq(@invoice_2.status)
    expect(invoices["data"][2]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoices["data"][2]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can get one invoice by its id" do
    get "/api/v1/invoices/#{@invoice_1.id}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(@invoice_1.id)
    expect(invoices["data"]["attributes"]["status"]).to eq(@invoice_1.status)
    expect(invoices["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoices["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can show a Random invoice" do
    random_invoices = []

    10.times do
      get "/api/v1/invoices/random"
      expect(response).to be_successful
      invoice = JSON.parse(response.body)
      random_invoices << invoice["data"]["id"]
    end

    expect(random_invoices.uniq.count).to be >= 1
  end

  it "Can show invoice_items related to specific invoice" do
    invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 4.00, item: @item, invoice: @invoice)
    invoice_item_2 = create(:invoice_item, quantity: 4, unit_price: 8.00, item: @item, invoice: @invoice)

    get "/api/v1/invoices/#{@invoice.id}/invoice_items"
    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(2)
    expect(invoice_items["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(invoice_item_1.quantity)
    expect(invoice_items["data"][0]["attributes"]["unit_price"]).to eq(invoice_item_1.unit_price)
    expect(invoice_items["data"][0]["attributes"]["invoice_id"]).to eq(@invoice.id)
    expect(invoice_items["data"][0]["attributes"]["item_id"]).to eq(@item.id)


    expect(invoice_items["data"][1]["id"]).to eq(invoice_item_2.id.to_s)
    expect(invoice_items["data"][1]["attributes"]["quantity"]).to eq(invoice_item_2.quantity)
    expect(invoice_items["data"][1]["attributes"]["unit_price"]).to eq(invoice_item_2.unit_price)
    expect(invoice_items["data"][1]["attributes"]["invoice_id"]).to eq(@invoice.id)
    expect(invoice_items["data"][1]["attributes"]["item_id"]).to eq(@item.id)
  end

  it "Can show items related to specific invoice" do
    item_2 = create(:item, merchant: @merchant)
    create(:invoice_item, item: @item, invoice: @invoice)
    create(:invoice_item, item: item_2, invoice: @invoice)

    get "/api/v1/invoices/#{@invoice.id}/items"
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["id"]).to eq(@item.id.to_s)
    expect(items["data"][0]["attributes"]["name"]).to eq(@item.name)
    expect(items["data"][0]["attributes"]["description"]).to eq(@item.description)
    expect(items["data"][0]["attributes"]["unit_price"]).to eq(@item.unit_price)
    expect(items["data"][0]["attributes"]["merchant_id"]).to eq(@merchant.id)

    expect(items["data"][1]["id"]).to eq(item_2.id.to_s)
    expect(items["data"][1]["attributes"]["name"]).to eq(item_2.name)
    expect(items["data"][1]["attributes"]["description"]).to eq(item_2.description)
    expect(items["data"][1]["attributes"]["unit_price"]).to eq(item_2.unit_price)
    expect(items["data"][1]["attributes"]["merchant_id"]).to eq(@merchant.id)
  end

  it "Can show transactions related to specific invoice" do
    transaction_1 = create(:transaction, invoice: @invoice)
    transaction_2 = create(:transaction, invoice: @invoice)

    get "/api/v1/invoices/#{@invoice.id}/transactions"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["id"]).to eq(transaction_1.id.to_s)
    expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq(transaction_1.credit_card_number)
    expect(transactions["data"][0]["attributes"]["credit_card_expiration_date"]).to eq(transaction_1.credit_card_expiration_date)
    expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(@invoice.id)

    expect(transactions["data"][1]["id"]).to eq(transaction_2.id.to_s)
    expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq(transaction_2.credit_card_number)
    expect(transactions["data"][1]["attributes"]["credit_card_expiration_date"]).to eq(transaction_2.credit_card_expiration_date)
    expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(@invoice.id)
  end

  it "Can show the merchant that a specific invoice belongs to" do
    get "/api/v1/invoices/#{@invoice.id}/merchant"
    expect(response).to be_successful

    merchant_json = JSON.parse(response.body)

    expect(merchant_json["data"]["id"]).to eq(@merchant.id.to_s)
    expect(merchant_json["data"]["attributes"]["name"]).to eq(@merchant.name)
  end

  it "Can show the customer that a specific invoice belongs to" do
    get "/api/v1/invoices/#{@invoice.id}/customer"
    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json["data"]["id"]).to eq(@customer.id.to_s)
    expect(customer_json["data"]["attributes"]["first_name"]).to eq(@customer.first_name)
    expect(customer_json["data"]["attributes"]["last_name"]).to eq(@customer.last_name)
  end
end
