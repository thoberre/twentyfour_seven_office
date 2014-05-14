require "spec_helper"

# TODO need specs that verifies returned company data
# gets properly converted to datatype classes
describe TwentyfourSevenOffice::Services::Authentication do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:get_companies_response) do
    <<-XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope
      xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema">
      <soap:Body>
        <GetCompaniesResponse xmlns="http://24sevenOffice.com/webservices">
          <GetCompaniesResult />
        </GetCompaniesResponse>
      </soap:Body>
    </soap:Envelope>
    XML
  end

  let(:session_id) { TwentyfourSevenOffice::DataTypes::SessionId.new(session_id: "abcdefgh") }

  describe "#get_companies" do
    it "returns all companies matcing the search parameters" do
      changed_after = DateTime.now

      savon.expects(:get_companies).with(message: {
        searchParams: {
          CompanyId: 1234,
          CompanyName: "ACME",
          ChangedAfter: changed_after
        },
        returnProperties: []
      }).returns(get_companies_response)

      c = TwentyfourSevenOffice::Services::Company.new(session_id)
      response = c.get_companies company_id: 1234,
                                 company_name: "ACME",
                                 changed_after: changed_after

      expect(response).to be_successful 
    end
  end
end
