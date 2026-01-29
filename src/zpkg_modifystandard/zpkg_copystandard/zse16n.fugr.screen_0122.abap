PROCESS BEFORE OUTPUT.
   MODULE STATUS_0122.
   MODULE get_linecount_0100.


PROCESS AFTER INPUT.
   MODULE fcode_0122.

 PROCESS ON VALUE-REQUEST.
   field gd-add_field      module add_field_f4.
   field gd-formula_name   module formula_f4.
