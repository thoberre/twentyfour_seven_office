module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#Company
    class Company < DataType
      class DistributionMethodString < Virtus::Attribute
        VALID_VALUES = %w{ Unchanged Print Email ElectronicInvoice }

        def coerce(value)
          return if value.nil?

          value = value.to_s

          if VALID_VALUES.include?(value)
            value
          else
            "Unchanged"
          end
        end
      end

      attribute :id, Integer
      attribute :organization_number, String
      attribute :name, String
      attribute :first_name, String
      attribute :nick_name, String
      attribute :addresses, Addresses
      attribute :phone_numbers, PhoneNumbers
      attribute :email_addresses, EmailAddresses
      attribute :url, String
      attribute :country, String
      attribute :note, String
      attribute :invoice_language, String
      attribute :type, String
      attribute :username, String
      attribute :password, String
      attribute :incorporation_date, DateTime
      attribute :date_created, DateTime
      attribute :status, Integer
      attribute :price_list, Integer
      attribute :owner, Integer
      attribute :bank_account_no, String
      attribute :terms_of_delivery_id, Integer
      attribute :account_debit, Integer
      attribute :account_credit, Integer
      attribute :discount, Float
      attribute :type_group, Integer
      attribute :share_capital, Float
      attribute :number_of_employees, Integer
      attribute :turnover, Float
      attribute :profit, Float
      attribute :industry_id, Integer
      attribute :member_no, Integer
      attribute :date_changed, DateTime
      attribute :block_invoice, Boolean
      # attribute :relations, Array[Relation]
      attribute :maps, Array[CompanyMap]
      attribute :distribution_method, DistributionMethodString

      def primary_phone_number
        if phone_numbers && phone_numbers.primary
          phone_numbers.primary.value
        end
      end

      def work_phone_number
        if phone_numbers && phone_numbers.work
          phone_numbers.work.value
        end
      end

      def mobile_phone_number
        if phone_numbers && phone_numbers.mobile
          phone_numbers.mobile.value
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
