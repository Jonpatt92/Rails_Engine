require 'rails_helper'

describe "Customers API" do
  before(:each) do
    @customer_1 = create(:customer, first_name: "Bob", last_name: "Ross")
    @customer_2 = create(:customer, first_name: "Alan", last_name: "Turing")
    @customer_3 = create(:customer, first_name: "Tim", last_name: "Lee")
  end
  it "Can show a list of all customers" do
    get '/api/v1/customers'
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
    expect(customers["data"][0]["attributes"]["first_name"]).to eq(@customer_1.first_name)
    expect(customers["data"][0]["attributes"]["last_name"]).to eq(@customer_1.last_name)

    expect(customers["data"][1]["attributes"]["first_name"]).to eq(@customer_2.first_name)
    expect(customers["data"][1]["attributes"]["last_name"]).to eq(@customer_2.last_name)

    expect(customers["data"][2]["attributes"]["first_name"]).to eq(@customer_3.first_name)
    expect(customers["data"][2]["attributes"]["last_name"]).to eq(@customer_3.last_name)
  end

  it "Can get one customer by its id" do
    get "/api/v1/customers/#{@customer_2.id}"
    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"].to_i).to eq(@customer_2.id)
    expect(customers["data"]["attributes"]["first_name"]).to eq(@customer_2.first_name)
    expect(customers["data"]["attributes"]["last_name"]).to eq(@customer_2.last_name)
  end

  it "Can show a Random customer" do
    create_list(:customer, first_name: "Alan", last_name: "Turing")
    random_customers = []

    10.times do
      get "/api/v1/customers/random"
      expect(response).to be_successful
      customer = JSON.parse(response.body)
      random_customers << customer["data"]["id"]
    end

    customer = JSON.parse(response.body)

    expect(random_customers.uniq.count).to be >= 1
    expect(customer["data"]["attributes"]["first_name"]).to eq("Alan")
    expect(customer["data"]["attributes"]["last_name"]).to eq("Turing")
  end

  it "Can show invoices related to specific customer" do
    merchant = create(:merchant)
    invoice_1 = create(:invoice, status: "shipped", customer: @customer_1, merchant: merchant)
    invoice_2 = create(:invoice, status: "shipped", customer: @customer_1, merchant: merchant)

    get "/api/v1/customers/#{@customer_1.id}/invoices"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["id"]).to eq(invoice_1.id.to_s)
    expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)

    expect(invoices["data"][1]["id"]).to eq(invoice_2.id.to_s)
    expect(invoices["data"][1]["attributes"]["status"]).to eq(invoice_2.status)
  end

  it "Can show transactions related to specific customer" do
    merchant = create(:merchant)
    invoice_1 = create(:invoice, status: "shipped", customer: @customer_1, merchant: merchant)
    invoice_2 = create(:invoice, status: "shipped", customer: @customer_1, merchant: merchant)
    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)

    get "/api/v1/customers/#{@customer_1.id}/transactions"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["id"]).to eq(transaction_1.id.to_s)
    expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq(transaction_1.credit_card_number)
    expect(transactions["data"][0]["attributes"]["credit_card_expiration_date"]).to eq(transaction_1.credit_card_expiration_date)
    expect(transactions["data"][0]["attributes"]["result"]).to eq(transaction_1.result)

    expect(transactions["data"][1]["id"]).to eq(transaction_2.id.to_s)
    expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq(transaction_2.credit_card_number)
    expect(transactions["data"][1]["attributes"]["credit_card_expiration_date"]).to eq(transaction_2.credit_card_expiration_date)
    expect(transactions["data"][1]["attributes"]["result"]).to eq(transaction_2.result)
  end

  describe "Business Intelligence endpoints for items." do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)

      @customer = create(:customer)

      @invoice_1  = create(:invoice, merchant: @merchant_1, customer: @customer)
      @invoice_2  = create(:invoice, merchant: @merchant_1, customer: @customer)
      @invoice_3  = create(:invoice, merchant: @merchant_2, customer: @customer)
      @invoice_4  = create(:invoice, merchant: @merchant_2, customer: @customer)
      @invoice_5  = create(:invoice, merchant: @merchant_2, customer: @customer)
      @invoice_6  = create(:invoice, merchant: @merchant_3, customer: @customer)
      @invoice_7  = create(:invoice, merchant: @merchant_3, customer: @customer)
      @invoice_8  = create(:invoice, merchant: @merchant_3, customer: @customer)
      @invoice_9  = create(:invoice, merchant: @merchant_4, customer: @customer)

      create(:transaction, invoice: @invoice_1, result: "success")
      create(:transaction, invoice: @invoice_2, result: "success")
      create(:transaction, invoice: @invoice_3, result: "failed")
      create(:transaction, invoice: @invoice_4, result: "success")
      create(:transaction, invoice: @invoice_5, result: "success")
      create(:transaction, invoice: @invoice_6, result: "success")
      create(:transaction, invoice: @invoice_7, result: "success")
      create(:transaction, invoice: @invoice_8, result: "success")
      create(:transaction, invoice: @invoice_9, result: "success")
    end

    it "Returns a merchant where the customer has conducted the most successful transactions" do
      get "/api/v1/customers/#{@customer.id}/favorite_merchant"
      expect(response).to be_successful
      business_logic = JSON.parse(response.body)

      expect(business_logic["data"]["attributes"]["id"]).to eq(@merchant_3.id)
      expect(business_logic["data"]["attributes"]["name"]).to eq(@merchant_3.name)
      expect(business_logic["data"]["attributes"]["transactions"]).to eq(3)
    end
  end
end
