
DATA it_products TYPE TABLE OF z071_products.
DATA wa_products TYPE z071_products.

DATA it_invoices TYPE TABLE OF z071_invoices.
DATA wa_invoices TYPE z071_invoices.

DATA:BEGIN OF wa_pro_inv,
       invoice_number TYPE z071_invoices-invoice_number,
       invoice_date   TYPE z071_invoices-invoice_date,
       customer_name  TYPE z071_invoices-customer_name,
       postal_code    TYPE z071_invoices-postal_code,
       city           TYPE z071_invoices-city,
       product_id     TYPE z071_products-product_id,
       quantity       TYPE z071_invoices-quantity,
       amount         TYPE z071_invoices-amount,
       brand          TYPE z071_products-brand,
       type           TYPE z071_products-type,
       price          TYPE z071_products-price,
       product_size   TYPE z071_products-product_size,
     END OF wa_pro_inv.

DATA it_pro_inv LIKE STANDARD TABLE OF wa_pro_inv.
DATA it_pro_inv2 LIKE STANDARD TABLE OF wa_pro_inv.

SELECT * FROM z071_products INTO TABLE it_products.
SELECT * FROM z071_invoices INTO TABLE it_invoices.
