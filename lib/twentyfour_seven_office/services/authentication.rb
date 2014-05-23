module TwentyfourSevenOffice
  module Services
    class Authentication < Service
      wsdl "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl"

      api_operation :login, input_data_types: { credential: Credential }
      api_operation :has_session

      def self.login(credentials)
        if !hash_with_required_key?(credentials)
          login(credential: credentials)
        elsif credentials[:credential].is_a?(Hash)
          login(credential: TwentyfourSevenOffice::DataTypes::Credential.new(credentials[:credential]))
        else
          session_id = new(nil).login(credentials)
          SessionId.new(session_id: session_id)
        end
      end

      def self.has_session(session_id)
        new(session_id).has_session
      end

      class << self
        alias_method :has_session?, :has_session
      end

      private

      def self.hash_with_required_key?(value)
        value.is_a?(Hash) && value.has_key?(:credential)
      end
    end
  end
end
