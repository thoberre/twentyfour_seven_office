module TwentyfourSevenOffice
  module Services
    class ApiOperation
      class InputHash < Virtus::Attribute
        def coerce(value)
          if value.is_a?(::Hash)
            value.each do |k, v|
              # Prevent "double coercion"
              next if v.respond_to?(:to_request)

              if v.is_a?(Array)
                value[k] = ArrayInput.new
              elsif v < TwentyfourSevenOffice::DataTypes::DataType
                value[k] = DataTypeInput.new
              else
                value[k] = PlainObjectInput.new
              end
            end
          else
            value
          end
        end
      end

      class ApiOperation::PlainObjectInput
        def to_request(value)
          value
        end
      end

      class ApiOperation::DataTypeInput
        include TwentyfourSevenOffice::Utils

        def to_request(value)
          attrs = non_nil_attributes_of(value).map do |attr, v|
            if is_array_of_data_types?(v)
              v = ArrayInput.new.to_request(v)
            elsif data_type?(v)
              v = to_request(v)
            end

            [camelcase(attr), v]
          end

          Hash[attrs]
        end

        def data_type?(value)
          value.is_a?(TwentyfourSevenOffice::DataTypes::DataType)
        end

        private

        def non_nil_attributes_of(value)
          value.attributes.reject { |k, v| v.nil? }
        end

        def is_array_of_data_types?(ary)
          ary.is_a?(Array) && ary.any? && data_type?(ary.first)
        end

      end

      class ApiOperation::ArrayInput
        include TwentyfourSevenOffice::Utils

        def to_request(ary)
          if ary.any?
            { xml_type_name(ary).to_sym => convert_items(ary) }
          else
            ary
          end
        end

        private

        def convert_items(ary)
          data_type_input = DataTypeInput.new

          ary.map do |item|
            if data_type_input.data_type?(item)
              data_type_input.to_request(item)
            else
              item
            end
          end
        end

        def xml_type_name(value)
          class_const = value.first.class

          if class_const.respond_to?(:xml_type_name)
            class_const.xml_type_name
          else
            camelcase(class_const.name, true)
          end
        end
      end
    end
  end
end
