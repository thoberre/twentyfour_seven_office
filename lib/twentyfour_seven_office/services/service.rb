module TwentyfourSevenOffice
  module Services
    class Service
      extend Savon::Model
      include TwentyfourSevenOffice::DataTypes

      def api_operation(opts)
        opts = opts.merge({ client: client })

        if opts[:name].nil?
          opts[:name] = __resolve_caller(caller).to_sym
        end

        if defined? @session_id && opts[:session_id].nil?
          opts[:session_id] = @session_id
        end

        ApiOperation.new(opts)
      end

      private

      def __resolve_caller(callstack)
        callstack[0][/`.*'/][1..-2]
      end
    end
  end
end
