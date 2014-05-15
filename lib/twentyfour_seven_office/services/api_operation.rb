module TwentyfourSevenOffice
  module Services
    class ApiOperation
      include Virtus.model

      attribute :client, Savon::Client, required: true
      attribute :name, Symbol, required: true
      attribute :input_data_type, Class
      attribute :output_data_type, Class
      attribute :session_id, TwentyfourSevenOffice::DataTypes::SessionId

      def call(input = nil)
        opts = {}

        add_input(opts, input)
        add_session_cookie(opts)

        response = client.call(name, opts)

        result = response.body["#{name}_response".to_sym]["#{name}_result".to_sym]

        transform_result(result)
      rescue Savon::SOAPFault => e
        raise TwentyfourSevenOffice::Errors::APIError.wrap(e, session_id: session_id, input: input)
      end

      private

      def add_input(opts, input)
        if input
          if input.is_a?(Hash) && input_data_type
            input = input_data_type.new(input)
          end

          opts[:message] = input.to_request
        end
      end

      def add_session_cookie(opts)
        if session_id
          opts[:cookies] = [session_id.to_cookie]
        end
      end

      def transform_result(result)
        if output_data_type
          output_data_type.from_result_hash(result)
        else
          result
        end
      end
    end
  end
end
