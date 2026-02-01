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
    SET TITLEBAR 'T9000'.
  ELSEIF sy-tcode = 'ZSD002AP'.
    SET TITLEBAR 'T9001'.

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
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
      IF sy-tcode = 'ZSD001AP'.
        PERFORM inserir.
      ELSEIF sy-tcode = 'ZSD002AP'.
        PERFORM modificar.
      ENDIF.
  ENDCASE.

ENDMODULE.
