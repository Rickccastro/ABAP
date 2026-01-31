*&---------------------------------------------------------------------*
*& Report Z_TABLECONTROL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_TABLECONTROL_01.

DATA: gt_stravelag TYPE STANDARD TABLE OF stravelag.
DATA: gs_stravelag TYPE stravelag.

SELECTION-SCREEN BEGIN OF BLOCK b1.
  PARAMETERS p_count TYPE stravelag-country.
SELECTION-SCREEN END OF BLOCK b1.

*&SPWizard: Data incl. inserted by SP Wizard. DO NOT CHANGE THIS LINE!
INCLUDE Z_TABLECONTROL_TOP .

INCLUDE Z_TABLECONTROL_E01.

START-OF-SELECTION.
 SELECT * INTO TABLE gt_stravelag FROM stravelag where country = p_count.

   CALL SCREEN 9000.
