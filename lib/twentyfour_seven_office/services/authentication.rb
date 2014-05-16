module TwentyfourSevenOffice
  module Services
    class Authentication < Service
      wsdl "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl"

      api_operation :login, input_data_types: { credential: Credential }
      api_operation :has_session

      def self.login(credentials_hash)
        unless credentials_hash.has_key?(:credential)
          credentials_hash = { credential: credentials_hash }
        end

        session_id = new(nil).login(credentials_hash)
        SessionId.new(session_id: session_id)
      end

      def self.has_session(session_id)
        new(session_id).has_session
      end

      class << self
        alias_method :has_session?, :has_session
      end
    end
  end
end
