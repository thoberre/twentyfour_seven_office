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
        def to_request(value)
          value.to_request
        end
      end

      class ApiOperation::ArrayInput
        include TwentyfourSevenOffice::Utils

        def to_request(ary)
          ary.any? ? { xml_type_name(ary) => ary } : ary
        end

        private

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
