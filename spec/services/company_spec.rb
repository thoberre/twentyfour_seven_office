require "spec_helper"

# TODO need specs that verifies returned company data
# gets properly converted to datatype classes
describe TwentyfourSevenOffice::Services::Company do
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
          <GetCompaniesResult>
            <Company>
              <Id>1234</Id>
              <Name>ACME AS</Name>
              <Addresses>
                <Post xsi:nil="true" />
                <Delivery xsi:nil="true" />
                <Visit xsi:nil="true" />
                <Invoice>
                  <Street>Portveien 2</Street>
                  <PostalCode>0001</PostalCode>
                  <PostalArea>OSLO</PostalArea>
                </Invoice>
              </Addresses>
              <PhoneNumbers>
                <Home xsi:nil="true" />
                <Fax xsi:nil="true" />
                <Mobile xsi:nil="true" />
                <Primary>
                  <Value>22 22 22 22</Value>
                </Primary>
                <Work xsi:nil="true" />
              </PhoneNumbers>
              <EmailAddresses>
                <Home xsi:nil="true" />
                <Invoice xsi:nil="true" />
                <Primary>
                  <Value>contact@acme.com</Value>
                </Primary>
                <Work xsi:nil="true" />
                <Alternative xsi:nil="true" />
              </EmailAddresses>
              <Status>1</Status>
              <DistributionMethod>Print</DistributionMethod>
            </Company>

            <Company>
              <Id>5678</Id>
              <Name>Great Deals Inc.</Name>
              <Addresses>
                <Post xsi:nil="true" />
                <Delivery xsi:nil="true" />
                <Visit xsi:nil="true" />
                <Invoice>
                  <Street>Svingen 7</Street>
                  <PostalCode>0002</PostalCode>
                  <PostalArea>MOLDE</PostalArea>
                </Invoice>
              </Addresses>
              <PhoneNumbers>
                <Home xsi:nil="true" />
                <Fax xsi:nil="true" />
                <Mobile xsi:nil="true" />
                <Primary>
                  <Value>44 44 44 44</Value>
                </Primary>
                <Work xsi:nil="true" />
              </PhoneNumbers>
              <EmailAddresses>
                <Home xsi:nil="true" />
                <Invoice xsi:nil="true" />
                <Primary>
                  <Value>contact@gd.com</Value>
                </Primary>
                <Work xsi:nil="true" />
                <Alternative xsi:nil="true" />
              </EmailAddresses>
              <Status>1</Status>
              <DistributionMethod>EMail</DistributionMethod>
            </Company>
          </GetCompaniesResult>
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

      companies = c.get_companies company_id: 1234,
                                 company_name: "ACME",
                                 changed_after: changed_after

      expect(companies.length).to eq(2)
    end
  end
end
