module TwentyfourSevenOffice
  module Services
    class ApiOperation
      include Virtus.model
      include TwentyfourSevenOffice::Utils

      attribute :client, Savon::Client, required: true
      attribute :name, Symbol, required: true
      attribute :input_data_types, Hash[Symbol => Class]
      attribute :session_id, TwentyfourSevenOffice::DataTypes::SessionId

      def call(input_hash)
        opts = {}

        add_inputs(opts, input_hash)
        add_session_cookie(opts)

        response = client.call(name, opts)

        result = response.body["#{name}_response".to_sym]["#{name}_result".to_sym]

        transform_result(result)
      rescue Savon::SOAPFault => e
        raise TwentyfourSevenOffice::Errors::APIError.wrap(e, session_id: session_id, input: input)
      end

      private

      def add_inputs(opts, input_hash)
        if input_hash
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

          opts[:message] = message
        end
      end

      def add_session_cookie(opts)
        if session_id
          opts[:cookies] = [session_id.to_cookie]
        end
      end

      def transform_result(result)
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

      def resolve_output_data_type(name_sym)
        TwentyfourSevenOffice::DataTypes.const_get(camelcase(name_sym))
      end
    end
  end
end
