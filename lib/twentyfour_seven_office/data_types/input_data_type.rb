module TwentyfourSevenOffice
  module DataTypes
    module InputDataType
      include TwentyfourSevenOffice::Utils

      def to_request
        attrs = attributes.reject { |k, v| v.nil? }.map { |k, v| [camelcase(k), v] }
        Hash[attrs]
      end
    end
  end
end
