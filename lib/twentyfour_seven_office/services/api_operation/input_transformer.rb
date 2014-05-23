module TwentyfourSevenOffice
  module Services
    class ApiOperation::InputTransformer
      extend TwentyfourSevenOffice::Utils

      def self.transform_input(input_data_types, input_hash)
        message = {}

        input_hash.each do |name_sym, value|
          message[camelcase(name_sym, true)] = input_data_types[name_sym].to_request(value)
        end

        message
      end
    end
  end
end
