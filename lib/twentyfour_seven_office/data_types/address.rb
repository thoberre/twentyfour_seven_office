module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#Address
    class Address
      include Virtus.model

      attribute :street, String
      attribute :state, String
      attribute :postal_code, String
      attribute :postal_area, String
      attribute :name, String
      attribute :city, String
      attribute :country, String
    end
  end
end
