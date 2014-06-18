module TwentyfourSevenOffice
  module DataTypes
    class SessionId < DataType

      attribute :session_id, String, required: true

      alias_method :to_s, :session_id

      def to_cookie
        HTTPI::Cookie.new("ASP.NET_SessionId=#{session_id}")
      end

      def throttle
        unless defined? @last_throttle_time
          @last_throttle_time = Time.now
          return
        end

        delta = Time.now - @last_throttle_time

        if delta < 1.0
          sleep 1.0 - delta
        end

        @last_throttle_time = Time.now
      end
    end
  end
end
