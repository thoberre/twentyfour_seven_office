module TwentyfourSevenOffice
  module DataTypes
    class Company
      include Virtus.model

      attribute :id, Integer
      attribute :name, String
      attribute :addresses, Addresses
      attribute :phone_numbers, PhoneNumbers
      attribute :email_addresses, EmailAddresses

      def self.from_result_hash(result)
        companies = result[:company]

        if companies.is_a?(Hash)
          new(companies)
        else
          companies.map { |c| new(c) }
        end
      end
    end

  end
end
