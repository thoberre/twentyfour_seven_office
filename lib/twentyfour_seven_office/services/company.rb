module TwentyfourSevenOffice
  module Services
    class Company < Service
      client wsdl: "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      global :convert_request_keys_to, :none

      def initialize(session_id)
        @session_id = session_id
      end

      def get_companies(search_params)
        api_operation({ input_data_type: CompanySearchParameters }).call(search_params)
      end
    end
  end
end
