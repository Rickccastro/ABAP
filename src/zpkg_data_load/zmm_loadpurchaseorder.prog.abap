*&---------------------------------------------------------------------*
*& Report ZMM_LOADPURCHASEORDER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_loadpurchaseorder NO STANDARD PAGE HEADING.


TYPES: BEGIN OF xls_line,
         data(256) TYPE x,
       END OF xls_line.
DATA : lt_bin_data TYPE STANDARD TABLE OF xls_line,
       lv_file     TYPE string.


DATA: ls_header        TYPE bapimepoheader,
      ls_headerx       TYPE bapimepoheaderx,
      lt_item          TYPE STANDARD TABLE OF bapimepoitem,
      lt_itemx         TYPE STANDARD TABLE OF bapimepoitemx,
      ls_item          TYPE bapimepoitem,
      ls_account       TYPE bapimepoaccount,
      ls_schedule      TYPE bapimeposchedule,
      ls2_item         TYPE mepoitem,
      ls_itemx         TYPE bapimepoitemx,
      ls_schedulex     TYPE bapimeposchedulx,
      ls_accountx      TYPE bapimepoaccountx,
      lt_schedule      TYPE STANDARD TABLE OF bapimeposchedule,
      lt_schedulex     TYPE STANDARD TABLE OF bapimeposchedulx,
      lt_account       TYPE TABLE OF bapimepoaccount,
      lt_accountx      TYPE TABLE OF bapimepoaccountx,
      lt_return        TYPE STANDARD TABLE OF bapiret2,
      ls_return        TYPE bapiret2,
      lv_po_number     TYPE bapimepoheader-po_number,
      lt_return_commit TYPE bapiret2.
DATA: lv_file_length    TYPE i,
      lv_xstring_header TYPE xstring.

DATA: lv_unpacked_material(18) TYPE c,
      lv_packed_material(18)   TYPE c.
DATA:ls_data_formatada TYPE string8.

PARAMETERS:
p_file TYPE localfile OBLIGATORY.

INITIALIZATION.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.


  PERFORM search_help_file.

START-OF-SELECTION.

  PERFORM load_file.

  IF sy-subrc = 0.

    TRY.
        DATA(lo_excel) = NEW cl_fdt_xl_spreadsheet(
                       document_name = lv_file
                       xdocument     = lv_xstring_header ) .

        lo_excel->if_fdt_doc_spreadsheet~get_worksheet_names(
          IMPORTING
            worksheet_names = DATA(lt_worksheets) ).

        LOOP AT lt_worksheets INTO DATA(lv_woksheetname).
          FIELD-SYMBOLS: <fs_excel_data> TYPE any,
                         <lfs_data_tab>  TYPE ANY TABLE.

          DATA(lo_data_ref) = lo_excel->if_fdt_doc_spreadsheet~get_itab_from_worksheet(
                                 lv_woksheetname ).

          ASSIGN lo_data_ref->* TO <lfs_data_tab>.


          IF lv_woksheetname EQ 'Planilha1'.

            PERFORM load_header_data.

          ENDIF.
*
          IF lv_woksheetname EQ 'Planilha2'.

            PERFORM load_main_data.

          ENDIF.
        ENDLOOP.


        "       Executar BAPI
        CALL FUNCTION 'BAPI_PO_CREATE1'
          EXPORTING
            poheader    = ls_header
            poheaderx   = ls_headerx
          TABLES
            return      = lt_return
            poitem      = lt_item
            poitemx     = lt_itemx
            poschedule  = lt_schedule
            poschedulex = lt_schedulex
            poaccount   = lt_account
            poaccountx  = lt_accountx.

        cl_rmsl_message=>display( lt_return ).



        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
          EXPORTING
            wait   = '' " Using the command `COMMIT AND WAIT`
          IMPORTING
            return = lt_return_commit.   " Return Messages

      CATCH cx_fdt_excel_core.
        "Error handling
    ENDTRY.

  ENDIF.

FORM load_main_data.
  CLEAR <fs_excel_data>.

  "Tipagem dos valores genericos
  LOOP AT <lfs_data_tab> ASSIGNING FIELD-SYMBOL(<fs_main_data>).

    IF sy-tabix NE 1.
      "ITEM
      ASSIGN COMPONENT 'A' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-po_item    = <fs_excel_data>.
      ls_schedule-po_item    = <fs_excel_data>.
      ls_account-po_item = <fs_excel_data>.
      ls_itemx-po_item    = <fs_excel_data>.
      ls_schedulex-po_item = <fs_excel_data>.
      ls_accountx-po_item = <fs_excel_data>.
      "CTG_CLASSCONT
      ASSIGN COMPONENT 'B' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-acctasscat =  <fs_excel_data>.
      "MATERIAL
      ASSIGN COMPONENT 'C' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      lv_packed_material = <fs_excel_data>.
      UNPACK lv_packed_material TO lv_unpacked_material.
      ls_item-material   = lv_unpacked_material.
      "TEXTO BREVE
      ASSIGN COMPONENT 'D' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-short_text   = <fs_excel_data>.
      "Quantidade Pedido
      ASSIGN COMPONENT 'E' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-quantity   = <fs_excel_data>.
      ls_schedule-quantity = <fs_excel_data>.
      ls_account-quantity = <fs_excel_data>.
      "DATA_ENTREGA
      ASSIGN COMPONENT 'F' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.

      CONCATENATE  <fs_excel_data>+4 <fs_excel_data>+2(2)  <fs_excel_data>(2) INTO ls_data_formatada.
      ls_schedule-delivery_date  = ls_data_formatada.

      "GRP MERCADORIAS
      ASSIGN COMPONENT 'G' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-matl_group = <fs_excel_data>.
      "CENTRO
      ASSIGN COMPONENT 'H' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-plant      =  <fs_excel_data>.
      "DATA_ESTIMADA
      ASSIGN COMPONENT 'I' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.

      CONCATENATE  <fs_excel_data>+4 <fs_excel_data>+2(2)  <fs_excel_data>(2) INTO ls_data_formatada.
      ls_schedule-stat_date  =  ls_data_formatada.
      "TIPO_DATA
      ASSIGN COMPONENT 'J' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_schedule-del_datcat_ext  =  <fs_excel_data>.
      "IVA
      ASSIGN COMPONENT 'K' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-tax_code = <fs_excel_data>.
      "ORDEM
      ASSIGN COMPONENT 'L' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_item-acknowl_no = <fs_excel_data>.
      ls_account-orderid = <fs_excel_data>.
      "IMOBILIZADO
      ASSIGN COMPONENT 'M' OF STRUCTURE  <fs_main_data> TO <fs_excel_data>.
      ls_account-asset_no = <fs_excel_data>.


      "SCHEDULE0
      ls_schedule-sched_line = sy-tabix.
      ls_schedule-deliv_time  = '000000'.

      APPEND ls_item TO lt_item.
      APPEND ls_schedule TO lt_schedule.
      APPEND ls_account TO lt_account.


      ls_itemx-po_itemx = 'X'.
      ls_itemx-acctasscat   = 'X'.
      ls_itemx-material   = 'X'.
      ls_itemx-short_text   = 'X'.
      ls_itemx-quantity      = 'X'.
      ls_itemx-matl_group      = 'X'.
      ls_itemx-plant   = 'X'.
      ls_itemx-tax_code  = 'X'.
      ls_itemx-acknowl_no = 'X'.

      APPEND ls_itemx TO lt_itemx.


      ls_schedulex-po_itemx = 'X'.
      ls_schedulex-sched_line = sy-tabix.
      ls_schedulex-sched_linex = 'X'.
      ls_schedulex-delivery_date =  'X'.
      ls_schedulex-stat_date  = 'X'.
      ls_schedulex-quantity  = 'X'.
      ls_schedulex-deliv_time  = 'X'.
      ls_schedulex-del_datcat_ext  = 'X'.


      APPEND ls_schedulex TO lt_schedulex.

      ls_accountx-po_itemx = 'X'.
      ls_accountx-quantity = 'X'.
      ls_accountx-asset_no = 'X'.
      ls_accountx-orderid = 'X'.

      APPEND ls_accountx TO lt_accountx.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM load_header_data.

  LOOP AT <lfs_data_tab> ASSIGNING FIELD-SYMBOL(<fs_header_data>).
    " INSERÇÃO DOS VALORES DO HEADER
    IF sy-tabix EQ 2.
      ASSIGN COMPONENT 'A' OF STRUCTURE <fs_header_data> TO <fs_excel_data>.
      "FORNECEDOR"
      ls_header-vendor = <fs_excel_data>.
      ASSIGN COMPONENT 'B' OF STRUCTURE <fs_header_data> TO <fs_excel_data>.
      "TIPO PEDIDO"
      ls_header-doc_type = <fs_excel_data>.
      ASSIGN COMPONENT 'C' OF STRUCTURE <fs_header_data> TO <fs_excel_data>.

      CONCATENATE  <fs_excel_data>+4 <fs_excel_data>+2(2)  <fs_excel_data>(2) INTO ls_data_formatada.

      "DATA PEDIDO"
      ls_header-creat_date  = ls_data_formatada.
      ASSIGN COMPONENT 'D' OF STRUCTURE  <fs_header_data> TO <fs_excel_data>.
      "ORGANIZAÇÃO DE COMPRAS"
      ls_header-purch_org   = <fs_excel_data>.
      ASSIGN COMPONENT 'E' OF STRUCTURE  <fs_header_data> TO <fs_excel_data>.
      "GRUPO DE COMPRADORES"
      ls_header-pur_group   = <fs_excel_data>.
      ASSIGN COMPONENT 'F' OF STRUCTURE  <fs_header_data> TO <fs_excel_data>.
      "EMPRESA"
      ls_header-comp_code   = <fs_excel_data>.
      ASSIGN COMPONENT 'G' OF STRUCTURE  <fs_header_data> TO <fs_excel_data>.
      "MOEDA"
      ls_header-currency    = <fs_excel_data>.
      ASSIGN COMPONENT 'H' OF STRUCTURE  <fs_header_data> TO <fs_excel_data>.
      "INCOTERMS 1"
      ls_header-incoterms1  = <fs_excel_data>.
      ASSIGN COMPONENT 'I' OF STRUCTURE  <fs_header_data> TO <fs_excel_data>.
      "INCOTERMS 2"
      ls_header-incoterms2  = <fs_excel_data>.

      ls_headerx-vendor    = 'X'.
      ls_headerx-doc_type  = 'X'.
      ls_headerx-creat_date = 'X'.
      ls_headerx-purch_org = 'X'.
      ls_headerx-pur_group = 'X'.
      ls_headerx-comp_code = 'X'.
      ls_headerx-currency  = 'X'.
      ls_headerx-incoterms1  = 'X'.
      ls_headerx-incoterms2  = 'X'.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM load_file.
  lv_file = p_file.

  cl_gui_frontend_services=>gui_upload(
  EXPORTING
  filename = lv_file
  filetype = 'BIN'
  IMPORTING
  filelength = lv_file_length
  header = lv_xstring_header
  CHANGING
  data_tab = lt_bin_data
  EXCEPTIONS
  OTHERS = 99 ).

  CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
    EXPORTING
      input_length = lv_file_length
    IMPORTING
      buffer       = lv_xstring_header
    TABLES
      binary_tab   = lt_bin_data
    EXCEPTIONS
      failed       = 1
      OTHERS       = 2.

ENDFORM.


FORM search_help_file .
  DATA:
    l_desktop  TYPE string,
    l_i_files  TYPE filetable,
    l_wa_files TYPE file_table,
    l_rcode    TYPE int4.

  CALL METHOD cl_gui_frontend_services=>get_desktop_directory
    CHANGING
      desktop_directory    = l_desktop
    EXCEPTIONS
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
      OTHERS               = 4.
  IF sy-subrc <> 0.
    MESSAGE e001(00) WITH
    'Desktop not found'.
  ENDIF.


  CALL METHOD cl_gui_cfw=>update_view
    EXCEPTIONS
      cntl_system_error = 1
      cntl_error        = 2
      OTHERS            = 3.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title            = 'Select Excel file'
      default_extension       = '.xlsx'
      file_filter             = '.xlsx'
      initial_directory       = l_desktop
    CHANGING
      file_table              = l_i_files
      rc                      = l_rcode
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.
  IF sy-subrc <> 0.
    MESSAGE e001(00) WITH 'Error while opening file'.
  ENDIF.

  READ TABLE l_i_files INDEX 1 INTO l_wa_files.
  IF sy-subrc = 0.
    p_file = l_wa_files-filename.
  ELSE.
    MESSAGE e001(00) WITH 'Error while opening file'.
  ENDIF.

ENDFORM. " SUB_FILE_
