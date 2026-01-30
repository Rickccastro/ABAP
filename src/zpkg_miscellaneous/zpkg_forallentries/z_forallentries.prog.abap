*&---------------------------------------------------------------------*
*& Report Z_FORALLENTRIES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_forallentries.

TYPES: BEGIN OF ly_type1,
         countryfr TYPE spfli-countryfr,
         cityfrom  TYPE spfli-cityfrom,
         airpfrom  TYPE spfli-airpfrom,
         name      TYPE sairport-name,
         countryto TYPE spfli-countryto,
         cityto    TYPE spfli-cityto,
         airpto    TYPE spfli-airpto,
       END OF ly_type1.
DATA: lt_result TYPE STANDARD TABLE OF ly_type1.
DATA: lt_airport TYPE HASHED TABLE OF sairport WITH UNIQUE KEY id.
DATA: ls_airport TYPE sairport.

FIELD-SYMBOLS: <ls_result> TYPE ly_type1.

START-OF-SELECTION.
  PERFORM for_all_entries.


FORM for_all_entries.
  BREAK-POINT.

  SELECT *
    INTO TABLE lt_airport FROM sairport WHERE time_zone = 'UTC+1'.

  IF lines( lt_airport ) > 0.
    SELECT * FROM spfli INTO CORRESPONDING FIELDS OF TABLE lt_result
     FOR ALL ENTRIES IN lt_airport
     WHERE spfli~airpfrom = lt_airport-id.
  ENDIF.

  LOOP AT lt_result ASSIGNING <ls_result>.
    READ TABLE lt_airport INTO ls_airport WITH TABLE KEY id = <ls_result>-airpfrom.
    IF sy-subrc = 0.
      <ls_result>-name = ls_airport-name.

    ENDIF.

  ENDLOOP.
ENDFORM.
