module TwentyfourSevenOffice
  module Services
    class ApiOperation
      include Virtus.model

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
          opts[:message] = InputTransformer.transform_input(input_data_types, input_hash)
        end
      end

      def add_session_cookie(opts)
        if session_id
          opts[:cookies] = [session_id.to_cookie]
        end
      end

      def transform_result(result)
        ResultTransformer.transform_result(result)
      end
    end
  end
end
