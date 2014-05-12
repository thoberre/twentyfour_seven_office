module TwentyFourSevenOffice
  module Services
    class Authentication
      extend Savon::Model

      client wsdl: "https://webservices.24sevenoffice.com/authenticate/authenticate.asmx?wsdl"

      operations :login

      Request = Struct.new(:username, :password, :application_id) do
        def to_s
          <<-XML
          <web:credential>
            <web:ApplicationId>#{application_id}</web:ApplicationId>
            <web:Password>#{password}</web:Password>
            <web:Username>#{username}</web:Username>
          </web:credential>
          XML
        end
      end

      def self.login(username, password, application_id)
        super message: Request.new(username, password, application_id)
      end

    end
  end
end
