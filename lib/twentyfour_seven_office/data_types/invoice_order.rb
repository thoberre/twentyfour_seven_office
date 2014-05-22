module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:InvoiceService_DataTypes#InvoiceOrder
    class InvoiceOrder
      include Virtus.model

      attribute :order_id, Integer
      attribute :customer_id, Integer
      attribute :customer_name, String
      attribute :addresses, Addresses
      attribute :order_status, String
      attribute :invoice_id, Integer
      attribute :date_ordered, DateTime
      attribute :date_invoiced, DateTime
      attribute :payment_time, Integer
      attribute :customer_reference_no, String
      attribute :project_id, Integer
      attribute :our_reference, Integer
      attribute :include_vat, Boolean
      attribute :your_reference, String
      attribute :order_total_inc_vat, Float
      attribute :order_total_vat, Float
      attribute :invoice_title, String
      attribute :invoice_text, String
      attribute :paid, DateTime
      attribute :ocr, String
      attribute :customer_org_no, String
      attribute :currency, Currency
      attribute :payment_method_id, Integer
      attribute :payment_amount, Float
      attribute :production_manager_id, Integer
      attribute :sales_opportunity_id, Integer
      attribute :type_of_sale_id, Integer
      attribute :distributor, String
      attribute :distribution_method, String
      attribute :department_id, Integer
      attribute :external_status, Integer
      attribute :invoice_email_address, String
      attribute :invoice_rows, Array[InvoiceRow]
      attribute :api_exception, APIException
    end
  end
end
