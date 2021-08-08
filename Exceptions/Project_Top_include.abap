
CLASS lcl_airplane DEFINITION.
  PUBLIC SECTION.

    METHODS: set_attributes
      IMPORTING
        im_name      TYPE string
        im_planetype TYPE string,
      get_attributes,
      check_planetype
        RAISING zcx_071_planetype,
      check_name
        RAISING   zcx_071_planetype,
      add_seats
        IMPORTING im_add TYPE i
        RAISING   zcx_071_planetype.


  PRIVATE SECTION.
    DATA:gv_name      TYPE string,
         gv_planetype TYPE string,
         gv_max_seats TYPE i VALUE 300,
         gv_occ_seats TYPE i VALUE 255.

ENDCLASS.


*----------------------------------------------------

CLASS lcl_airplane IMPLEMENTATION.

  METHOD set_attributes.
    gv_name = im_name.
    gv_planetype = im_planetype.
  ENDMETHOD.

  METHOD get_attributes.
    WRITE:  / 'Flight name: ', gv_name,
            / 'Plane  type: ', gv_planetype.
    "display no. of occupied seats, only if it is below the maximum no. of seats
    IF gv_occ_seats <= gv_max_seats.
      WRITE: / 'Number of occupied seats: ' , gv_occ_seats.
    ENDIF.
  ENDMETHOD.

  METHOD check_planetype.
    TRANSLATE gv_planetype TO UPPER CASE.
    "Check if the planetype is in the list of valid planetypes.
    IF gv_planetype <> 'BOEING 737' AND gv_planetype <> 'AIRBUS 380'.
      RAISE EXCEPTION TYPE zcx_071_wrong_planetype
        EXPORTING
          planetype = gv_planetype.
    ENDIF.
  ENDMETHOD.

  METHOD check_name.
    TRANSLATE gv_name TO UPPER CASE.
    IF gv_name NE 'HAMBURG' AND gv_name NE 'MUNICH'.
      RAISE EXCEPTION TYPE zcx_071_wrong_flightname
        EXPORTING
          flightname = gv_name.
    ENDIF.
  ENDMETHOD.

  METHOD add_seats.
    gv_occ_seats = gv_occ_seats + im_add.
    IF gv_occ_seats > gv_max_seats.
      RAISE EXCEPTION TYPE zcx_071_max_seats
        EXPORTING
          max_seats = gv_max_seats.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
