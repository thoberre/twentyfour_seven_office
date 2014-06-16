module TwentyfourSevenOffice
  module Services
    class Service
      extend Savon::Model
      include TwentyfourSevenOffice::DataTypes
      include TwentyfourSevenOffice::Utils

      def initialize(session_id)
        @session_id = session_id
      end

      def self.wsdl(uri)
        client wsdl: uri
        global :convert_request_keys_to, :none
      end

      def self.api_operation(name_sym, opts = {})
        define_method name_sym do |input = nil|
          opts = opts.merge({ client: client, name: name_sym, session_id: @session_id })
          ApiOperation.new(opts).call(input)
        end
      end

      protected

      def as_array(obj_or_ary)
        ary = Array.try_convert(obj_or_ary) ? obj_or_ary : [obj_or_ary]
        ary.compact
      end
    end
  end
end
