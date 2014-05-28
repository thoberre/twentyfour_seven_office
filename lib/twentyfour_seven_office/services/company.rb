module TwentyfourSevenOffice
  module Services
    class Company < Service
      wsdl "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      api_operation :get_companies,
                    input_data_types: { search_params: CompanySearchParameters, return_properties: Array[String] }

      api_operation :save_companies, input_data_types: { companies: Array[Company] }

      api_operation :save_maps, input_data_types: { maps: Array[CompanyMap] }

      def where(query = {})
        search_params = TwentyfourSevenOffice::DataTypes::CompanySearchParameters.new(query)
        get_companies(search_params: search_params, return_properties: return_props)
      end

      def all
        search_params = TwentyfourSevenOffice::DataTypes::CompanySearchParameters.new(
          changed_after: DateTime.new(1970, 1, 1)
        )
        get_companies(search_params: search_params, return_properties: return_props)
      end

      def save(company)
        if company.is_a?(Hash)
          company = TwentyfourSevenOffice::DataTypes::Company.new(company)
        end

        company = save_companies(companies: [company])

        if company
          company.id
        else
          nil
        end
      end

      private

      def return_props
        ::TwentyfourSevenOffice::DataTypes::Company.xml_attribute_names
      end
    end
  end
end
