FUNCTION zfm_post_api_abap_playlist.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     REFERENCE(MAT_TYPE) TYPE  BAPIMATDOA-MATL_TYPE
*"     REFERENCE(MAT_IND_SECTOR) TYPE  BAPIMATDOA-IND_SECTOR
*"     REFERENCE(MATL_DESC) TYPE  BAPI_MAKT-MATL_DESC
*"     REFERENCE(BASE_UOM) TYPE  BAPI_MARA-BASE_UOM
*"     REFERENCE(MATL_GROUP) TYPE  BAPI_MARA-MATL_GROUP
*"  EXPORTING
*"     REFERENCE(ES_MAT) TYPE  MARA
*"----------------------------------------------------------------------

*  DATA: mat_type       LIKE bapimatdoa-matl_type, mat_ind_sector TYPE bapimatdoa-ind_sector.

  DATA: lt_mat_number  TYPE TABLE OF bapimatinr WITH HEADER LINE.

  DATA: lt_bapimathead     LIKE bapimathead.

  DATA: descdata TYPE TABLE OF bapi_makt WITH HEADER LINE.

  DATA: ls_clientdata  TYPE bapi_mara, ls_clientdatax TYPE bapi_marax.

  DATA: lt_return          TYPE  TABLE OF  bapireturn1,lt_return_savedata TYPE TABLE OF bapiret2, lt_return_commit TYPE TABLE OF bapiret2.


*  mat_type = 'ROH'.
*  mat_ind_sector = 'P'.

  CALL FUNCTION 'BAPI_MATERIAL_GETINTNUMBER'
    EXPORTING
      material_type   = mat_type
      industry_sector = mat_ind_sector
*     REQUIRED_NUMBERS       = 1
    IMPORTING
      return          = lt_return
    TABLES
      material_number = lt_mat_number.


  lt_bapimathead-material = lt_mat_number-material.
  lt_bapimathead-material_long = lt_mat_number-material_long.
  lt_bapimathead-matl_type = mat_type.
  lt_bapimathead-ind_sector = mat_ind_sector.

  descdata-langu = sy-langu.
*  descdata-matl_desc = 'New Description'.
  descdata-matl_desc = matl_desc.
  APPEND descdata.

*  ls_clientdata-base_uom = 'L'.
  ls_clientdata-base_uom = base_uom.
*  ls_clientdata-matl_group = 'A001'.
  ls_clientdata-matl_group = matl_group.
  ls_clientdatax-base_uom = 'X'.
  ls_clientdatax-matl_group = 'X'.


  CALL FUNCTION 'BAPI_MATERIAL_SAVEDATA'
    EXPORTING
      headdata            = lt_bapimathead
      clientdata          = ls_clientdata
      clientdatax         = ls_clientdatax
*     PLANTDATA           =
*     PLANTDATAX          =
*     FORECASTPARAMETERS  =
*     FORECASTPARAMETERSX =
*     PLANNINGDATA        =
*     PLANNINGDATAX       =
*     STORAGELOCATIONDATA =
*     STORAGELOCATIONDATAX        =
*     VALUATIONDATA       =
*     VALUATIONDATAX      =
*     WAREHOUSENUMBERDATA =
*     WAREHOUSENUMBERDATAX        =
*     SALESDATA           =
*     SALESDATAX          =
*     STORAGETYPEDATA     =
*     STORAGETYPEDATAX    =
*     FLAG_ONLINE         = ' '
*     FLAG_CAD_CALL       = ' '
*     NO_DEQUEUE          = ' '
*     NO_ROLLBACK_WORK    = ' '
*     CLIENTDATACWM       =
*     CLIENTDATACWMX      =
*     VALUATIONDATACWM    =
*     VALUATIONDATACWMX   =
*     MATPLSTADATA        =
*     MATPLSTADATAX       =
*     MARC_APS_EXTDATA    =
*     MARC_APS_EXTDATAX   =
    IMPORTING
      return              = lt_return_savedata
    TABLES
      materialdescription = descdata.
*   UNITSOFMEASURE      =
*   UNITSOFMEASUREX     =
*   INTERNATIONALARTNOS =
*   MATERIALLONGTEXT    =
*   TAXCLASSIFICATIONS  =
*   RETURNMESSAGES      =
*   PRTDATA             =
*   PRTDATAX            =
*   EXTENSIONIN         =
*   EXTENSIONINX        =
*   UNITSOFMEASURECWM   =
*   UNITSOFMEASURECWMX  =
*   SEGMRPGENERALDATA   =
*   SEGMRPGENERALDATAX  =
*   SEGMRPQUANTITYDATA  =
*   SEGMRPQUANTITYDATAX =
*   SEGVALUATIONTYPE    =
*   SEGVALUATIONTYPEX   =
*   SEGSALESSTATUS      =
*   SEGSALESSTATUSX     =
*   SEGWEIGHTVOLUME     =
*   SEGWEIGHTVOLUMEX    =
*   DEMAND_PENALTYDATA  =
*   DEMAND_PENALTYDATAX =
*   NFMCHARGEWEIGHTS    =
*   NFMCHARGEWEIGHTSX   =
*   NFMSTRUCTURALWEIGHTS        =
*   NFMSTRUCTURALWEIGHTSX       =
*  .
*
  ES_MAT-MATNR = lt_mat_number-material.
  ES_MAT-MBRSH = mat_ind_sector.
  ES_MAT-MATKL = matl_group.

  IF sy-subrc EQ 0.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait   = 'X'
      IMPORTING
        return = lt_return_commit.

  ENDIF.

ENDFUNCTION.
