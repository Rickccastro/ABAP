*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTAP_ROUTES_01..................................*
DATA:  BEGIN OF STATUS_ZTAP_ROUTES_01                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTAP_ROUTES_01                .
CONTROLS: TCTRL_ZTAP_ROUTES_01
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTAP_ROUTES_01                .
TABLES: ZTAP_ROUTES_01                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
