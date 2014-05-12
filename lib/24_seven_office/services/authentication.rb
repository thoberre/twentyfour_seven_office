module TwentyFourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl"

      operations :login

      def self.login(username, password, application_id)
        res = super xml: %W{
          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://24sevenOffice.com/webservices">
           <soapenv:Header/>
           <soapenv:Body>
              <web:Login>
                 <web:credential>
                    <web:ApplicationId>#{application_id}</web:ApplicationId>
                    <web:Password>#{password}</web:Password>
                    <web:Username>#{username}</web:Username>
                 </web:credential>
              </web:Login>
           </soapenv:Body>
        </soapenv:Envelope>
        })
      end
    end
  end
end
