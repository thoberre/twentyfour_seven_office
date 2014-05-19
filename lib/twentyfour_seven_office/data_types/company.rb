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

      def primary_phone_number
        if phone_numbers && phone_numbers.primary
          phone_numbers.primary.value
        end
      end

      def fax_number
        if phone_numbers && phone_numbers.fax
          phone_numbers.fax.value
        end
      end

      def primary_email_address
        if email_addresses && email_addresses.primary
          email_addresses.primary.value
        end
      end

      def postal_address
        if addresses
          addresses.post
        end
      end
    end
  end
end
