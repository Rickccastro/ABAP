*&---------------------------------------------------------------------*
*& Include          ZCONSULTA_CLIENTE_AP_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK main WITH FRAME.
  SELECT-OPTIONS s_zclinr FOR gs_cliente-zclinr.
  SELECT-OPTIONS s_nome FOR gs_cliente-nome.
  SELECT-OPTIONS s_email FOR gs_cliente-email.
  SELECT-OPTIONS s_limite FOR gs_cliente-limite_credito.
  SELECT-OPTIONS s_status FOR gs_cliente-status.
  SELECT-OPTIONS s_erdat FOR gs_cliente-erdat.
  SELECT-OPTIONS s_erzet FOR gs_cliente-erzet.

  PARAMETERS: p_limit TYPE int4.

SELECTION-SCREEN END OF BLOCK main.
