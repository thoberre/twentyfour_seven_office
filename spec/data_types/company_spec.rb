require "spec_helper"

describe TwentyfourSevenOffice::DataTypes::Company do

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
