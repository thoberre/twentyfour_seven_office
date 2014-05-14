require "savon"
require "virtus"

require "twentyfour_seven_office/version"

require "twentyfour_seven_office/data_types/session_id"
require "twentyfour_seven_office/data_types/company_search_parameters"
require "twentyfour_seven_office/data_types/credential"

require "twentyfour_seven_office/services/api_operation"
require "twentyfour_seven_office/services/service"
require "twentyfour_seven_office/services/authentication"
require "twentyfour_seven_office/services/company"

module TwentyfourSevenOffice
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
