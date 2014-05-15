module TwentyfourSevenOffice
  module Services
    class ApiOperation::InputTransformer
      extend TwentyfourSevenOffice::Utils

      def self.transform_input(input_data_types, input_hash)
        message = {}

        input_hash.each do |name_sym, value|
          if value.is_a?(Array)
            input = value
          elsif value.is_a?(Hash)
            input = to_request(input_data_types[name_sym].new(value))
          else
            input = to_request(value)
          end
          
          message[camelcase(name_sym, true)] = input
        end

        message
      end

      def self.to_request(data)
        attrs = data.attributes.reject { |k, v| v.nil? }.map { |k, v| [camelcase(k), v] }
        Hash[attrs]
      end
    end
  end
end
