
REPORT z_071_exceptions.

INCLUDE z_071_class_exceptions_include.

PARAMETERS:
  fl_name  TYPE string,
  pl_type  TYPE string,
  add_seat TYPE i.

DATA: r_plane       TYPE REF TO lcl_airplane,
      it_plane_list TYPE TABLE OF REF TO lcl_airplane,
      lo_excp       TYPE REF TO zcx_071_planetype,
      lv_excp_text  TYPE string.

START-OF-SELECTION.
*-----------------------------------------------------------------------
  CREATE OBJECT r_plane.
  DATA lo_sy_excp TYPE REF TO cx_dynamic_check.

  TRY.
      r_plane->set_attributes(
        EXPORTING
        im_name = fl_name
        im_planetype = pl_type ).
    CATCH cx_sy_ref_is_initial INTO lo_sy_excp.
      IF lo_excp IS NOT INITIAL.
        lv_excp_text = lo_excp->get_text( ).
        WRITE: lv_excp_text,/.
        RETURN.
      ENDIF.
  ENDTRY.
*------------------------------------------------------------------------
TRY.
      r_plane->check_name( ).
    CATCH zcx_071_planetype INTO lo_excp.

      IF lo_excp IS NOT INITIAL.
        lv_excp_text = lo_excp->get_text( ).
        WRITE: lv_excp_text,/.
        RETURN.
      ENDIF.
  ENDTRY.
*------------------------------------------------------------------------
  TRY.
      r_plane->add_seats( im_add = add_seat ).
    CATCH zcx_071_planetype INTO lo_excp.

      IF lo_excp IS NOT INITIAL.
        lv_excp_text = lo_excp->get_text( ).
        WRITE: lv_excp_text,/.
        RETURN.
      ENDIF.
  ENDTRY.

  "Everything went right, display attributes of airplane.
  r_plane->get_attributes( ).
