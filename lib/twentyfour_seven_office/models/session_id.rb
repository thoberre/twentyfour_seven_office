module TwentyfourSevenOffice
  module Models
    class SessionId
      include Virtus.value_object

      values do
        attribute :session_id, String
      end

      def to_cookie
        HTTPI::Cookie.new("ASP.NET_SessionId=#{session_id}")
      end
    end
  end
end
