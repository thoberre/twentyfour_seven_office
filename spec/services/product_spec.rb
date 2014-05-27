require "spec_helper"

describe TwentyfourSevenOffice::Services::Product do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:get_products_response) { xml_fixture :get_products_response }
  let(:session_id) { TwentyfourSevenOffice::DataTypes::SessionId.new(session_id: "abcdefgh") }
  let(:date_changed) { DateTime.now }

  describe "#get_products" do
    it "returns all products matcing the search parameters" do
      savon.expects(:get_products).with(message: {
        searchParams: {
          Id: 1234,
          Name: "Photo",
          DateChanged: date_changed
        },
        returnProperties: []
      }).returns(get_products_response)

      p = TwentyfourSevenOffice::Services::Product.new(session_id)

      search_params = TwentyfourSevenOffice::DataTypes::ProductSearchParameters.new(
        id: 1234, name: "Photo", date_changed: date_changed
      )
      products = p.get_products(search_params: search_params, return_properties: [])

      expect(products.length).to eq(2)
    end
  end

  describe "#where" do
    it "resolves returnProperties automatically based on Product attributes" do
      expected_return_props =
        TwentyfourSevenOffice::DataTypes::Product.xml_attribute_names

      savon.expects(:get_products).with(message: {
        searchParams: {
          DateChanged: date_changed,
        },
        returnProperties: { string: expected_return_props }
      }).returns(get_products_response)

      p = TwentyfourSevenOffice::Services::Product.new(session_id)

      p.where(date_changed: date_changed)
    end
  end

  describe "#all" do
    it "uses a date_changed date far back in time to ensure all products are returned" do
      expected_return_props =
        TwentyfourSevenOffice::DataTypes::Product.xml_attribute_names

      date_changed = DateTime.new(1970, 1, 1)

      savon.expects(:get_products).with(message: {
        searchParams: {
          DateChanged: date_changed,
        },
        returnProperties: { string: expected_return_props }
      }).returns(get_products_response)

      p = TwentyfourSevenOffice::Services::Product.new(session_id)

      p.all
    end
  end
end
