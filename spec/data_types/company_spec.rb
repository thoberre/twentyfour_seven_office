require "spec_helper"

describe TwentyfourSevenOffice::DataTypes::Company do

  describe "attributes" do
    subject(:company) { described_class.new }

    describe "distribution_method" do
      it "accepts the value 'Unchanged'" do
        company.distribution_method = "Unchanged"
        expect(company.distribution_method).to eq("Unchanged")
      end

      it "accepts the value 'Email'" do
        company.distribution_method = "Email"
        expect(company.distribution_method).to eq("Email")
      end

      it "accepts the value 'Print'" do
        company.distribution_method = "Print"
        expect(company.distribution_method).to eq("Print")
      end

      it "accepts the value 'ElectronicInvoice'" do
        company.distribution_method = "ElectronicInvoice"
        expect(company.distribution_method).to eq("ElectronicInvoice")
      end

      it "coerces to 'Unchanged' if the value is not valid" do
        company.distribution_method = "Horse and carriage"
        expect(company.distribution_method).to eq("Unchanged")
      end
    end
  end

  describe ".xml_attribute_names" do
    it "returns the attributes as an array of camelcased strings" do
      expect(described_class.xml_attribute_names).to include(
        "Id", "Name", "OrganizationNumber", "Country", "Type", "Addresses",
        "PhoneNumbers", "EmailAddresses"
      )
    end
  end

  describe "#primary_phone_number" do
    it "returns nil when there are no phone numbers" do
      company = described_class.new(phone_numbers: nil)
      expect(company.primary_phone_number).to be_nil
    end

    it "returns the primary phone number" do
      phone_numbers = TwentyfourSevenOffice::DataTypes::PhoneNumbers.new(
        primary: TwentyfourSevenOffice::DataTypes::PhoneNumber.new(
          value: "22 22 22 22"
        )
      )

      company = described_class.new(phone_numbers: phone_numbers)
      expect(company.primary_phone_number).to eq("22 22 22 22")
    end
  end

  describe "#fax_number" do
    it "returns nil when there are no phone numbers" do
      company = described_class.new(phone_numbers: nil)
      expect(company.fax_number).to be_nil
    end

    it "returns the fax number" do
      phone_numbers = TwentyfourSevenOffice::DataTypes::PhoneNumbers.new(
        fax: TwentyfourSevenOffice::DataTypes::PhoneNumber.new(
          value: "12345678"
        )
      )

      company = described_class.new(phone_numbers: phone_numbers)
      expect(company.fax_number).to eq("12345678")
    end
  end

  describe "#mobile_phone_number" do
    it "returns nil when there are no phone numbers" do
      company = described_class.new(phone_numbers: nil)
      expect(company.mobile_phone_number).to be_nil
    end

    it "returns the mobile phone number" do
      phone_numbers = TwentyfourSevenOffice::DataTypes::PhoneNumbers.new(
        mobile: TwentyfourSevenOffice::DataTypes::PhoneNumber.new(
          value: "12345678"
        )
      )

      company = described_class.new(phone_numbers: phone_numbers)
      expect(company.mobile_phone_number).to eq("12345678")
    end
  end

  describe "#primary_email_address" do
    it "returns nil when there are no email addresses" do
      company = described_class.new(email_addresses: nil)
      expect(company.primary_email_address).to be_nil
    end

    it "returns the primary email address" do
      email_addresses = TwentyfourSevenOffice::DataTypes::EmailAddresses.new(
        primary: TwentyfourSevenOffice::DataTypes::EmailAddress.new(
          value: "test@example.com"
        )
      )

      company = described_class.new(email_addresses: email_addresses)
      expect(company.primary_email_address).to eq("test@example.com")
    end
  end

  describe "#postal_address" do
    it "returns nil when there are addresses" do
      company = described_class.new(addresses: nil)
      expect(company.postal_address).to be_nil
    end

    it "returns the postal address" do
      addresses = TwentyfourSevenOffice::DataTypes::Addresses.new(
        post: TwentyfourSevenOffice::DataTypes::Address.new(
          street: "Portveien 2"
        )
      )

      company = described_class.new(addresses: addresses)
      expect(company.postal_address.street).to eq("Portveien 2")
    end
  end
end
