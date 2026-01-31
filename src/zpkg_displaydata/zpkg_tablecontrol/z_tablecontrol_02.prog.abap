*&---------------------------------------------------------------------*
*& Report Z_TABLECONTROL_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_TABLECONTROL_02.

DATA: gt_plane TYPE STANDARD TABLE OF saplane.
DATA: gs_plane TYPE saplane.

*SELECTION-SCREEN BEGIN OF BLOCK b1.
*  PARAMETERS p_count TYPE saplane-country.
*SELECTION-SCREEN END OF BLOCK b1.

*&SPWizard: Data incl. inserted by SP Wizard. DO NOT CHANGE THIS LINE!
INCLUDE Z_TABLECONTROL_02_TOP .
INCLUDE z_tablecontrol_02_e01.

START-OF-SELECTION.

SELECT * FROM saplane INTO TABLE gt_plane.
CALL SCREEN 9000.
