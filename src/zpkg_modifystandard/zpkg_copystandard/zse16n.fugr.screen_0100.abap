PROCESS BEFORE OUTPUT.

  module fill_tc_0100.
  MODULE STATUS_0100.
  module get_linecount_0100.

  LOOP AT GT_SELFIELDS WITH CONTROL SELFIELDS_TC CURSOR
                                      SELFIELDS_TC-CURRENT_LINE.
     MODULE SHOW_LINES_sel.
     MODULE CHANGE_SCREEN_sel.
     MODULE GET_LOOPLINES_sel.
  ENDLOOP.

*
PROCESS AFTER INPUT.

  module back at exit-command.

  field gd-variant   module check_alv_variant.
  field gd-max_lines module get_max_lines.
  field gd-min_count module get_min_count.
  field gd-fda       module get_fda.
  chain.
    field gd-dbcon     module get_dbcon on chain-request.
    field gd-tab       module get_tab on chain-request.
  endchain.

  LOOP AT GT_SELFIELDS.
    CHAIN.
     FIELD GS_SELFIELDS-LOW.
     FIELD GS_SELFIELDS-HIGH.
     FIELD GS_SELFIELDS-mark.
     FIELD GS_SELFIELDS-sum_up.
     FIELD GS_SELFIELDS-group_by.
     FIELD GS_SELFIELDS-toplow.
     FIELD GS_SELFIELDS-sortorder.
     FIELD GS_SELFIELDS-order_by.
     FIELD GS_SELFIELDS-curr_add_up.
     FIELD GS_SELFIELDS-quan_add_up.
     FIELD GS_SELFIELDS-setid.
     FIELD GS_SELFIELDS-aggregate.
     FIELD GS_SELFIELDS-having_value.
     FIELD GS_SELFIELDS-no_input_conversion.
        MODULE TAKE_DATA_SEL ON CHAIN-REQUEST.
    ENDCHAIN.
*    FIELD GS_SELFIELDS-SETID
*               MODULE check_setid ON REQUEST.
  ENDLOOP.

  MODULE fcode_0100.

PROCESS ON VALUE-REQUEST.

  field gd-tab module f4_tab.

  field gs_selfields-low  module field_f4_low.
  field gs_selfields-high module field_f4_high.
  field gs_selfields-setid module field_f4_setid.
  field gd-variant        module alv_variant_f4.
  field gd-add_field      module add_field_f4.
  field gd-ojkey          module ojkey_f4.
  FIELD gd-formula_name   MODULE formula_f4.
  field gd_add_column     module f4_add_column.
