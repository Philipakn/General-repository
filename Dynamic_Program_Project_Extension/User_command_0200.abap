
MODULE user_command_0200 INPUT.

* Dequeue the s lock from the from screen 0100
  CALL FUNCTION 'DEQUEUE_EZ_Z071_INVOICES'
    EXPORTING
      mode_z071_invoices = 'S'
      mandtid            = sy-mandt
      invoice_number     = z071_invoices-invoice_number.

  CASE ok_code.

    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'BACK'.
      CALL SCREEN '0100'.

    WHEN 'SAVE'.

*     Check if there are changes made by user then enqueue by exclusive for modification purposes.
      IF z071_invoices <> wa_inv.

        CALL FUNCTION 'ENQUEUE_EZ_Z071_INVOICES'
          EXPORTING
            mode_z071_invoices = 'E'
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

        MODIFY z071_invoices FROM z071_invoices.

*     The table gets dequeued after modification and screen 0100 is called.
        CALL FUNCTION 'DEQUEUE_EZ_Z071_INVOICES'
          EXPORTING
            mode_z071_invoices = 'E'
            mandtid            = sy-mandt
            invoice_number     = z071_invoices-invoice_number.
      ENDIF.

      CALL SCREEN '0100'.

  ENDCASE.
  CLEAR ok_code.

ENDMODULE.
