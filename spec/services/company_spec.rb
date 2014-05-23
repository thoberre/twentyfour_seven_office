require "spec_helper"

describe TwentyfourSevenOffice::Services::Company do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:get_companies_response) { xml_fixture :get_companies_response }
  let(:session_id) { TwentyfourSevenOffice::DataTypes::SessionId.new(session_id: "abcdefgh") }
  let(:changed_after) { DateTime.now }

  describe "#get_companies" do
    it "returns all companies matcing the search parameters" do
      savon.expects(:get_companies).with(message: {
        searchParams: {
          CompanyId: 1234,
          CompanyName: "ACME",
          ChangedAfter: changed_after
        },
        returnProperties: []
      }).returns(get_companies_response)

      c = TwentyfourSevenOffice::Services::Company.new(session_id)

      search_params = TwentyfourSevenOffice::DataTypes::CompanySearchParameters.new(
        company_id: 1234, company_name: "ACME", changed_after: changed_after
      )
      companies = c.get_companies(search_params: search_params, return_properties: [])

      expect(companies.length).to eq(2)
    end
  end

  describe "#where" do
    it "resolves returnProperties automatically based on Company attributes" do
      expected_return_props =
        TwentyfourSevenOffice::DataTypes::Company.xml_attribute_names

      savon.expects(:get_companies).with(message: {
        searchParams: {
          ChangedAfter: changed_after,
        },
        returnProperties: { string: expected_return_props }
      }).returns(get_companies_response)

      c = TwentyfourSevenOffice::Services::Company.new(session_id)

      c.where(changed_after: changed_after)
    end
  end

  describe "#all" do
    it "uses a changed_after date far back in time to ensure all customers are returned" do
      expected_return_props =
        TwentyfourSevenOffice::DataTypes::Company.xml_attribute_names

      changed_after = DateTime.new(1970, 1, 1)

      savon.expects(:get_companies).with(message: {
        searchParams: {
          ChangedAfter: changed_after,
        },
        returnProperties: { string: expected_return_props }
      }).returns(get_companies_response)

      c = TwentyfourSevenOffice::Services::Company.new(session_id)

      c.all
    end
  end
end
