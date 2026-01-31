*----------------------------------------------------------------------*
***INCLUDE Z_TABLECONTROL_02_E01.
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
*&---------------------------------------------------------------------*
*&      Module  PAI_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pai_9000 INPUT.
  CASE SY-UCOMM.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

*&SPWIZARD: OUTPUT MODULE FOR TC 'TC9000'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: UPDATE LINES FOR EQUIVALENT SCROLLBAR
MODULE TC9000_CHANGE_TC_ATTR OUTPUT.
  DESCRIBE TABLE GT_PLANE LINES TC9000-lines.
ENDMODULE.

*&SPWIZARD: INPUT MODULE FOR TC 'TC9000'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: MODIFY TABLE
MODULE TC9000_MODIFY INPUT.
  MODIFY GT_PLANE
    FROM GS_PLANE
    INDEX TC9000-CURRENT_LINE.
ENDMODULE.
