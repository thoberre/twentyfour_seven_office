module TwentyfourSevenOffice
  module Services
    class Company < Service
      client wsdl: "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      global :convert_request_keys_to, :none

      api_operation :get_companies, input_data_type: CompanySearchParameters
    end
  end
end
