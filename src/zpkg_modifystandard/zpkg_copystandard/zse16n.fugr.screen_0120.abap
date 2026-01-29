PROCESS BEFORE OUTPUT.

  module fill_tc_0100.
  MODULE STATUS_0100.
  module get_linecount_0100.

  CALL SUBSCREEN tab_sub INCLUDING sy-repid '0121'.
*
PROCESS AFTER INPUT.

  module back at exit-command.

  field gd-variant   module check_alv_variant.
  field gd-max_lines module get_max_lines.
  "field gd-min_count module get_min_count.
  "field gd-fda       module get_fda.
  chain.
    field gd-dbcon     module get_dbcon on chain-request.
    field gd-tab       module get_tab on chain-request.
  endchain.

  CALL SUBSCREEN tab_sub.   " screen 121
  MODULE fcode_0120.

PROCESS ON VALUE-REQUEST.

  field gd-tab module f4_tab.

  field gd-variant        module alv_variant_f4.
  " field gd-add_field      module add_field_f4.
  field gd-ojkey          module ojkey_f4.
  "FIELD gd-formula_name   MODULE formula_f4.
  field gd_add_column     module f4_add_column.
