*&---------------------------------------------------------------------*
*& Report Z_EXCEPTION_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_exception_test.

START-OF-SELECTION.
  DATA(lo_order) = NEW zcl_order_abap_playlist( ).
*  DATA lo_exc TYPE REF TO ZCX_INVALID_MATERIAL.
*
**TRY.
**    lo_order->add_item(
**    EXPORTING
**      id_matnr = -1
**      id_qtde  = 1
**      id_price = '10.50'
**  ).
** MESSAGE 'VALID MATERIAL' TYPE 's' .
**CATCH ZCX_INVALID_MATERIAL INTO DATA(lo_exc).
*** MESSAGE 'INVALID MATERIAL' TYPE 'I' .
** MESSAGE: lo_exc->get_text( )  TYPE 'I'.
**
**ENDTRY.

" STATIC
*  TRY.
*      lo_order->static_check( ).
*
*    CATCH zcx_static_check.
*      MESSAGE 'Error static_check' TYPE 'I' .
*
*  ENDTRY.
*
*"NO Check
*    TRY.
*      lo_order->no_check( ).
*
*    CATCH ZCX_NO_CHECK.
*      MESSAGE 'Error  no_check' TYPE 'I' .
*
*  ENDTRY.
*
*  " DYNAMIC
*  TRY.
*      lo_order->dynamic_check( ).
*
*    CATCH zcx_dynamic_check.
*      MESSAGE 'Error dynamic_check' TYPE 'I' .
*
*  ENDTRY.



  SKIP.
  WRITE: 'END'.
