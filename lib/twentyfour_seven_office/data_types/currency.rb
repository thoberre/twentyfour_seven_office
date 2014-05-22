module TwentyfourSevenOffice
  module DataTypes
    class Currency < DataType
      attribute :rate, Float
      attribute :unit, Integer
      attribute :symbol, String
    end
  end
end
