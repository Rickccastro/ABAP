*----------------------------------------------------------------------*
***INCLUDE Z_TABLECONTROL_E01.
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
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'US'.
     SELECT * INTO TABLE gt_stravelag FROM stravelag WHERE country = 'US'.
    WHEN 'All'.
     SELECT * INTO TABLE gt_stravelag FROM stravelag.
    WHEN OTHERS.
  ENDCASE.

ENDMODULE.

*&SPWIZARD: OUTPUT MODULE FOR TC 'TC9000'. DO NOT CHANGE THIS LINE!
*&SPWIZARD: UPDATE LINES FOR EQUIVALENT SCROLLBAR
MODULE tc9000_change_tc_attr OUTPUT.
  DESCRIBE TABLE gt_stravelag LINES TC9000-LINES.
ENDMODULE.
