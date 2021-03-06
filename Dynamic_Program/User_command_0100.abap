
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE PROGRAM.

    WHEN 'SELECT'.
      SELECT SINGLE * FROM spfli INTO wa_flight WHERE carrid = spfli-carrid AND
      connid = spfli-connid.
      CALL SCREEN '0200'.

    WHEN 'DISPLAY'.
      CALL FUNCTION 'ENQUEUE_ESSPFLI'
        EXPORTING
          mode_spfli     = 'S'
          mandt          = sy-mandt
          carrid         = spfli-carrid
          connid         = spfli-connid
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          OTHERS         = 3.

      SELECT SINGLE * FROM spfli INTO wa_flight WHERE carrid = spfli-carrid AND
        connid = spfli-connid.
      CALL SCREEN '0300'.
  ENDCASE.

  CLEAR ok_code.

ENDMODULE.
