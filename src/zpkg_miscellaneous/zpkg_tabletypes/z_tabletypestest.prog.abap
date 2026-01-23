*&---------------------------------------------------------------------*
*& Report Z_TABLETYPESTEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_TABLETYPESTEST.

*Standard Table:

*We can access records either using the table index or the key. If we use the key the response time is in linear relation to the number of table entries.
*The key of a standard table is always NON-UNIQUE. Standard tables are generically index tables.
*
*Sorted table:
*
*The entries are always saved and sorted according to the key. We can access records either using the table index or the key.
*If we use the key, the response time is in logarithmic relation to the number of table entries since the system uses binary search.
* The key of a standard table can be either UNIQUE or NON-UNIQUE. Sorted tables are generically index tables.
*
*Hashed table:
*
*We can access hashed tables using their key only. The response time is constant and does not depend on the number of the entries since the system uses a hash algorithm.
* The key of a standard table must always be UNIQUE.

PARAMETERS: count TYPE i OBLIGATORY DEFAULT 1000.
TYPES: BEGIN OF ty_pair,
         key   TYPE i,
         value TYPE string,
       END OF ty_pair.
TYPES: tt_standard TYPE STANDARD TABLE OF ty_pair WITH KEY key,
       tt_sorted   TYPE SORTED TABLE OF ty_pair WITH UNIQUE KEY key,
       tt_hashed   TYPE HASHED TABLE OF ty_pair WITH UNIQUE KEY key.
DATA: lv_start    TYPE i,
      lv_end      TYPE i,
      lt_standard TYPE tt_standard,
      lt_sorted   TYPE tt_sorted,
      lt_hashed   TYPE tt_hashed,
      lv_size        TYPE i.
START-OF-SELECTION.
  lv_size = count.
  PERFORM insert_standard.
  PERFORM insert_sorted.
  PERFORM insert_hashed.
  PERFORM read_standard.
  PERFORM read_standard_binary.
  PERFORM read_sorted.
  PERFORM read_hashed.
FORM insert_standard.
  PERFORM start_timer.
  DO lv_size TIMES.
    DATA(line) = VALUE ty_pair( key = sy-index value = sy-index ).
    APPEND line TO lt_standard.
  ENDDO.
  PERFORM stop_timer.
  " WRITE: / 'standard table insertion: ' , lv_end.
ENDFORM.
FORM insert_sorted.
  PERFORM start_timer.
  DO lv_size TIMES.
    DATA(line) = VALUE ty_pair( key = sy-index value = sy-index ).
    INSERT line INTO TABLE lt_sorted.
  ENDDO.
  PERFORM stop_timer.
  " WRITE: / 'sorted table insertion: ' , lv_end.
ENDFORM.
FORM insert_hashed.
  PERFORM start_timer.
  DO lv_size TIMES.
    DATA(line) = VALUE ty_pair( key = sy-index value = sy-index ).
    INSERT line INTO TABLE lt_hashed.
  ENDDO.
  PERFORM stop_timer.
  " WRITE: / 'hashed table insertion: ' , lv_end.
ENDFORM.
FORM read_standard.
  PERFORM start_timer.
  DO lv_size TIMES.
    READ TABLE lt_standard ASSIGNING FIELD-SYMBOL(<standard>) WITH KEY key = sy-index.
    ASSERT sy-subrc = 0.
  ENDDO.
  PERFORM stop_timer.
  WRITE:/ 'standard table read: ', lv_end.
ENDFORM.
FORM read_standard_binary.
  SORT lt_standard BY key.
  PERFORM start_timer.
  DO lv_size TIMES.
    READ TABLE lt_standard ASSIGNING FIELD-SYMBOL(<standard>) WITH KEY key = sy-index BINARY SEARCH.
    ASSERT sy-subrc = 0.
  ENDDO.
  PERFORM stop_timer.
  WRITE:/ 'standard table binary read: ', lv_end.
ENDFORM.
FORM read_sorted.
  PERFORM start_timer.
  DO lv_size TIMES.
    READ TABLE lt_sorted ASSIGNING FIELD-SYMBOL(<sorted>) WITH KEY key = sy-index.
    ASSERT sy-subrc = 0.
  ENDDO.
  PERFORM stop_timer.
  WRITE:/ 'sorted table read: ', lv_end.
ENDFORM.
FORM read_hashed.
  PERFORM start_timer.
  DO lv_size TIMES.
    READ TABLE lt_hashed ASSIGNING FIELD-SYMBOL(<sorted>) WITH TABLE KEY key = sy-index.
    ASSERT sy-subrc = 0.
  ENDDO.
  PERFORM stop_timer.
  WRITE:/ 'hashed table read: ', lv_end.
ENDFORM.
FORM start_timer.
  CLEAR: lv_start, lv_end.
  GET RUN TIME FIELD lv_start.
ENDFORM.
FORM stop_timer.
  GET RUN TIME FIELD lv_end.
  lv_end = lv_end - lv_start.
ENDFORM.
