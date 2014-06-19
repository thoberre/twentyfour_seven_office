module TwentyfourSevenOffice
  module Services
    class Invoice < Service
      wsdl "https://api.24sevenoffice.com/Economy/InvoiceOrder/V001/InvoiceService.asmx?WSDL"

      api_operation :save_invoices,
                    input_data_types: { invoices: Array[InvoiceOrder] }


      def save(invoice)
        if invoice.is_a?(Hash)
          invoice = TwentyfourSevenOffice::DataTypes::InvoiceOrder.new(invoice)
        end

        saved = save_invoices(invoices: [invoice])

        if saved
          if saved.api_exception
            raise TwentyfourSevenOffice::Errors::APIError.new(saved.api_exception.message)
          end

          saved.order_id
        else
          nil
        end
      end

    end
  end
end
