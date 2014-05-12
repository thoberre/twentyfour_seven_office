module TwentyFourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://webservices.24sevenoffice.com/authenticate/authenticate.asmx?wsdl"

      operations :login

      Request = Struct.new(:username, :password, :application_id) do
        def to_s
          <<-XML
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
          XML
        end
      end

      def self.login(username, password, application_id)
        super message: Request.new(username, password, application_id)
      end

    end
  end
end
