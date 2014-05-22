module TwentyfourSevenOffice
  module DataTypes
    class DataType
      include Virtus.model
      include TwentyfourSevenOffice::Utils

      def to_request
        attrs = attributes.reject { |k, v| v.nil? }.map do |k, v|
          if is_array_of_data_types?(v)
            v = v.map { |item| item.to_request }
          elsif v.respond_to?(:to_request)
            v = v.to_request
          end

          [camelcase(k), v]
        end

        Hash[attrs]
      end

      private

      def is_array_of_data_types?(ary)
        ary.is_a?(Array) && ary.any? && ary.first.respond_to?(:to_request)
      end
    end
  end
end
