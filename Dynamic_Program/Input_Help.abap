
MODULE input_help_0100 INPUT.

  DATA programe LIKE sy-repid.
  DATA dynnum LIKE sy-dynnr.
  programe = sy-repid.
  dynnum = sy-dynnr.

  TYPES: 	BEGIN OF values,
            carrid    TYPE spfli-carrid,
            connid    TYPE spfli-connid,
            countryfr TYPE spfli-countryfr,
            cityfrom  TYPE spfli-cityfrom,
            airpfrom  TYPE spfli-airpfrom,
            countryto TYPE spfli-countryto,
            cityto    TYPE spfli-cityto,
            airpto    TYPE spfli-airpto,
            deptime   TYPE spfli-deptime,
          END OF values.

  DATA values_tab TYPE TABLE OF values.

  DATA: dynpro_values TYPE TABLE OF dynpread,
        field_value   LIKE LINE OF dynpro_values.

  CLEAR: field_value, dynpro_values.
  field_value-fieldname = 'SPFLI-CARRID'.
  APPEND field_value TO dynpro_values.

  CALL FUNCTION 'DYNP_VALUES_READ'
    EXPORTING
      dyname             = programe
      dynumb             = dynnum
      translate_to_upper = 'X'
    TABLES
      dynpfields         = dynpro_values.
  READ TABLE dynpro_values INDEX 1 INTO field_value.

  SELECT *
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE values_tab
  WHERE carrid = field_value-fieldvalue.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield    = 'CONNID'
      dynpprog    = programe
      dynpnr      = dynnum
      dynprofield = 'SPFLI-CONNID'
      value_org   = 'S'
    TABLES
      value_tab   = values_tab.

ENDMODULE.
