module TwentyfourSevenOffice
  module DataTypes
    class DataType
      include Virtus.model
      include TwentyfourSevenOffice::Utils

      def self.xml_attribute_names
        attribute_set.map { |a| TwentyfourSevenOffice::Utils.camelcase(a.name.to_s) }
      end

      def self.xml_type_name
        self.name.split("::").last
      end

      def xml_type_name
        self.class.xml_type_name
      end
    end
  end
end
