require 'rails_helper'

describe "Invoice Items API 'find' and 'find_all'" do
  before(:each) do
    @merchant_1         = create(:merchant, name: "Lemonade Stand")
    @merchant_2         = create(:merchant)

    @customer_1         = create(:customer)
    @customer_2         = create(:customer)

    @invoice_1          = create(:invoice, merchant: @merchant_1,
                                           customer: @customer_1 )
    @invoice_2          = create(:invoice, merchant: @merchant_2,
                                           customer: @customer_2 )

    @unique_transaction = create(:transaction, credit_card_number: 2222,
             result: "wheres my money", created_at: Time.at(3343433343),
                    invoice: @invoice_1, updated_at: Time.at(3343433343))

    @transaction_list   = create_list(:transaction, 3, invoice: @invoice_2 )
  end

  it "Can find transactions based on id" do
    get "/api/v1/transactions/find?id=#{@unique_transaction.id}"
    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(@unique_transaction.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transaction["data"]["attributes"]["result"]).to eq(@unique_transaction.result)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all transactions based on id" do
    get "/api/v1/transactions/find_all?id=#{@unique_transaction.id}"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(1)
    expect(transactions["data"][0]["id"].to_i).to eq(@unique_transaction.id)
    expect(transactions["data"][0]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transactions["data"][0]["attributes"]["result"]).to eq(@unique_transaction.result)
    expect(transactions["data"][0]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find transactions based on credit_card_number" do
    get "/api/v1/transactions/find?credit_card_number=2222"
    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(@unique_transaction.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transaction["data"]["attributes"]["result"]).to eq(@unique_transaction.result)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all transactions based on credit_card_number" do
    get "/api/v1/transactions/find_all?credit_card_number=1234"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
    expect(transactions["data"][0]["id"].to_i).to eq(@transaction_list[0].id)
    expect(transactions["data"][1]["id"].to_i).to eq(@transaction_list[1].id)
    expect(transactions["data"][2]["id"].to_i).to eq(@transaction_list[2].id)
  end

  it "Can find transactions based on result" do
    get "/api/v1/transactions/find?result=wheres%20my%20money"
    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(@unique_transaction.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transaction["data"]["attributes"]["result"]).to eq(@unique_transaction.result)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all transactions based on result" do
    get "/api/v1/transactions/find_all?result=success"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
    expect(transactions["data"][0]["id"].to_i).to eq(@transaction_list[0].id)
    expect(transactions["data"][1]["id"].to_i).to eq(@transaction_list[1].id)
    expect(transactions["data"][2]["id"].to_i).to eq(@transaction_list[2].id)
  end

  it "Can find transactions based on invoice_id" do
    get "/api/v1/transactions/find?invoice_id=#{@invoice_1.id}"
    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(@unique_transaction.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transaction["data"]["attributes"]["result"]).to eq(@unique_transaction.result)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all transactions based on invoice_id" do
    get "/api/v1/transactions/find_all?invoice_id=#{@invoice_2.id}"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
    expect(transactions["data"][0]["id"].to_i).to eq(@transaction_list[0].id)
    expect(transactions["data"][1]["id"].to_i).to eq(@transaction_list[1].id)
    expect(transactions["data"][2]["id"].to_i).to eq(@transaction_list[2].id)
  end

  it "Can find transactions based on created_at" do
    get "/api/v1/transactions/find?created_at=#{@unique_transaction.created_at}"
    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(@unique_transaction.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transaction["data"]["attributes"]["result"]).to eq(@unique_transaction.result)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all transactions based on created_at" do
    get "/api/v1/transactions/find_all?created_at=#{@transaction_list[0].created_at}"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
    expect(transactions["data"][0]["id"].to_i).to eq(@transaction_list[0].id)
    expect(transactions["data"][1]["id"].to_i).to eq(@transaction_list[1].id)
    expect(transactions["data"][2]["id"].to_i).to eq(@transaction_list[2].id)
  end

  it "Can find transactions based on updated_at" do
    get "/api/v1/transactions/find?updated_at=#{@unique_transaction.updated_at}"
    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(@unique_transaction.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(@unique_transaction.credit_card_number.to_s)
    expect(transaction["data"]["attributes"]["result"]).to eq(@unique_transaction.result)
    expect(transaction["data"]["attributes"]["invoice_id"]).to eq(@invoice_1.id)
  end

  it "Can find_all transactions based on updated_at" do
    get "/api/v1/transactions/find_all?updated_at=#{@transaction_list[0].updated_at}"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
    expect(transactions["data"][0]["id"].to_i).to eq(@transaction_list[0].id)
    expect(transactions["data"][1]["id"].to_i).to eq(@transaction_list[1].id)
    expect(transactions["data"][2]["id"].to_i).to eq(@transaction_list[2].id)
  end
end
