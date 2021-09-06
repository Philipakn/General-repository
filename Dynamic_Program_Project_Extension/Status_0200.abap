
MODULE status_0200 OUTPUT.
  SET PF-STATUS '200'.
  SET TITLEBAR '200'.

* Copy the row from wa_inv to z071_invoices.
  z071_invoices = wa_inv.

ENDMODULE.
