
REPORT z_071_ass1.

SELECTION-SCREEN BEGIN OF BLOCK a WITH FRAME TITLE TEXT-t00.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rbt1  RADIOBUTTON GROUP rb1.
SELECTION-SCREEN COMMENT 4(17) TEXT-t01.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rbt2  RADIOBUTTON GROUP rb1.
SELECTION-SCREEN COMMENT 4(17) TEXT-t02.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rbt3  RADIOBUTTON GROUP rb1.
SELECTION-SCREEN COMMENT 4(33) TEXT-t03.
PARAMETERS: input TYPE char5.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rbt4  RADIOBUTTON GROUP rb1.
SELECTION-SCREEN COMMENT 4(19) TEXT-t04.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK a.

INCLUDE z_071_ass1_top_include.
DATA hold TYPE c.

CASE 'X'.

  WHEN rbt1.

    WRITE:TEXT-013 COLOR 7.
    CALL FUNCTION 'Z_071_GET_INF'.
    CALL FUNCTION 'Z_071_GET_PRODUCTS'
      EXPORTING
        text_01 = TEXT-001
        text_02 = TEXT-002
        text_03 = TEXT-003
        text_04 = TEXT-004
        text_05 = TEXT-005.

  WHEN rbt2.

    WRITE:TEXT-013 COLOR 7.
    CALL FUNCTION 'Z_071_GET_INF'.
    CALL FUNCTION 'Z_071_GET_INVOICES'
      EXPORTING
        text_06 = TEXT-006
        text_07 = TEXT-007
        text_08 = TEXT-008
        text_09 = TEXT-009
        text_10 = TEXT-010
        text_01 = TEXT-001
        text_11 = TEXT-011
        text_12 = TEXT-012.
    .

  WHEN rbt3.

    hold = input.
    IF hold < 1.
      MESSAGE e000(0k) WITH 'Invalid data. Please enter a value above 0.'.
    ELSE.
      WRITE:TEXT-013 COLOR 7.
      CALL FUNCTION 'Z_071_GET_INF'.
      CALL FUNCTION 'Z_071_JOIN_PROD_INVO'
        EXPORTING
          hold_2  = hold
          text_06 = TEXT-006
          text_07 = TEXT-007
          text_08 = TEXT-008
          text_09 = TEXT-009
          text_10 = TEXT-010
          text_01 = TEXT-001
          text_11 = TEXT-011
          text_12 = TEXT-012
          text_02 = TEXT-002
          text_03 = TEXT-003
          text_04 = TEXT-004
          text_05 = TEXT-005.
    ENDIF.

  WHEN rbt4.

    WRITE:TEXT-013 COLOR 7.
    CALL FUNCTION 'Z_071_GET_INF'.
    CALL FUNCTION 'Z_071_UPDATE_INVOICES'
      EXPORTING
        text_06 = TEXT-006
        text_07 = TEXT-007
        text_08 = TEXT-008
        text_09 = TEXT-009
        text_10 = TEXT-010
        text_01 = TEXT-001
        text_11 = TEXT-011
        text_12 = TEXT-012.
ENDCASE.
