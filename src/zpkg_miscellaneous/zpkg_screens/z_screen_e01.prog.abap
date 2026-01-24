*----------------------------------------------------------------------*
***INCLUDE Z_SCREEN_E01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module PBO_1001 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE pbo_1001 OUTPUT.
      SET PF-STATUS 'S1001'.
      SET TITLEBAR  'T1001P' WITH 'Parameter-1' 'Parameter-2'.
ENDMODULE.

MODULE pai_1001 INPUT.
  CASE SY-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'BTN_SAVE'.
      MESSAGE 'CLICK NO BOTÃO REALIZADO' TYPE 'I'.
  ENDCASE.

ENDMODULE.
