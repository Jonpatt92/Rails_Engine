require 'rails_helper'

describe "Invoices API 'find' and 'find_all'" do
  before(:each) do
    @merchant       = create(:merchant, name: "Lemonade Stand")
    @merchant_2     = create(:merchant)
    
    @customer       = create(:customer)
    @customer_2     = create(:customer)

    @invoice_list   = create_list(:invoice, 3, status: "great", merchant: @merchant_2, customer: @customer_2)

    @unique_invoice = create(:invoice, status: "apprehensive",
                              created_at: Time.at(3343433343),
                              updated_at: Time.at(3343433343),
                                          merchant: @merchant,
                                          customer: @customer)
  end

  it "Can find invoices based on id" do
    get "/api/v1/invoices/find?id=#{@unique_invoice.id}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(@unique_invoice.id)
    expect(invoice["data"]["attributes"]["status"]).to eq("apprehensive")
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can find_all invoices based on id" do
    get "/api/v1/invoices/find_all?id=#{@unique_invoice.id}"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(1)
    expect(invoices["data"][0]["id"].to_i).to eq(@unique_invoice.id)
    expect(invoices["data"][0]["attributes"]["status"]).to eq("apprehensive")
    expect(invoices["data"][0]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoices["data"][0]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can find invoices based on status" do
    get "/api/v1/invoices/find?status=apprehensive"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(@unique_invoice.id)
    expect(invoice["data"]["attributes"]["status"]).to eq("apprehensive")
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can find_all invoices based on status" do
    get "/api/v1/invoices/find_all?status=great"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["id"].to_i).to eq(@invoice_list[0].id)
    expect(invoices["data"][1]["id"].to_i).to eq(@invoice_list[1].id)
    expect(invoices["data"][2]["id"].to_i).to eq(@invoice_list[2].id)
  end

  it "Can find invoices based on merchant_id" do
    get "/api/v1/invoices/find?merchant_id=#{@merchant.id}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(@unique_invoice.id)
    expect(invoice["data"]["attributes"]["status"]).to eq("apprehensive")
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can find_all invoices based on merchant_id" do
    get "/api/v1/invoices/find_all?merchant_id=#{@merchant_2.id}"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["id"].to_i).to eq(@invoice_list[0].id)
    expect(invoices["data"][1]["id"].to_i).to eq(@invoice_list[1].id)
    expect(invoices["data"][2]["id"].to_i).to eq(@invoice_list[2].id)
  end

  it "Can find invoices based on customer_id" do
    get "/api/v1/invoices/find?customer_id=#{@customer.id}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(@unique_invoice.id)
    expect(invoice["data"]["attributes"]["status"]).to eq("apprehensive")
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can find_all invoices based on customer_id" do
    get "/api/v1/invoices/find_all?customer_id=#{@customer_2.id}"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["id"].to_i).to eq(@invoice_list[0].id)
    expect(invoices["data"][1]["id"].to_i).to eq(@invoice_list[1].id)
    expect(invoices["data"][2]["id"].to_i).to eq(@invoice_list[2].id)
  end

  it "Can find invoices based on created_at" do
    get "/api/v1/invoices/find?created_at=#{@unique_invoice.created_at}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(@unique_invoice.id)
    expect(invoice["data"]["attributes"]["status"]).to eq("apprehensive")
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can find_all invoices based on created_at" do
    get "/api/v1/invoices/find_all?created_at=#{@invoice_list[0].created_at}"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["id"].to_i).to eq(@invoice_list[0].id)
    expect(invoices["data"][1]["id"].to_i).to eq(@invoice_list[1].id)
    expect(invoices["data"][2]["id"].to_i).to eq(@invoice_list[2].id)
  end

  it "Can find invoices based on updated_at" do
    get "/api/v1/invoices/find?updated_at=#{@unique_invoice.updated_at}"
    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(@unique_invoice.id)
    expect(invoice["data"]["attributes"]["status"]).to eq("apprehensive")
    expect(invoice["data"]["attributes"]["merchant_id"]).to eq(@merchant.id)
    expect(invoice["data"]["attributes"]["customer_id"]).to eq(@customer.id)
  end

  it "Can find_all invoices based on updated_at" do
    get "/api/v1/invoices/find_all?updated_at=#{@invoice_list[0].updated_at}"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
    expect(invoices["data"][0]["id"].to_i).to eq(@invoice_list[0].id)
    expect(invoices["data"][1]["id"].to_i).to eq(@invoice_list[1].id)
    expect(invoices["data"][2]["id"].to_i).to eq(@invoice_list[2].id)
  end
end
