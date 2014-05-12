require "savon"

require "24_seven_office/version"
require "24_seven_office/services/authentication"

module TwentyFourSevenOffice
  module Errors
    class BaseError < StandardError
      def initialize(msg = nil)
        super msg
        @context = {}
      end

      attr_accessor :context, :original_exception

      def self.wrap(original_exception, context = {})
        exception(original_exception.message).tap do |e|
          e.original_exception = original_exception
          e.context = context
        end
      end
    end

    class APIError < BaseError; end
  end
end
