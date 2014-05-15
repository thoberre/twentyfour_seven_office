module TwentyfourSevenOffice
  module DataTypes
    class Company
      include Virtus.model

      attribute :id, Integer
      attribute :name, String
      attribute :addresses, Addresses
      attribute :phone_numbers, PhoneNumbers
      attribute :email_addresses, EmailAddresses
    end
  end
end
