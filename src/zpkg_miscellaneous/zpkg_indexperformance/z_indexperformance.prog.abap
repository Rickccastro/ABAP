*&---------------------------------------------------------------------*
*& Report Z_INDEXPERFORMANCE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_INDEXPERFORMANCE.

DATA: lv_start TYPE i,
      lv_end   TYPE i.

DATA: lt_usr02 TYPE STANDARD TABLE OF usr02.

" Before Index in ANAME
" RESULTS: 66.278, 64.144, 63.180
" After Index in ANAME
" RESULTS: 33.357, 29.190, 33.901

" In S/4HANA, this is not necessary, and delete and update operations are slower.

PERFORM start_timer.


DO 100 TIMES.
    SELECT * INTO TABLE lt_usr02
      FROM usr02 BYPASSING BUFFER
      WHERE ANAME = 'DEVELOPER'.
ENDDO.

PERFORM stop_timer.

WRITE lv_end.

FORM start_timer.
  CLEAR: lv_start, lv_end.
  GET RUN TIME FIELD lv_start.
ENDFORM.

FORM stop_timer.
    GET RUN TIME FIELD lv_end.
    lv_end = lv_end - lv_start.
ENDFORM.
