module TwentyfourSevenOffice
  module Services
    class Company < Service
      wsdl "https://api.24sevenoffice.com/CRM/Company/V001/CompanyService.asmx?WSDL"

      api_operation :get_companies,
                    input_data_type: CompanySearchParameters,
                    output_data_type: TwentyfourSevenOffice::DataTypes::Company
    end
  end
end
