module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:InvoiceService_DataTypes#InvoiceRow
    class InvoiceRow < DataType
      attribute :product_id, Integer
      attribute :row_id, Integer
      attribute :sequence_number, Integer
      attribute :vat_rate, Float
      attribute :price, Float
      attribute :name, String
      attribute :discount_rate, Float
      attribute :quantity, Float
      attribute :cost, Float
      attribute :change_state, String
    end
  end
end
