module TwentyfourSevenOffice
  module Services
    class Product < Service
      wsdl "https://api.24sevenoffice.com/Logistics/Product/V001/ProductService.asmx?WSDL"

      api_operation :get_products,
                    input_data_types: { search_params: ProductSearchParameters, return_properties: Array[String] }

      api_operation :save_products,
                    input_data_types: { products: Array[Product] }

      def where(query = {})
        search_params = TwentyfourSevenOffice::DataTypes::ProductSearchParameters.new(query)
        get_products(search_params: search_params, return_properties: return_props)
      end

      def all
        search_params = TwentyfourSevenOffice::DataTypes::ProductSearchParameters.new(
          date_changed: DateTime.new(1970, 1, 1)
        )
        get_products(search_params: search_params, return_properties: return_props)
      end

      private

      def return_props
        ::TwentyfourSevenOffice::DataTypes::Product.xml_attribute_names
      end
    end
  end
end
