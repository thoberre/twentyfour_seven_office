module TwentyfourSevenOffice
  module DataTypes
    class DataType
      include Virtus.model
      include TwentyfourSevenOffice::Utils

      def to_request
        attrs = attributes.reject { |k, v| v.nil? }.map do |k, v|
          if v.respond_to?(:to_request)
            v = v.to_request
          end

          [camelcase(k), v]
        end

        Hash[attrs]
      end
    end
  end
end
