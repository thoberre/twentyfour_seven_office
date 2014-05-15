module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#PhoneNumber
    class PhoneNumber
      include Virtus.model

      attribute :description, String
      attribute :value, String
    end
  end
end
