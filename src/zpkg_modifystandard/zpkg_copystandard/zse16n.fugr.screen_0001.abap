PROCESS BEFORE OUTPUT.

  MODULE STATUS_0001.
  module get_linecount_0001.

  LOOP AT GT_MULTI_SELECT WITH CONTROL MULTI_TC CURSOR
                                      MULTI_TC-CURRENT_LINE.
     MODULE SHOW_LINES_multi.
     MODULE CHANGE_SCREEN_multi.
     MODULE GET_LOOPLINES_multi.
  ENDLOOP.
*  module set_cursor_0001.

*
PROCESS AFTER INPUT.

  module back_0001 at exit-command.
  LOOP AT GT_MULTI_SELECT.
    CHAIN.
     FIELD GS_MULTI_SELECT-LOW.
     FIELD GS_MULTI_SELECT-HIGH.
*       MODULE TAKE_DATA_multi ON CHAIN-REQUEST.
        MODULE TAKE_DATA_multi.
    ENDCHAIN.
  ENDLOOP.

  module check_input.

  MODULE fcode_0001.

PROCESS ON VALUE-REQUEST.

  field gs_multi_select-low  module field_f4_multi_low.
  field gs_multi_select-high module field_f4_multi_high.























