module TwentyfourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl"

      global :convert_request_keys_to, :none

      operations :login, :has_session

      def self.login(credential)
        if credential.is_a?(Hash)
          credential = TwentyfourSevenOffice::DataTypes::Credential.new(credential)
        end

        r = super message: credential.to_message_hash
        session_id = r.body[:login_response][:login_result]
        TwentyfourSevenOffice::DataTypes::SessionId.new(session_id: session_id)
      rescue Savon::SOAPFault => e
        raise APIError.wrap(e, credential)
      end

      def self.has_session(session_id)
        r = super cookies: [session_id.to_cookie]
        r.body[:has_session_response][:has_session_result]
      end

      class << self
        alias_method :has_session?, :has_session
      end
    end
  end
end
