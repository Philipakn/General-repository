
MODULE status_0300 OUTPUT.
  SET PF-STATUS '300'.
  SET TITLEBAR '300'.

* Copy the displayed row from working area wa_pro to z071_products.
  z071_products = wa_pro.

ENDMODULE.
