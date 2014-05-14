module TwentyfourSevenOffice
  module DataTypes
    class SessionId
      include Virtus.value_object

      values do
        attribute :session_id, String
      end

      alias_method :to_s, :session_id

      def self.from_response(response)
        session_id = response.body[:login_response][:login_result]
        new(session_id: session_id)
      end

      def to_cookie
        HTTPI::Cookie.new("ASP.NET_SessionId=#{session_id}")
      end
    end
  end
end
