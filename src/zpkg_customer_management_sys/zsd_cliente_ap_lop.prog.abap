*&---------------------------------------------------------------------*
*& Include          ZSD_CLIENTE_LOP
*&---------------------------------------------------------------------*

LOAD-OF-PROGRAM.
  gs_cliente-status = 'A'.
  DATA gd_field TYPE CHAR10.
  GET PARAMETER ID 'ZCLINR' FIELD gd_field.

  gd_zclinr = gd_field.
