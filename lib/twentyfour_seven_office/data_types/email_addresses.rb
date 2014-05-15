module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#EmailAddresses
    class EmailAddresses
      include Virtus.model

      attribute :home, EmailAddress
      attribute :invoice, EmailAddress
      attribute :primary, EmailAddress
      attribute :work, EmailAddress
      attribute :alternative, EmailAddress
    end
  end
end
