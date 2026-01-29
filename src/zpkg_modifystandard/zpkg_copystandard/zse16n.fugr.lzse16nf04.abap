*----------------------------------------------------------------------*
***INCLUDE LSE16NF04.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_fin_flags
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_fin_flags .

  DATA: ls_flags     TYPE tfin_flags.
  DATA: lt_fin_flags TYPE tt_fin_flags.
  DATA: ls_fin_flags TYPE fin_flags.
  FIELD-SYMBOLS: <f>, <param>.

  ls_flags-application     = c_fin_flags_appl-ca.
  ls_flags-sub_application = c_fin_flags_subappl-tools.

  CALL FUNCTION 'FIN_FLAGS_BUFFER_FILL'
    EXPORTING
      is_flags = ls_flags.

  CALL FUNCTION 'FIN_FLAGS_BUFFER_GIVE'
    CHANGING
      ct_fin_flags = lt_fin_flags.

  LOOP AT lt_fin_flags INTO ls_fin_flags.
    ASSIGN COMPONENT ls_fin_flags-parameter_name OF
           STRUCTURE gd_flags TO <f>.
    CHECK: sy-subrc = 0.
    <f> = ls_fin_flags-value_from.
  ENDLOOP.

ENDFORM.
