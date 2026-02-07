*&---------------------------------------------------------------------*
*& Report Z_GLOBALCLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_globalclass.

START-OF-SELECTION.
  BREAK-POINT.
  zcl_customer_abap_playlist=>md_cpf_statico = '111'.

  DATA(lo_cliente) = NEW zcl_customer_abap_playlist( id_cpf = '123' id_name = 'Ricardo' ).


  BREAK-POINT.
