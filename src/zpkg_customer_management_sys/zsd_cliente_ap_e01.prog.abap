*&---------------------------------------------------------------------*
*& Include          ZSD_CLIENTE_E01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module PBO_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE pbo_9000 OUTPUT.

  CLEAR gd_okcode.


  SET PF-STATUS 'S9000'.
  IF sy-tcode = 'ZSD001AP'.
    SET TITLEBAR 'NEW'.
  ELSEIF sy-tcode = 'ZSD002AP'.
    SET TITLEBAR 'MOD'.

    LOOP AT SCREEN.
      IF SCREEN-NAME = 'GS_CLIENTE-ZCLINR'.
        SCREEN-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9000 INPUT.
  CASE gd_okcode.
    WHEN 'BACK'.
      "Leave sai da transacao atual ser vier de um call transaction,
      "Se não, não faz nada.
      LEAVE.
      "Volta p tela Anterior.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
      IF sy-tcode = 'ZSD001AP'.
        PERFORM inserir.
      ELSEIF sy-tcode = 'ZSD002AP'.
        PERFORM modificar.
      ENDIF.
  ENDCASE.

ENDMODULE.
