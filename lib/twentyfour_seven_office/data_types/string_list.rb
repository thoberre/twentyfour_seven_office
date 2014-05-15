module TwentyfourSevenOffice
  module DataTypes
    class StringList
      include Virtus.model

      attribute :strings, Array[String]

      def to_request
        strings.map { |s| { string: s } }
      end
    end
  end
end
