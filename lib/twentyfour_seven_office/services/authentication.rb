module TwentyfourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl"

      global :convert_request_keys_to, :none

      operations :login

      def self.login(username, password, application_id)
        message = {
          credential: {
            ApplicationId: application_id,
            Password: password,
            Username: username
          }
        }
        r = super message: message
        r.body[:login_response][:login_result]
      rescue Savon::SOAPFault => e
        raise APIError.wrap(e, message)
      end
    end
  end
end
