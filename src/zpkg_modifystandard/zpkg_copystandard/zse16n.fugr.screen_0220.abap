PROCESS BEFORE OUTPUT.
  MODULE set_status_0220.
*
PROCESS AFTER INPUT.
  module back at exit-command.

  field gd-max_lines module get_max_lines on request.

  MODULE fcode_0220.

PROCESS ON VALUE-REQUEST.

  field gd_add_column module f4_add_column.



































