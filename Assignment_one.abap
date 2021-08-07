
*Main program

INCLUDE z_071_ass2_top                          .    " Global Data
* INCLUDE Z_071_ASS2_O01                          .  " PBO-Modules
* INCLUDE Z_071_ASS2_I01                          .  " PAI-Modules
* INCLUDE Z_071_ASS2_F01                          .  " FORM-Routines
INCLUDE z_071_ass2_status_0100.
INCLUDE z_071_ass2_user_command_0100.
INCLUDE z_071_ass2_status_0200.
INCLUDE z_071_ass2_user_command_0200.
INCLUDE z_071_ass2_status_0300.
INCLUDE z_071_ass2_user_command_0300.









*Top include

PROGRAM z_071_ass2.
*it_hold1 and it_hold2 are internal tables for holding data from the external tables.
DATA it_hold1 TYPE TABLE OF z071_invoices.
DATA it_hold2 TYPE TABLE OF z071_products.

TABLES z071_invoices.
TABLES z071_products.

DATA: ok_code   LIKE sy-ucomm.
DATA: wa_inv TYPE z071_invoices,
      wa_pro TYPE z071_products.
	  












*Status_0100

*----------------------------------------------------------------------*
***INCLUDE Z_071_ASS2_STATUS_0100.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS '100'.
 SET TITLEBAR '100'.
ENDMODULE.









*User_command_0100

*----------------------------------------------------------------------*
***INCLUDE Z_071_ASS2_USER_COMMAND_0100.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
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
          CALL FUNCTIN 'ENQUEUE_EZ_Z071_INVOICES'
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











*Status_0200

*----------------------------------------------------------------------*
***INCLUDE Z_071_ASS2_STATUS_0200.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS '200'.
  SET TITLEBAR '200'.

* Copy the row from wa_inv to z071_invoices.
  z071_invoices = wa_inv.

ENDMODULE.
















*User_command_0200

*----------------------------------------------------------------------*
***INCLUDE Z_071_ASS2_USER_COMMAND_0200.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*


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














*Status_0300

*----------------------------------------------------------------------*
***INCLUDE Z_071_ASS2_STATUS_0300.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0300 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0300 OUTPUT.
  SET PF-STATUS '300'.
  SET TITLEBAR '300'.

* Copy the displayed row from working area wa_pro to z071_products.
  z071_products = wa_pro.

ENDMODULE.

















*User_command_0300

*----------------------------------------------------------------------*
***INCLUDE Z_071_ASS2_USER_COMMAND_0300.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.

*Dequeue the products table after displaying
  CALL FUNCTION 'DEQUEUE_EZ_Z071_PRODUCTS'
    EXPORTING
      mode_z071_products = 'S'
      mandtid            = sy-mandt
      product_id         = z071_products-product_id.

  CASE ok_code.

    WHEN 'EXIT'.
      LEAVE PROGRAM.

    WHEN 'BACK'.
      CALL SCREEN '0100'.

    WHEN 'SAVE'.

* Enqueue the table to allow modification the dequeue and call screen 0100.
      CALL FUNCTION 'ENQUEUE_EZ_Z071_PRODUCTS'
        EXPORTING
          mode_z071_products = 'E'
          mandtid            = sy-mandt
          product_id         = z071_products-product_id
        EXCEPTIONS
          foreign_lock       = 1
          system_failure     = 2
          OTHERS             = 3.

      IF z071_products <> wa_pro.
        MODIFY z071_products FROM z071_products.

        CALL FUNCTION 'DEQUEUE_EZ_Z071_PRODUCTS'
          EXPORTING
            mode_z071_products = 'E'
            mandtid            = sy-mandt
            product_id         = z071_products-product_id.

      ENDIF.

      CALL SCREEN '0100'.

  ENDCASE.
  CLEAR ok_code.

ENDMODULE.
