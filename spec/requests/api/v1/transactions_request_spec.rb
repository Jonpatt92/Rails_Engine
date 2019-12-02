require 'rails_helper'

describe "Invoice Items API" do
  before(:each) do
    @merchant         = create(:merchant)
    @customer         = create(:customer)
    @invoice          = create(:invoice, merchant: @merchant, customer: @customer )
    @transaction_1    = create(:transaction, credit_card_number: 2222, credit_card_expiration_date: 5555, result: "paid", invoice: @invoice )
    @transaction_2    = create(:transaction, credit_card_number: 3333, credit_card_expiration_date: 6666, result: "unpaid", invoice: @invoice )
    @transaction_3    = create(:transaction, credit_card_number: 4444, credit_card_expiration_date: 7777, result: "wheres my money", invoice: @invoice )
    @transaction_list = create_list(:transaction, 10, invoice: @invoice )
  end

  it "Can show a list of all transactions" do
    get '/api/v1/transactions'
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(13)
    expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq(@transaction_1.credit_card_number)
    expect(transactions["data"][0]["attributes"]["credit_card_expiration_date"]).to eq(@transaction_1.credit_card_expiration_date)
    expect(transactions["data"][0]["attributes"]["result"]).to eq(@transaction_1.result)
    expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(@invoice.id)

    expect(transactions["data"][1]["attributes"]["credit_card_number"]).to eq(@transaction_2.credit_card_number)
    expect(transactions["data"][1]["attributes"]["credit_card_expiration_date"]).to eq(@transaction_2.credit_card_expiration_date)
    expect(transactions["data"][1]["attributes"]["result"]).to eq(@transaction_2.result)
    expect(transactions["data"][1]["attributes"]["invoice_id"]).to eq(@invoice.id)

    expect(transactions["data"][2]["attributes"]["credit_card_number"]).to eq(@transaction_3.credit_card_number)
    expect(transactions["data"][2]["attributes"]["credit_card_expiration_date"]).to eq(@transaction_3.credit_card_expiration_date)
    expect(transactions["data"][2]["attributes"]["result"]).to eq(@transaction_3.result)
    expect(transactions["data"][2]["attributes"]["invoice_id"]).to eq(@invoice.id)
  end

  it "Can get one transaction by its id" do
    get "/api/v1/transactions/#{@transaction_1.id}"
    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(@transaction_1.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@transaction_1.credit_card_number)
    expect(transaction["data"]["attributes"]["credit_card_expiration_date"]).to eq(@transaction_1.credit_card_expiration_date)
    expect(transaction["data"]["attributes"]["result"]).to eq(@transaction_1.result)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice.id)
  end

  it "Can show a Random transaction" do
    random_transactions = []

    10.times do
      get "/api/v1/transactions/random"
      expect(response).to be_successful
      transaction = JSON.parse(response.body)
      random_transactions << transaction["data"]["id"]
    end

    expect(random_transactions.uniq.count).to be >= 1
  end

  it "Can show the invoice that a specific transaction belongs to" do
    get "/api/v1/transactions/#{@transaction_1.id}/invoice"
    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json["data"]["id"]).to eq(@invoice.id.to_s)
    expect(invoice_json["data"]["attributes"]["status"]).to eq(@invoice.status)
    expect(invoice_json["data"]["attributes"]["customer_id"]).to eq(@customer.id)
    expect(invoice_json["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
  end
end
