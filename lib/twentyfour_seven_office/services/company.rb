module TwentyfourSevenOffice
  module Services
    class Company < Service
      wsdl "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      api_operation :get_companies,
                    input_data_types: { search_params: CompanySearchParameters, return_properties: Array }

      def where(query = {})
        get_companies(search_params: query, return_properties: return_props)
      end

      def all
        search_params = { changed_after: DateTime.new(1970, 1, 1) }
        get_companies(search_params: changed_after, return_properties: return_props)
      end

      private

      def return_props
        rp = ::TwentyfourSevenOffice::DataTypes::Company.new.attributes.keys
        rp.map { |attr| camelcase(attr.to_s) }
      end
    end
  end
end
