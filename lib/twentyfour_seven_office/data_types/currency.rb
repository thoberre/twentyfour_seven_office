module TwentyfourSevenOffice
  module DataTypes
    class Currency
      include Virtus.model

      attribute :rate, Float
      attribute :unit, Integer
      attribute :symbol, String
    end
  end
end
