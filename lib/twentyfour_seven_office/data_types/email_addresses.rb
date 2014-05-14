module TwentyfourSevenOffice
  module DataTypes
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
