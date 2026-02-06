*&---------------------------------------------------------------------*
*& Report ZMM_GET_DETAIL_PO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_get_detail_po.

"BAPI_PO_GETDETAIL1
"GET PO from ME23N

DATA: lt_return TYPE TABLE OF bapiret2.
DATA: lt_items TYPE TABLE OF bapimepoitem.
TABLES: ekko.
SELECTION-SCREEN BEGIN OF BLOCK b1.
  PARAMETERS: po_num  TYPE ekko-ebeln.
SELECTION-SCREEN END OF BLOCK b1.


BREAK-POINT.

  CALL FUNCTION 'BAPI_PO_GETDETAIL1'
    EXPORTING
      purchaseorder = po_num
*     ACCOUNT_ASSIGNMENT       = ' '
*     ITEM_TEXT     = ' '
*     HEADER_TEXT   = ' '
*     DELIVERY_ADDRESS         = ' '
*     VERSION       = ' '
*     SERVICES      = ' '
*     SERIALNUMBERS = ' '
*     INVOICEPLAN   = ' '
*                    IMPORTING
*     POHEADER      =
*     POEXPIMPHEADER           =
*
    TABLES
      return        = lt_return
      poitem        = lt_items
*     POADDRDELIVERY           =
*     POSCHEDULE    =
*     POACCOUNT     =
*     POCONDHEADER  =
*     POCOND        =
*     POLIMITS      =
*     POCONTRACTLIMITS         =
*     POSERVICES    =
*     POSRVACCESSVALUES        =
*     POTEXTHEADER  =
*     POTEXTITEM    =
*     POEXPIMPITEM  =
*     POCOMPONENTS  =
*     POSHIPPINGEXP =
*     POHISTORY     =
*     POHISTORY_TOTALS         =
*     POCONFIRMATION           =
*     ALLVERSIONS   =
*     POPARTNER     =
*     EXTENSIONOUT  =
*     SERIALNUMBER  =
*     INVPLANHEADER =
*     INVPLANITEM   =
*     POHISTORY_MA  =
    .
  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
    EXPORTING
      wait = 'X'
*             IMPORTING
*     RETURN        =
    .

 BREAK-POINT.
