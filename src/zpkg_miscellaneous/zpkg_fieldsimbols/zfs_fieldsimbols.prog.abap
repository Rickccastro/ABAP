*&---------------------------------------------------------------------*
*& Report ZFS_FIELDSIMBOLS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfs_fieldsimbols.

DATA: ls_scarr TYPE scarr,
      lt_scarr TYPE TABLE OF scarr,
      lt_scarr2 TYPE TABLE OF scarr.

FIELD-SYMBOLS: <fs_ch_text>  TYPE char5, <fs_ls_scarr> TYPE scarr.
"Compiling Error.
*FIELD-SYMBOLS: <fs_lt_scarr> TYPE TABLE OF scarr.
" We can only access the properties at runtime with the type any table.
*FIELD-SYMBOLS: <fs_lt_scarr> TYPE ANY TABLE.
FIELD-SYMBOLS: <fs_lt_scarr> LIKE lt_scarr.

ASSIGN lt_scarr TO <fs_lt_scarr>.

SELECT * FROM scarr INTO TABLE lt_scarr.

*  <fs_lt_scarr>[ 1 ]-.
*  <fs_lt_scarr>[ 1 ]-CARRID.


"DINAMIC FIELD-SIMBOLS
DATA: ld_varname TYPE char100,ld_varname2 TYPE char100.
DATA: ld_text    TYPE char100.

FIELD-SYMBOLS: <ld_text> TYPE char100.

ld_text = 'DINAMIC'.
ld_varname = 'ld_text'.
"How to get a variable from another program
*ld_varname2 = '(ZFS_FIELDSIMBOLS)ld_text'.

ASSIGN ld_text TO   <ld_text>.
ASSIGN (ld_varname) TO <ld_text>.
ASSIGN ('ld_text')   TO <ld_text>.

BREAK-POINT.

FIELD-SYMBOLS: <fs_lt_scarr2>.
INSERT INITIAL LINE INTO TABLE lt_scarr2 ASSIGNING <fs_lt_scarr2>.

BREAK-POINT.

"Generic field simbol
FIELD-SYMBOLS: <fs_generic> TYPE ANY.

ASSIGN ld_text to <fs_generic>.

BREAK-POINT.
