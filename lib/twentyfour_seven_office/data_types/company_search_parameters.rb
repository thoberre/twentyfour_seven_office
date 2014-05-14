module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:CompanyService_DataTypes#CompanySearchParameters
    class CompanySearchParameters
      include Virtus.model

      attribute :company_id, Integer
      attribute :company_name, String
      attribute :changed_after, DateTime
      attribute :return_properties, Array[String]

      def to_message_hash
        search_params = {}

        search_params[:CompanyId] = company_id unless company_id.nil?
        search_params[:CompanyName] = company_name unless company_name.nil?
        search_params[:ChangedAfter] = changed_after unless changed_after.nil?

        { searchParams: search_params, returnProperties: return_properties }
      end
    end
  end
end
