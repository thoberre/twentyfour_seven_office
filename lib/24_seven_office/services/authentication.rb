module TwentyFourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://webservices.24sevenoffice.com/authenticate/authenticate.asmx?wsdl"

      global :convert_request_keys_to, :none

      operations :login

      def self.login(username, password, application_id)
        super message: { 
          credential: {
            Type: "Community",
            Username: username,
            Password: password,
            IdentityId: application_id
          }
        }
      end
    end
  end
end
