module TwentyfourSevenOffice
  module Services
    class Company
      extend Savon::Model

      client wsdl: "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      global :convert_request_keys_to, :none

      operations :get_companies

      def initialize(session_id)
        @session_id = session_id
      end

      def self.get_companies(session_id, search_params)
        if search_params.is_a?(Hash)
          search_params = TwentyfourSevenOffice::DataTypes::CompanySearchParameters.new(search_params)
        end

        super message: search_params.to_message_hash, cookies: [session_id.to_cookie]
      rescue Savon::SOAPFault => e
        raise APIError.wrap(e, session_id: session_id, search_params: search_params)
      end

      def get_companies(search_params)
        self.class.get_companies(@session_id, search_params)
      end
    end
  end
end
