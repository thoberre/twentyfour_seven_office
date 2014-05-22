module TwentyfourSevenOffice
  module Services
    class Invoice < Service
      wsdl "https://api.24sevenoffice.com/Economy/InvoiceOrder/V001/InvoiceService.asmx?WSDL"

      api_operation :save_invoices,
                    input_data_types: { invoices: ArrayOf[InvoiceOrder] }

    end
  end
end
