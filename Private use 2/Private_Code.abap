
REPORT z_071_tutorial_ch4_a.

DATA it_spfli TYPE TABLE OF spfli.
DATA wa_spfli TYPE spfli.

** Selecting single row, which is selected?
**
SELECT SINGLE *
  FROM spfli
  INTO wa_spfli
 WHERE carrid = 'LH'.

WRITE /'1: Following data content of the workarea:'.
NEW-LINE.
WRITE: wa_spfli-carrid, wa_spfli-connid, wa_spfli-countryfr, wa_spfli-cityfrom, wa_spfli-fltime.

** Selecting external table spfli, copy rows to internal table
**

SELECT *
  FROM spfli
  INTO TABLE it_spfli
 WHERE carrid = 'LH'.

WRITE /'2: Following data content of the table:'.
NEW-LINE.
LOOP AT it_spfli INTO wa_spfli.
  WRITE: wa_spfli-carrid, wa_spfli-connid, wa_spfli-countryfr, wa_spfli-cityfrom, wa_spfli-fltime.
  NEW-LINE.
ENDLOOP.

** Access to row with index number
**
READ TABLE it_spfli INTO wa_spfli INDEX 2.

WRITE /'3: Following data content of the workarea:'.
NEW-LINE.
WRITE: wa_spfli-carrid, wa_spfli-connid, wa_spfli-countryfr, wa_spfli-cityfrom, wa_spfli-fltime.

** Modify external table spfli, change the flighttime to specific value
**
MOVE 500 TO wa_spfli-fltime.
MODIFY TABLE it_spfli FROM wa_spfli.
MODIFY spfli FROM TABLE it_spfli.
