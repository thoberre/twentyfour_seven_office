module TwentyfourSevenOffice
  module DataTypes
    class PhoneNumber
      include Virtus.model

      attribute :description, String
      attribute :value, String
    end
  end
end
