module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#Company
    class Company
      include Virtus.model

      attribute :id, Integer
      attribute :name, String
      attribute :organization_number, String
      attribute :addresses, Addresses
      attribute :phone_numbers, PhoneNumbers
      attribute :email_addresses, EmailAddresses
    end
  end
end
