module TwentyFourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://webservices.24sevenoffice.com/authenticate/authenticate.asmx?wsdl"

      global :convert_request_keys_to, :camelcase

      operations :login

      def self.login(username, password, application_id)
        super message: { 
          credential: {
            type: "Community",
            username: username,
            password: password,
            identity_id: application_id
          }
        }
      end
    end
  end
end
