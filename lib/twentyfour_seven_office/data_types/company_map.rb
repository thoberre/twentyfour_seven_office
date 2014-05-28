module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#CompanyMap
    class CompanyMap < DataType
      attribute :map_type, Integer
      attribute :external_id, String
      attribute :company_id, Integer
    end
  end
end
