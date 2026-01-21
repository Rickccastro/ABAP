*&---------------------------------------------------------------------*
*& Report ZMM_LOADPURCHASEORDER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMM_LOADPURCHASEORDER.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME .
  PARAMETERS : p_file TYPE ibipparms-path OBLIGATORY,
               p_ncol TYPE i OBLIGATORY DEFAULT 10.
SELECTION-SCREEN END OF BLOCK b1 .

*--------------------------------------------------------------------*
* at selection screen
*--------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  DATA: lv_rc TYPE i.
  DATA: lt_file_table TYPE filetable,
        ls_file_table TYPE file_table.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title = 'Select a file'
    CHANGING
      file_table   = lt_file_table
      rc           = lv_rc.
  IF sy-subrc = 0.
    READ TABLE lt_file_table INTO ls_file_table INDEX 1.
    p_file = ls_file_table-filename.
  ENDIF.
