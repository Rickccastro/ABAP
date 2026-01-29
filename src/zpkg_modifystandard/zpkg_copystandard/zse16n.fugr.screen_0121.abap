PROCESS BEFORE OUTPUT.

  LOOP AT GT_SELFIELDS WITH CONTROL SELFIELDS_TC CURSOR
                                      SELFIELDS_TC-CURRENT_LINE.
     MODULE SHOW_LINES_sel.
     MODULE CHANGE_SCREEN_sel.
     MODULE GET_LOOPLINES_sel.
  ENDLOOP.

*
PROCESS AFTER INPUT.

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
  ENDLOOP.

   MODULE fcode_0121. "


PROCESS ON VALUE-REQUEST.

  field gs_selfields-low  module field_f4_low.
  field gs_selfields-high module field_f4_high.
  field gs_selfields-setid module field_f4_setid.
