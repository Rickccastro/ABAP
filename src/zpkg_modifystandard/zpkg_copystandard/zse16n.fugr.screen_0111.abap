PROCESS BEFORE OUTPUT.
  MODULE STATUS_0111.
  module get_linecount_0111.

  LOOP AT GT_MULTI_OR WITH CONTROL MULTI_OR_TC CURSOR
                                      MULTI_OR_TC-CURRENT_LINE.
     MODULE SHOW_LINES_or.
     MODULE CHANGE_SCREEN_or.
     MODULE GET_LOOPLINES_sel.
  ENDLOOP.
*
PROCESS AFTER INPUT.

  LOOP AT GT_Multi_or.
    CHAIN.
     FIELD GS_multi_or-LOW.
     FIELD GS_multi_or-HIGH.
     FIELD GS_multi_or-mark.
        MODULE TAKE_DATA_OR ON CHAIN-REQUEST.
    ENDCHAIN.
  ENDLOOP.

  MODULE USER_COMMAND_0111.

PROCESS ON VALUE-REQUEST.

  field gs_multi_or-low  module field_f4_low_or.
  field gs_multi_or-high module field_f4_high_or.
