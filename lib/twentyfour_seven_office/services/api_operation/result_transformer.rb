module TwentyfourSevenOffice
  module Services
    class ApiOperation::ResultTransformer
      extend TwentyfourSevenOffice::Utils

      def self.transform_result(result)
        return result unless result.is_a?(Hash)

        output_data_type = resolve_output_data_type(result.keys.first)

        if output_data_type
          data_type_name = output_data_type.name.split("::").last.snakecase.to_sym
          data = result[data_type_name]
          
          if data.is_a?(Array)
            data.map { |d| output_data_type.new(d) }
          else
            output_data_type.new(data)
          end
        else
          result
        end
      end

      private

      def self.resolve_output_data_type(name_sym)
        TwentyfourSevenOffice::DataTypes.const_get(camelcase(name_sym))
      end
    end
  end
end
