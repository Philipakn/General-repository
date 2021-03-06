
FUNCTION Z_071_GET_INVOICES
  IMPORTING
    VALUE(TEXT_06) TYPE C
    VALUE(TEXT_07) TYPE C
    VALUE(TEXT_08) TYPE C
    VALUE(TEXT_09) TYPE C
    VALUE(TEXT_10) TYPE C
    VALUE(TEXT_01) TYPE C
    VALUE(TEXT_11) TYPE C
    VALUE(TEXT_12) TYPE C.

  INCLUDE z_071_ass1_top_include.

  IF sy-subrc = 0.
    WRITE: / text_06  COLOR 4, text_07  COLOR 4, text_08  COLOR 4,'      ', text_09  COLOR 4, text_10  COLOR 4, text_01  COLOR 4,'              ', text_11  COLOR 4,'           ', text_12  COLOR 4.

    LOOP AT it_invoices INTO wa_invoices.
      WRITE:/ wa_invoices-invoice_number, wa_invoices-invoice_date,
      wa_invoices-customer_name, wa_invoices-postal_code,
      wa_invoices-city, wa_invoices-product_id, wa_invoices-quantity,
      wa_invoices-amount.
    ENDLOOP.
  ENDIF.

ENDFUNCTION.
