module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#EmailAddress
    class EmailAddress < DataType
      attribute :description, String
      attribute :name, String
      attribute :value, String
    end
  end
end
