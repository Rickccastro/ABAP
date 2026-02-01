*----------------------------------------------------------------------*
***INCLUDE ZSD_CLIENTE_AP_E02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module PBO_9001 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE pbo_9001 OUTPUT.
  CLEAR gd_okcode.
  SET PF-STATUS 'S9001'.

  IF sy-tcode EQ 'ZSD002AP'.
    SET TITLEBAR 'EDIT'.
  ELSEIF sy-tcode EQ 'ZSD003AP'.
    SET TITLEBAR 'DEL'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  PAI_9001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9001 INPUT.

  CASE gd_okcode.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
    WHEN 'EXEC' OR ''.
      IF sy-tcode EQ 'ZSD002AP'.
        PERFORM modificar_cliente.
      ELSEIF sy-tcode EQ 'ZSD003AP'.
        PERFORM excluir_cliente.
      ENDIF.
  ENDCASE.

ENDMODULE.
