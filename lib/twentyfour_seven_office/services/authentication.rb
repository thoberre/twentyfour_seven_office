module TwentyfourSevenOffice
  module Services
    class Authentication < Service
      wsdl "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl"

      api_operation :login, input_data_type: Credential, output_data_type: SessionId
      api_operation :has_session

      def self.login(credential)
        new(nil).login(credential)
      end

      def self.has_session(session_id)
        r = new(session_id).has_session
        r.body[:has_session_response][:has_session_result]
      end

      class << self
        alias_method :has_session?, :has_session
      end
    end
  end
end
