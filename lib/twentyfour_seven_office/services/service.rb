module TwentyfourSevenOffice
  module Services
    class Service
      extend Savon::Model
      include TwentyfourSevenOffice::DataTypes

      def initialize(session_id)
        @session_id = session_id
      end

      def self.api_operation(name_sym, opts = {})
        define_method name_sym do |input = nil|
          opts = opts.merge({ client: client, name: name_sym, session_id: @session_id })
          ApiOperation.new(opts).call(input)
        end
      end
    end
  end
end
