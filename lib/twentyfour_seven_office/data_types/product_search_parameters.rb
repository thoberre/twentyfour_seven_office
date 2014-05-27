module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:ProductService_DataTypes#ProductSearchParameters
    class ProductSearchParameters < DataType
      attribute :id, Integer
      attribute :no, String
      attribute :ean1, String
      attribute :name, String
      attribute :price, Float
      attribute :date_changed, DateTime
    end
  end
end
