
MODULE user_command_0100 INPUT.


  CASE ok_code.

    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'SELECT'.

*     Check if there is an invoice number or peoduct number input.
      IF z071_invoices-invoice_number IS NOT INITIAL AND z071_products-product_id IS INITIAL.

*     Fetch data from the external invoice table z071_invoices into it_hold1 to check if the entered invoice is in the table.
        CALL FUNCTION 'Z_071_INVOICE'
          IMPORTING
            ex_invoice = it_hold1.

*       Check if the invoice exist, if it exists enqueue before display if not display error message.
        READ TABLE it_hold1 WITH KEY invoice_number = z071_invoices-invoice_number TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          CALL FUNCTION 'ENQUEUE_EZ_Z071_INVOICES'
            EXPORTING
              mode_z071_invoices = 'S'
              mandtid            = sy-mandt
              invoice_number     = z071_invoices-invoice_number
            EXCEPTIONS
              foreign_lock       = 1
              system_failure     = 2
              OTHERS             = 3.
          IF sy-subrc <> 0.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.
          SELECT SINGLE * FROM z071_invoices INTO wa_inv WHERE invoice_number = z071_invoices-invoice_number.
          CALL SCREEN '0200'.
        ELSE.
          MESSAGE e000(z_071_mecl).
        ENDIF.
        CLEAR it_hold1.


      ELSEIF z071_invoices-invoice_number IS NOT INITIAL AND z071_products-product_id IS NOT INITIAL.

        CALL FUNCTION 'Z_071_INVOICE'
          IMPORTING
            ex_invoice = it_hold1.

*       Check if the invoice exist, if it exists enqueue before calling screen 0200 if not display error message.
        READ TABLE it_hold1 WITH KEY invoice_number = z071_invoices-invoice_number TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          CALL FUNCTION 'ENQUEUE_EZ_Z071_INVOICES'
            EXPORTING
              mode_z071_invoices = 'S'
              mandtid            = sy-mandt
              invoice_number     = z071_invoices-invoice_number
            EXCEPTIONS
              foreign_lock       = 1
              system_failure     = 2
              OTHERS             = 3.
          IF sy-subrc <> 0.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.
          SELECT SINGLE * FROM z071_invoices INTO wa_inv WHERE invoice_number = z071_invoices-invoice_number.
          CALL SCREEN '0200'.
        ELSE.
          MESSAGE e000(z_071_mecl).
        ENDIF.
        CLEAR it_hold1.


      ELSEIF z071_invoices-invoice_number IS INITIAL AND z071_products-product_id IS NOT INITIAL.

*     Fetch data from the external products table z071_products into it_hold2 to check if the entered product is in the table.
        CALL FUNCTION 'Z_071_PRODUCT'
          IMPORTING
            ex_product = it_hold2.

*       Check if the product exist, if it exists enqueue before calling screen 0300 if not then display error message.
        READ TABLE it_hold2 WITH KEY product_id = z071_products-product_id TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.

          CALL FUNCTION 'ENQUEUE_EZ_Z071_PRODUCTS'
            EXPORTING
              mode_z071_products = 'S'
              mandtid            = sy-mandt
              product_id         = z071_products-product_id
            EXCEPTIONS
              foreign_lock       = 1
              system_failure     = 2
              OTHERS             = 3.
          IF sy-subrc <> 0.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.

          SELECT SINGLE * FROM z071_products INTO wa_pro WHERE product_id = z071_products-product_id.
          CALL SCREEN '0300'.
        ELSE.
          MESSAGE e001(z_071_mecl).
        ENDIF.
        CLEAR it_hold2.
      ENDIF.

  ENDCASE.

  CLEAR ok_code.

ENDMODULE.
