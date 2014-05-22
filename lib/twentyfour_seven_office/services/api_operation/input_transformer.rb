module TwentyfourSevenOffice
  module Services
    class ApiOperation::InputTransformer
      extend TwentyfourSevenOffice::Utils

      def self.transform_input(input_data_types, input_hash)
        message = {}

        input_hash.each do |name_sym, value|
          input = case value
          when Array
            input_data_types[name_sym].to_request(value)
          when TwentyfourSevenOffice::DataTypes::DataType
            value.to_request
          else
            value
          end

          message[camelcase(name_sym, true)] = input
        end

        message
      end

      private

      def self.to_request(data)
        attrs = data.attributes.reject { |k, v| v.nil? }.map { |k, v| [camelcase(k), v] }
        Hash[attrs]
      end
    end
  end
end
