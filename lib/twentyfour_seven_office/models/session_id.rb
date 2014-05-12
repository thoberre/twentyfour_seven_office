module TwentyfourSevenOffice
  module Models
    class SessionId
      include Virtus.value_object

      values do
        attribute :session_id, String
      end
    end
  end
end
