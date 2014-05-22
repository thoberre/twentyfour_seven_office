module TwentyfourSevenOffice
  module Services
    class ApiOperation::InputTransformer
      extend TwentyfourSevenOffice::Utils

      def self.transform_input(input_data_types, input_hash)
        message = {}

        input_hash.each do |name_sym, value|
          input = case value
          when Array
            value.any? ? { array_item_xml_type_name(value) => value } : value
          when Hash
            data = input_data_types[name_sym].new(value)
            to_request(data)
          else
            to_request(value)
          end

          message[camelcase(name_sym, true)] = input
        end

        message
      end

      private

      # Returns the "xml name" of the type of the
      # first element in the array.
      # All items in the array are expected to be
      # of the same type.
      def self.array_item_xml_type_name(ary)
        camelcase(ary.first.class.name, true)
      end

      def self.to_request(data)
        attrs = data.attributes.reject { |k, v| v.nil? }.map { |k, v| [camelcase(k), v] }
        Hash[attrs]
      end
    end
  end
end
