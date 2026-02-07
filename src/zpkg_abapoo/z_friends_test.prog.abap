*&---------------------------------------------------------------------*
*& Report Z_FRIENDS_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_FRIENDS_TEST.

START-OF-SELECTION.

DATA(lo_ana) = NEW zcl_ana_friend1( ).
DATA(lo_maria) = NEW zcl_maria_friend2( ).

lo_ana->finance_situation( ).
SKIP.
lo_maria->show_secret( io_maria = lo_ana ).
