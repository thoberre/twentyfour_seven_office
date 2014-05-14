module TwentyfourSevenOffice
  module DataTypes
    class SessionId
      include Virtus.value_object

      values do
        attribute :session_id, String, required: true
      end

      alias_method :to_s, :session_id

      def to_cookie
        HTTPI::Cookie.new("ASP.NET_SessionId=#{session_id}")
      end
    end
  end
end
