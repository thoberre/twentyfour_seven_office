module TwentyfourSevenOffice
  module DataTypes
    class EmailAddress
      include Virtus.model

      attribute :description, String
      attribute :name, String
      attribute :value, String
    end
  end
end
