module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#Category
    class Category < DataType
      attribute :id, Integer
      attribute :name, String
      attribute :show_contact, Boolean
      attribute :show_company, Boolean
    end
  end
end
