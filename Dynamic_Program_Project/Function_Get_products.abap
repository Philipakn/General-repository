
FUNCTION Z_071_GET_PRODUCTS
  IMPORTING
    VALUE(TEXT_01) TYPE C
    VALUE(TEXT_02) TYPE C
    VALUE(TEXT_03) TYPE C
    VALUE(TEXT_04) TYPE C
    VALUE(TEXT_05) TYPE C.

  INCLUDE z_071_ass1_top_include.

  IF sy-subrc = 0.
    WRITE: text_01 COLOR 2, '                ', text_02 COLOR 2,'        ',text_03 COLOR 2, '                       ', text_04 COLOR 2, text_05 COLOR 2.

    LOOP AT it_products INTO wa_products.
      WRITE:/ wa_products-product_id, wa_products-brand ,
      wa_products-type , wa_products-price ,
      wa_products-product_size.
    ENDLOOP.
  ENDIF.

ENDFUNCTION.
