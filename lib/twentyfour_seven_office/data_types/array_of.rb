module TwentyfourSevenOffice
  module DataTypes
    class ArrayOf
      include TwentyfourSevenOffice::Utils

      def initialize(class_const)
        @xml_type_name = camelcase(class_const.name, true)
      end

      def self.[](class_const)
        new(class_const)
      end

      def to_request(value)
        value.any? ? { @xml_type_name => value } : value
      end
    end
  end
end
