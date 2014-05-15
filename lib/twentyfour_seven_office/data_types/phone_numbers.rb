module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#PhoneNumbers
    class PhoneNumbers
      include Virtus.model

      attribute :home, PhoneNumber
      attribute :fax, PhoneNumber
      attribute :mobile, PhoneNumber
      attribute :primary, PhoneNumber
      attribute :work, PhoneNumber
    end
  end
end
