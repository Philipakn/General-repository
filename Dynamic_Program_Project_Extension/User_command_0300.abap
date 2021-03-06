
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
