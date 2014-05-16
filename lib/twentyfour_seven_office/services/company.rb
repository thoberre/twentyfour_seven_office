module TwentyfourSevenOffice
  module Services
    class Company < Service
      wsdl "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      api_operation :get_companies,
                    input_data_types: { search_params: CompanySearchParameters, return_properties: Array }

      def where(query = {})
        return_params = ::TwentyfourSevenOffice::DataTypes::Company.new.attributes.keys
        return_params = return_params.map { |attr| camelcase(attr.to_s) }
        get_companies(search_params: query, return_properties: return_params)
      end
    end
  end
end
