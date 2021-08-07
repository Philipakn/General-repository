
PROGRAM z_071_ass2.

*it_hold1 and it_hold2 are internal tables for holding data from the external tables.
DATA it_hold1 TYPE TABLE OF z071_invoices.
DATA it_hold2 TYPE TABLE OF z071_products.

TABLES z071_invoices.
TABLES z071_products.

DATA: ok_code   LIKE sy-ucomm.
DATA: wa_inv TYPE z071_invoices,
      wa_pro TYPE z071_products.
