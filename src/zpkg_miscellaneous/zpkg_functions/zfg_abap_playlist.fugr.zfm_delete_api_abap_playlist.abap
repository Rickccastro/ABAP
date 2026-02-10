FUNCTION zfm_delete_api_abap_playlist.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     REFERENCE(IV_PLANT) TYPE  BAPI_MARC-PLANT
*"     REFERENCE(IV_MATNR) TYPE  BAPIMATHEAD-MATERIAL
*"  EXCEPTIONS
*"      ERROR_SAVE_DATA
*"----------------------------------------------------------------------
  DATA: xheaddata   TYPE TABLE OF bapimathead WITH HEADER LINE,
        xplantdata  TYPE TABLE OF bapi_marc   WITH HEADER LINE,
        xplantdatax TYPE TABLE OF bapi_marcx  WITH HEADER LINE,
        xreturn  TYPE TABLE OF bapiret2.

  xplantdata-plant      = iv_plant. " set plant here
  xplantdata-del_flag   = 'X'.
  APPEND xplantdata.

  xplantdatax-plant      = iv_plant. " set plant here
  xplantdatax-del_flag   = 'X'.
  APPEND xplantdatax.

  REFRESH xheaddata.
  xheaddata-material      = IV_MATNR. " set material number here
  xheaddata-storage_view  = 'X'.
  xheaddata-inp_fld_check = 'W'.
  APPEND xheaddata.

  CALL FUNCTION 'BAPI_MATERIAL_SAVEDATA'
    EXPORTING
      headdata       = xheaddata
      plantdata      = xplantdata
      plantdatax     = xplantdatax
*      clientdata     = xclientdata
*      clientdatax    = xclientdatax
    TABLES
      returnmessages = xreturn.
  IF sy-subrc EQ 0.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait = 'X'.
    ELSE.
      RAISE error_save_data.
  ENDIF.




ENDFUNCTION.
