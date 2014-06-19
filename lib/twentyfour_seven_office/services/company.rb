module TwentyfourSevenOffice
  module Services
    class Company < Service
      wsdl "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      api_operation :get_companies,
                    input_data_types: { search_params: CompanySearchParameters, return_properties: Array[String] }

      api_operation :save_companies, input_data_types: { companies: Array[Company] }

      api_operation :save_maps, input_data_types: { maps: Array[CompanyMap] }

      api_operation :get_statuses

      api_operation :get_categories

      api_operation :get_customer_categories, input_data_types: { customer_id: Integer }

      def where(query = {})
        search_params = TwentyfourSevenOffice::DataTypes::CompanySearchParameters.new(query)
        companies = get_companies(search_params: search_params, return_properties: return_props)
        as_array(companies)
      end

      def all
        search_params = TwentyfourSevenOffice::DataTypes::CompanySearchParameters.new(
          changed_after: DateTime.new(1970, 1, 1)
        )
        companies = get_companies(search_params: search_params, return_properties: return_props)
        as_array(companies)
      end

      def save(company)
        if company.is_a?(Hash)
          company = TwentyfourSevenOffice::DataTypes::Company.new(company)
        end

        company = save_companies(companies: [company])

        if company
          if company.api_exception
            raise TwentyfourSevenOffice::Errors::APIError.new(company.api_exception.message)
          end

          company.id
        else
          nil
        end
      end

      def categories_for(company)
        customer_category_ids = get_customer_categories(customer_id: company.id)
        customer_category_ids = [customer_category_ids] unless Array.try_convert(customer_category_ids)
        return customer_category_ids if customer_category_ids.empty?

        categories = get_categories
        categories.select { |c| customer_category_ids.include?(c.id) }
      end

      private

      def return_props
        ::TwentyfourSevenOffice::DataTypes::Company.xml_attribute_names
      end
    end
  end
end
