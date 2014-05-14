module TwentyfourSevenOffice
  module Services
    class Authentication < Service
      client wsdl: "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl"

      global :convert_request_keys_to, :none

      def self.login(credential)
        new.api_operation({
          input_data_type: Credential,
          output_data_type: SessionId
        }).call(credential)
      end

      def self.has_session(session_id)
        r = new.api_operation({ session_id: session_id, name: :has_session }).call
        r.body[:has_session_response][:has_session_result]
      end

      class << self
        alias_method :has_session?, :has_session
      end
    end
  end
end
