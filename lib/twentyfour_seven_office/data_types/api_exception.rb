module TwentyfourSevenOffice
  module DataTypes
    class APIException
      include Virtus.value_object

      values do
        attribute :type, String
        attribute :message, String
        attribute :stack_trace, String
      end
    end
  end
end
