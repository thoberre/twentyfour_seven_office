require "spec_helper"

describe TwentyfourSevenOffice::Services::Invoice do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:save_invoices_response) { xml_fixture :save_invoices_response }
  let(:save_invoices_error_response) { xml_fixture :save_invoices_error_response }
  let(:session_id) { TwentyfourSevenOffice::DataTypes::SessionId.new(session_id: "abcdefgh") }

  describe "#save" do
    it "saves/creates a single InvoiceOrder" do
      savon.expects(:save_invoices).with(message: {
        invoices: {
          InvoiceOrder: [{ CustomerId: 119566, InvoiceRows: [] }]
        }
      }).returns(save_invoices_response)

      invoice = TwentyfourSevenOffice::DataTypes::InvoiceOrder.new(customer_id: 119566)

      i = TwentyfourSevenOffice::Services::Invoice.new(session_id)
      id = i.save(invoice)

      expect(id).to eq(698)
    end

    it "raises exception if the result contains an APIException" do
      savon.expects(:save_invoices).with(message: {
        invoices: {
          InvoiceOrder: [{ CustomerId: 119566, InvoiceRows: [] }]
        }
      }).returns(save_invoices_error_response)

      invoice = TwentyfourSevenOffice::DataTypes::InvoiceOrder.new(customer_id: 119566)

      i = TwentyfourSevenOffice::Services::Invoice.new(session_id)

      expect { i.save(invoice) }.to raise_error(TwentyfourSevenOffice::Errors::APIError)
    end
  end
end
