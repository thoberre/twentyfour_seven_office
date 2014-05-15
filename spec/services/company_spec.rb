require "spec_helper"

describe TwentyfourSevenOffice::Services::Company do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:get_companies_response) { xml_fixture :get_companies_response }
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

      companies = c.get_companies(search_params: {  company_id: 1234,
                                                    company_name: "ACME",
                                                    changed_after: changed_after },
                                  return_properties: [])

      expect(companies.length).to eq(2)
    end
  end
end
