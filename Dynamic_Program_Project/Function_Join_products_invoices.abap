
FUNCTION Z_071_JOIN_PROD_INVO
  IMPORTING
    VALUE(HOLD_2) TYPE C
    VALUE(TEXT_06) TYPE C
    VALUE(TEXT_07) TYPE C
    VALUE(TEXT_08) TYPE C
    VALUE(TEXT_09) TYPE C
    VALUE(TEXT_10) TYPE C
    VALUE(TEXT_01) TYPE C
    VALUE(TEXT_11) TYPE C
    VALUE(TEXT_12) TYPE C
    VALUE(TEXT_02) TYPE C
    VALUE(TEXT_03) TYPE C
    VALUE(TEXT_04) TYPE C
    VALUE(TEXT_05) TYPE C.

  INCLUDE z_071_ass1_top_include.

  SELECT c~invoice_number
    c~invoice_date
    c~customer_name
    c~postal_code
    c~city
    c~product_id
    c~quantity
    c~amount
    f~brand
    f~type
    f~price
    f~product_size
    FROM z071_invoices AS c
    INNER JOIN z071_products AS f
    ON c~product_id = f~product_id
    INTO CORRESPONDING FIELDS OF TABLE it_pro_inv.

  IF sy-subrc = 0.

    WRITE: text_06  COLOR 2, text_07  COLOR 2, text_08  COLOR 2 ,'      ', text_09  COLOR 2, text_10  COLOR 2, text_01  COLOR 2,'        ',   '         ',
    text_11  COLOR 2,'       ', text_12  COLOR 2,'', text_02  COLOR 2,'       ', text_03  COLOR 2,'                       ', text_04 COLOR  2,' ', text_05  COLOR 2.

    LOOP AT it_pro_inv INTO wa_pro_inv WHERE product_id = hold_2.
      WRITE:/ wa_pro_inv-invoice_number, wa_pro_inv-invoice_date ,
      wa_pro_inv-customer_name , wa_pro_inv-postal_code ,
      wa_pro_inv-city, wa_pro_inv-product_id,wa_pro_inv-quantity,wa_pro_inv-amount,wa_pro_inv-brand
      , wa_pro_inv-type, wa_pro_inv-price, wa_pro_inv-product_size.
    ENDLOOP.

  ENDIF.

ENDFUNCTION.
