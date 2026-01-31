*&---------------------------------------------------------------------*
*& Include          ZSD_CLIENTE_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form salvar
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM salvar.

 gs_cliente-erdat = sy-datum.
 gs_cliente-erzet = sy-uzeit.

 INSERT ZSD_CLIENTE_AP FROM gs_cliente.

 IF sy-subrc = 0.
   MESSAGE 'Cliente cadastrado com sucesso' TYPE 'S'.
   ELSE.
     MESSAGE 'ERRO ao cadastrar cliente' TYPE 'S' DISPLAY LIKE 'E'.
 ENDIF.

ENDFORM.
