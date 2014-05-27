module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:ProductService_DataTypes#Product
    class Product < DataType
      attribute :id, Integer
      attribute :name, String
      attribute :stock, Float
      attribute :status_id, Integer
      attribute :category_id, Integer
      attribute :price_group_id, Integer
      attribute :in_price, Float
      attribute :description, String
      attribute :cost, Float
      attribute :ean1, String
      attribute :price, Float
      attribute :no, String
      attribute :date_changed, DateTime
      attribute :api_exception, APIException
      attribute :weight, Float
      attribute :minimum_stock, Float
      attribute :order_proposal, Float
      attribute :stock_location, String
      attribute :supplier_product_code, String
    end
  end
end
