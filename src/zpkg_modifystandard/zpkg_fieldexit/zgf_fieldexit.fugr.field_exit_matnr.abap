FUNCTION FIELD_EXIT_MATNR.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     REFERENCE(INPUT)
*"  EXPORTING
*"     REFERENCE(OUTPUT)
*"----------------------------------------------------------------------

" INPUT = MATNR.

  IF input = '123'.
    MESSAGE 'ERRO - Material não pode ser utilizado' TYPE 'E'.
  ENDIF.

output = input.

ENDFUNCTION.
