*&---------------------------------------------------------------------*
*& Report Z_SORTEDTABLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_SORTEDTABLE.

START-OF-SELECTION.

  DATA: lt_scarr1 TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrid.

  DATA: lt_scarr2 TYPE SORTED TABLE OF scarr WITH UNIQUE KEY carrname.

  DATA: lt_scarr3 TYPE SORTED TABLE OF scarr
         WITH UNIQUE KEY carrid " Primary key
         WITH NON-UNIQUE SORTED KEY key2 COMPONENTS currcode carrname " Secondary key
         WITH NON-UNIQUE SORTED KEY key3 COMPONENTS carrname. " Secondary key

  DATA: lt_scarr4 TYPE TABLE OF scarr.

  SELECT * UP TO 5 ROWS FROM scarr INTO TABLE lt_scarr1.
  SELECT * UP TO 5 ROWS FROM scarr INTO TABLE lt_scarr2.
  SELECT * UP TO 5 ROWS FROM scarr INTO TABLE lt_scarr3.
  SELECT * UP TO 5 ROWS FROM scarr INTO TABLE lt_scarr4.

  SORT lt_scarr4 DESCENDING BY carrid.

  MOVE-CORRESPONDING lt_scarr4  TO lt_scarr1.

  READ TABLE lt_scarr1 INTO DATA(ls_scarr1) WITH TABLE KEY carrid = 'AA'.
  READ TABLE lt_scarr2 INTO DATA(ls_scarr2) WITH TABLE KEY carrname = 'American Airlines'.
  READ TABLE lt_scarr3 INTO DATA(ls_scarr3) WITH TABLE KEY key2 COMPONENTS currcode = 'USD' carrname = 'American Airlines'.
  READ TABLE lt_scarr3 INTO DATA(ls_scarr3_2) WITH TABLE KEY key3 COMPONENTS carrname = 'American Airlines'.

  BREAK-POINT.
