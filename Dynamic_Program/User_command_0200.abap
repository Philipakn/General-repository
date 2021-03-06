
MODULE user_command_0200 INPUT.

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

    WHEN 'SAVE'.
      CALL FUNCTION 'ENQUEUE_ESSPFLI'
        EXPORTING
          mode_spfli     = 'E'
          mandt          = sy-mandt
          carrid         = spfli-carrid
          connid         = spfli-connid
        EXCEPTIONS
          foreign_lock   = 1
          system_failure = 2
          OTHERS         = 3.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
      IF spfli <> wa_flight.
        MODIFY spfli FROM spfli.
        CALL FUNCTION 'DEQUEUE_ESSPFLI'
          EXPORTING
            mode_spfli = 'E'
            mandt      = sy-mandt
            carrid     = spfli-carrid
            connid     = spfli-connid.
      ENDIF.

  ENDCASE.
  CLEAR ok_code.

ENDMODULE.
