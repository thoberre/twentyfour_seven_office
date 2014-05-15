module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#CompanySearchParameters
    class CompanySearchParameters
      include Virtus.model
      include InputDataType

      attribute :company_id, Integer
      attribute :company_name, String
      attribute :changed_after, DateTime
    end
  end
end
