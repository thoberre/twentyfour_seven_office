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
            input = input_data_types[name_sym].new(value).to_request
          else
            input = value.to_request
          end
          
          message[camelcase(name_sym, true)] = input
        end

        message
      end
    end
  end
end
