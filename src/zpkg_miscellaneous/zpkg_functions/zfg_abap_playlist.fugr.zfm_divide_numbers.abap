FUNCTION zfm_divide_numbers.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     REFERENCE(ID_VALUE1) TYPE  INT4
*"     REFERENCE(ID_VALUE2) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(ED_RESULT) TYPE  INT4
*"  EXCEPTIONS
*"      DIVIDE_BY_ZERO
*"----------------------------------------------------------------------

  IF id_value2 EQ 0.
    RAISE divide_by_zero.
  ENDIF.

  ed_result = id_value1 / id_value2.


ENDFUNCTION.
