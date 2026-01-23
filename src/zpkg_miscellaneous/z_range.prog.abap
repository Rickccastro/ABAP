*&---------------------------------------------------------------------*
*& Report Z_RANGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_range.

TYPES:rng_type TYPE RANGE OF scarr-carrid.
DATA: rng_table TYPE rng_type,
      wa_rng    TYPE LINE OF rng_type.

SELECT * UP TO 5 ROWS FROM scarr INTO TABLE @DATA(lt_scarr).

LOOP AT lt_scarr INTO DATA(ls_scarr).
  wa_rng-sign = 'I'.
  wa_rng-option = 'EQ'.
  wa_rng-low = ls_scarr-carrid.
  APPEND wa_rng TO rng_table.
ENDLOOP.

BREAK-POINT.

SELECT * FROM scarr INTO TABLE @DATA(lt_scarr2) WHERE carrid IN @rng_table.
BREAK-POINT.
