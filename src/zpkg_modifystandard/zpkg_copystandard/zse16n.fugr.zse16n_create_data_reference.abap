FUNCTION ZSE16N_CREATE_DATA_REFERENCE.
*"--------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(I_TAB) TYPE  SE16N_TAB OPTIONAL
*"     VALUE(IT_FIELDCATALOG) TYPE  LVC_T_FCAT OPTIONAL
*"     VALUE(I_MESSAGE) TYPE  CHAR1 DEFAULT SPACE
*"     VALUE(I_STYLE_TABLE) TYPE  CHAR1 DEFAULT SPACE
*"  EXPORTING
*"     REFERENCE(E_DREF_TABLE) TYPE REF TO DATA
*"     REFERENCE(E_DREF_STRUCTURE) TYPE REF TO DATA
*"     REFERENCE(E_STYLE_FNAME) TYPE  LVC_FNAME
*"  EXCEPTIONS
*"      ERROR_IN_STRUCTURE_CREATION
*"      ERROR_IN_TABLE_CREATION
*"      ERROR_IN_ADDING_FIELD
*"--------------------------------------------------------------------

  DATA: descr    TYPE REF TO cl_abap_structdescr.
  DATA: descr_t  TYPE REF TO cl_abap_tabledescr.
  DATA: cols     TYPE cl_abap_structdescr=>component_table.
  DATA: col      LIKE LINE OF cols.
  DATA: dd_descr TYPE REF TO cl_abap_elemdescr.

  DATA: ld_table_field  TYPE string.
  DATA: xroot           TYPE REF TO cx_root.
  DATA: ls_dfies        TYPE dfies.
  DATA: ls_fieldcatalog TYPE lvc_s_fcat.

  CONSTANTS: c_alv_style_fname TYPE lvc_fname VALUE 'XYZSTYLEZYX'.

  TYPES: BEGIN OF ty_buffer,
           table    TYPE tabname,
           field    TYPE dfies-lfieldname,
           rollname TYPE rollname,
         END OF ty_buffer.
  STATICS: lt_buffer TYPE TABLE OF ty_buffer,
           ls_buffer TYPE ty_buffer.

*.If table is not given, do not take the whole components, but only
*.the ones provided in the field catalog
  IF i_tab IS INITIAL.
    LOOP AT it_fieldcatalog INTO ls_fieldcatalog.
*...check if data element is already in buffer
      READ TABLE lt_buffer INTO ls_buffer WITH KEY
                     table = ls_fieldcatalog-ref_table
                     field = ls_fieldcatalog-ref_field.
      IF sy-subrc = 0.
        ls_dfies-rollname = ls_buffer-rollname.
      ELSE.
*.....get data element of this field
        CONCATENATE ls_fieldcatalog-ref_table '-'
                     ls_fieldcatalog-ref_field
                     INTO ld_table_field.
        CONDENSE ld_table_field NO-GAPS.
        TRY.
            dd_descr ?= cl_abap_elemdescr=>describe_by_name( ld_table_field ).
            ls_dfies = dd_descr->get_ddic_field( ).
          CATCH cx_root INTO xroot.
            IF i_message = abap_true.
              MESSAGE xroot TYPE 'I'.
            ENDIF.
            CONTINUE.
        ENDTRY.

*.....fill into buffer
        IF ls_dfies-rollname <> space.
          CLEAR ls_buffer.
          ls_buffer-table    = ls_fieldcatalog-ref_table.
          ls_buffer-field    = ls_fieldcatalog-ref_field.
          ls_buffer-rollname = ls_dfies-rollname.
          APPEND ls_buffer TO lt_buffer.
        ENDIF.
      ENDIF.

*...add this field to the structure
      TRY.
          col-name = ls_fieldcatalog-fieldname.
          IF ls_dfies-rollname <> space.
            col-type ?= cl_abap_typedescr=>describe_by_name( ls_dfies-rollname ).
          ELSE.
            col-type ?= cl_abap_typedescr=>describe_by_name( ld_table_field ).
          ENDIF.
          APPEND col TO cols.
        CATCH cx_root INTO xroot.
          IF i_message = abap_true.
            MESSAGE xroot TYPE 'I'.
          ENDIF.
          RAISE error_in_adding_field.
      ENDTRY.

    ENDLOOP.
  ELSE.
*.get structure of ddic-tab
    descr ?= cl_abap_structdescr=>describe_by_name( i_tab ).
    cols = descr->get_components( ).

*.all fields that do not belong to the table itself must be created
*.additionally
    LOOP AT it_fieldcatalog INTO ls_fieldcatalog
                       WHERE ref_table <> i_tab
                          OR key       = 'A'.
*...check if data element is already in buffer
      READ TABLE lt_buffer INTO ls_buffer WITH KEY
                     table = ls_fieldcatalog-ref_table
                     field = ls_fieldcatalog-ref_field.
      IF sy-subrc = 0.
        ls_dfies-rollname = ls_buffer-rollname.
      ELSE.
*.....get data element of this field
        CONCATENATE ls_fieldcatalog-ref_table '-'
                     ls_fieldcatalog-ref_field
                     INTO ld_table_field.
        CONDENSE ld_table_field NO-GAPS.
        TRY.
            dd_descr ?= cl_abap_elemdescr=>describe_by_name( ld_table_field ).
            ls_dfies = dd_descr->get_ddic_field( ).
          CATCH cx_root INTO xroot.
            IF i_message = abap_true.
              MESSAGE xroot TYPE 'I'.
            ENDIF.
            CONTINUE.
        ENDTRY.

*.....fill into buffer
        IF ls_dfies-rollname <> space.
          CLEAR ls_buffer.
          ls_buffer-table    = ls_fieldcatalog-ref_table.
          ls_buffer-field    = ls_fieldcatalog-ref_field.
          ls_buffer-rollname = ls_dfies-rollname.
          APPEND ls_buffer TO lt_buffer.
        ENDIF.
      ENDIF.

*...add this field to the structure
      TRY.
          col-name = ls_fieldcatalog-fieldname.
          IF ls_dfies-rollname <> space.
            col-type ?= cl_abap_typedescr=>describe_by_name( ls_dfies-rollname ).
          ELSE.
            col-type ?= cl_abap_typedescr=>describe_by_name( ld_table_field ).
          ENDIF.
          APPEND col TO cols.
        CATCH cx_root INTO xroot.
          IF i_message = abap_true.
            MESSAGE xroot TYPE 'I'.
          ENDIF.
          RAISE error_in_adding_field.
      ENDTRY.

    ENDLOOP.
  ENDIF.

*.add ALV-Style-Table
  IF i_style_table = abap_true.
    TRY.
        col-name = c_alv_style_fname.
        col-type ?= cl_abap_typedescr=>describe_by_name( 'LVC_T_STYL' ).
        APPEND col TO cols.
      CATCH cx_root INTO xroot.
        IF i_message = abap_true.
          MESSAGE xroot TYPE 'I'.
        ENDIF.
        RAISE error_in_adding_field.
    ENDTRY.
    e_style_fname = c_alv_style_fname.
  ENDIF.

*.create generic structure out of the fields
  TRY.
      descr = cl_abap_structdescr=>get( p_components = cols p_strict = abap_false ).
      CREATE DATA e_dref_structure TYPE HANDLE descr.
    CATCH cx_root INTO xroot.
      IF i_message = abap_true.
        MESSAGE xroot TYPE 'I'.
      ENDIF.
      RAISE error_in_structure_creation.
  ENDTRY.

*.create generic table out of structure
  TRY.
      descr_t = cl_abap_tabledescr=>get( p_line_type = descr ).
      CREATE DATA e_dref_table TYPE HANDLE descr_t.
    CATCH cx_root INTO xroot.
      IF i_message = abap_true.
        MESSAGE xroot TYPE 'I'.
      ENDIF.
      RAISE error_in_table_creation.
  ENDTRY.

ENDFUNCTION.
