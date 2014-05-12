module TwentyFourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://webservices.24sevenoffice.com/authenticate/authenticate.asmx?wsdl"

      operations :login

      Request = Struct.new(:username, :password, :application_id) do
        def to_s
          <<-XML
          <tns:credential>
            <tns:Type>Community</tns:Type>
            <tns:Username>#{username}</tns:Username>
            <tns:Password>#{password}</tns:Password>
            <tns:IdentityId>#{application_id}</tns:IdentityId>
          </tns:credential>
          XML
        end
      end

      def self.login(username, password, application_id)
        super message: Request.new(username, password, application_id)
      end

    end
  end
end
