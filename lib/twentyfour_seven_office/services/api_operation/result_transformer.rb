module TwentyfourSevenOffice
  module Services
    class ApiOperation::ResultTransformer
      extend TwentyfourSevenOffice::Utils

      def self.transform_result(result)
        return result unless result.is_a?(Hash)

        data_type_name = result.keys.first
        output_data_type = resolve_output_data_type(data_type_name)

        if output_data_type
          data = result[data_type_name]

          if data.is_a?(Array)
            data.map do |d|
              output_data_type.new(rewrite_values_for_array_attributes(output_data_type, d))
            end
          else
            output_data_type.new(rewrite_values_for_array_attributes(output_data_type, data))
          end
        else
          result
        end
      end

      private

      def self.resolve_output_data_type(name_sym)
        TwentyfourSevenOffice::DataTypes.const_get(camelcase(name_sym))
      end

      # Rewrites the contents of the given hash to be compatible with
      # Virtus array attribute coercion. Example:
      #
      # {
      #   ...
      #   :maps => {
      #     :company_map => {:map_type => 1, :external_id => 5, :company_id => 10}
      #   }
      #   ...
      # }
      #
      # becomes
      #
      # {
      #   ...
      #   :maps => [{:map_type => 1, :external_id => 5, :company_id => 10}]
      #   ...
      # }
      #
      # Rewriting only happens for hash values where the matching
      # output data type attribute primitive is an Array (e.g. Company#maps).
      # Elements that are the only child of a parent element will be converted
      # to a hash by Savon. This method will however always wrap values in an Array.
      #
      # Bit of a hack, to be honest.
      def self.rewrite_values_for_array_attributes(output_data_type, data)
        output_data_type.attribute_set.each do |attr|
          # Should rewrite hash?
          if attr.primitive == Array && data[attr.name]
            # Get value to rewrite. For the 24SevenOffice API, there will
            # never be more than 1 key/value pair.
            values = data[attr.name].values.first
            # Wrap value in array if necessary
            values = values.is_a?(Array) ? values : [values]
            # Write the new hash value. The hash key that corresponds to
            # the type name has now been removed (:company_map in the example).
            data[attr.name] = values
          end
        end

        data
      end
    end
  end
end
