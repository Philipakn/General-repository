
MODULE user_command_0300 INPUT.

  CALL FUNCTION 'DEQUEUE_ESSPFLI'
    EXPORTING
      mode_spfli = 'S'
      mandt      = sy-mandt
      carrid     = spfli-carrid
      connid     = spfli-connid.

  CASE ok_code.

    WHEN 'LEAVE'.
      LEAVE PROGRAM.

    WHEN 'BACK'.

  ENDCASE.
  CLEAR ok_code.

ENDMODULE.
