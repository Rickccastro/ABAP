PROCESS BEFORE OUTPUT.

  MODULE STATUS_2000.
  LOOP AT GT_SELFIELDS_DD WITH CONTROL DD_TC CURSOR
                                       DD_TC-CURRENT_LINE.
     MODULE DD_SHOW_LINES.
     MODULE DD_CHANGE_SCREEN.
     MODULE DD_GET_LOOPLINES.
  ENDLOOP.

*
PROCESS AFTER INPUT.

  module dd_exit at exit-command.

  field gd-variant   module check_alv_variant.

  LOOP AT GT_SELFIELDS_DD.
     MODULE dd_get_data.
  ENDLOOP.

  MODULE USER_COMMAND_2000.

PROCESS ON VALUE-REQUEST.

  field gd-ojkey          module ojkey_f4.
  field gd-variant        module alv_variant_f4.
