*----------------------------------------------------------------------*
***INCLUDE Z_STATUSGUI_E01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module PBO_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE pbo_9000 OUTPUT.
 SET PF-STATUS 'S9000'.
 SET TITLEBAR 'T9000'.
ENDMODULE.

MODULE pai_9000 INPUT.
  MESSAGE sy-ucomm TYPE 'S'.

  CASE SY-UCOMM.
*    CODIGOS DO STATUS GUI
    WHEN 'BACK'.
       LEAVE TO SCREEN 0.
     WHEN 'MP01'.
     WHEN 'EXECUTAR'.
     WHEN 'MP02'.
  ENDCASE.

ENDMODULE.
