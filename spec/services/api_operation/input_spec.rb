require "spec_helper"

describe TwentyfourSevenOffice::Services::ApiOperation::DataTypeInput do
  subject { described_class.new }

  describe "#to_request" do
    it "recursively converts data types to their xml compatible representations" do
      c = TwentyfourSevenOffice::DataTypes::Company.new(
        id: 1234,
        name: "ACME",
        country: "NO",
        type: "Consumer",
        addresses: {
          post: {
            street: "Portveien 2",
            country: "Norway"
          }
        },
        phone_numbers: {
          primary: {
            value: "11 11 11 11"
          }
        }
      )

      hash = subject.to_request(c)

      expect(hash).to eq({
        Id: 1234,
        Name: "ACME",
        Country: "NO",
        Type: "Consumer",
        Addresses: {
          Post: {
            Street: "Portveien 2",
            Country: "Norway"
          }
        },
        PhoneNumbers: {
          Primary: {
            Value: "11 11 11 11"
          }
        },
        Maps: []
      })
    end

    it "supports attributes for arrays of data types" do
      io = TwentyfourSevenOffice::DataTypes::InvoiceOrder.new(
        invoice_rows: [
          TwentyfourSevenOffice::DataTypes::InvoiceRow.new(price: 5.0),
          TwentyfourSevenOffice::DataTypes::InvoiceRow.new(price: 10.0),
          TwentyfourSevenOffice::DataTypes::InvoiceRow.new(price: 15.0)
        ]
      )

      hash = subject.to_request(io)

      expect(hash).to eq({
        InvoiceRows: {
          InvoiceRow: [{ Price: 5.0 }, { Price: 10.0 }, { Price: 15.0 }]
        }
      })
    end
  end
end
