module TwentyfourSevenOffice
  module DataTypes
    class DataType
      include Virtus.model
      include TwentyfourSevenOffice::Utils

      def to_request
        # TODO - needs to work recursively to support nested data types
        attrs = attributes.reject { |k, v| v.nil? }.map { |k, v| [camelcase(k), v] }
        Hash[attrs]
      end
    end
  end
end
