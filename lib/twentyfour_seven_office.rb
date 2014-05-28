require "savon"
require "virtus"

require "twentyfour_seven_office/version"
require "twentyfour_seven_office/utils"

require "twentyfour_seven_office/data_types/data_type"
require "twentyfour_seven_office/data_types/session_id"
require "twentyfour_seven_office/data_types/company_search_parameters"
require "twentyfour_seven_office/data_types/credential"
require "twentyfour_seven_office/data_types/address"
require "twentyfour_seven_office/data_types/addresses"
require "twentyfour_seven_office/data_types/phone_number"
require "twentyfour_seven_office/data_types/phone_numbers"
require "twentyfour_seven_office/data_types/email_address"
require "twentyfour_seven_office/data_types/email_addresses"
require "twentyfour_seven_office/data_types/company_map"
require "twentyfour_seven_office/data_types/company"
require "twentyfour_seven_office/data_types/api_exception"
require "twentyfour_seven_office/data_types/currency"
require "twentyfour_seven_office/data_types/invoice_row"
require "twentyfour_seven_office/data_types/invoice_order"
require "twentyfour_seven_office/data_types/product_search_parameters"
require "twentyfour_seven_office/data_types/product"

require "twentyfour_seven_office/services/api_operation/input"
require "twentyfour_seven_office/services/api_operation"
require "twentyfour_seven_office/services/api_operation/input_transformer"
require "twentyfour_seven_office/services/api_operation/result_transformer"
require "twentyfour_seven_office/services/service"
require "twentyfour_seven_office/services/authentication"
require "twentyfour_seven_office/services/company"
require "twentyfour_seven_office/services/product"

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
