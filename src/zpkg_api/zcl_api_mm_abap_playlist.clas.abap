class ZCL_API_MM_ABAP_PLAYLIST definition
  public
  inheriting from CL_REST_RESOURCE
  final
  create public .

public section.

  methods GET_MATERIALS .
  methods GET_MATERIAL .
  methods POST_MATERIAL .
  methods PUT_MATERIAL .
  methods DELETE_MATERIAL .

  methods IF_REST_RESOURCE~DELETE
    redefinition .
  methods IF_REST_RESOURCE~GET
    redefinition .
  methods IF_REST_RESOURCE~POST
    redefinition .
  methods IF_REST_RESOURCE~PUT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_API_MM_ABAP_PLAYLIST IMPLEMENTATION.


  METHOD delete_material.

    DATA(lo_entity) = mo_response->create_entity( ).
    lo_entity->set_content_type( 'application/json; charset-UTF-8').
    DATA(lt_parameters) = mo_request->get_uri_query_parameters( ).

    DATA(ls_plant) = VALUE #( lt_parameters[ name = 'plant' ] OPTIONAL ).
    DATA(ls_matnr) = VALUE #( lt_parameters[ name = 'matnr' ] OPTIONAL ).

CALL FUNCTION 'ZFM_DELETE_API_ABAP_PLAYLIST'
  EXPORTING
    iv_plant       = CONV BAPI_MARC-PLANT( ls_plant-value )
    iv_matnr       = CONV BAPIMATHEAD-MATERIAL( |{ ls_matnr-value ALPHA = IN }| ).
          .

    IF sy-subrc EQ 0 .
      DATA(ls_json_response_table) = /ui2/cl_json=>serialize( `{ "msg": "Sucesso ao apagar o registro"}` ).
      lo_entity->set_string_data( ls_json_response_table ).
    ELSE.
      lo_entity->set_string_data( `ERRO` ).

    ENDIF.

  ENDMETHOD.


  METHOD GET_MATERIAL.

  DATA(lt_parameters) = mo_request->get_uri_query_parameters( ).

    DATA(lv_filter_id) = VALUE #( lt_parameters[ name = 'id' ] OPTIONAL ).

    " obs crie um range com o valor do id e nao precise tratar quando for initial se não 2x selects...
    IF lv_filter_id IS NOT INITIAL.
      DATA(lv_id) = CONV matnr( lv_filter_id-value ).
      lv_id = |{ lv_id ALPHA = IN }|.
      DATA(lr_ids) = VALUE rseloption(
        ( sign = 'I' option = 'EQ' low = lv_id ) ).
    ENDIF.

   SELECT *  FROM MARA INTO TABLE @DATA(lt_mara) WHERE matnr IN @lr_ids.

    DATA(lo_entity) = mo_response->create_entity( ).

    lo_entity->set_content_type( 'application/json; charset-UTF-8').

    IF lines( lt_mara ) EQ 1.
      DATA(ls_mat) = lt_mara[ 1 ].

      DATA(ls_json_response_line) = /ui2/cl_json=>serialize( data = ls_mat ).
      lo_entity->set_string_data( ls_json_response_line ).

    ELSE.
      DATA(ls_json_response_table) = /ui2/cl_json=>serialize( data = ls_mat ).
      lo_entity->set_string_data( ls_json_response_table ).

    ENDIF.

  ENDMETHOD.


  METHOD GET_MATERIALS.
    SELECT *  FROM MARA INTO TABLE @DATA(lt_mara) UP TO 5 ROWS.

    DATA(lo_entity) = mo_response->create_entity( ).

    lo_entity->set_content_type( 'application/json; charset-UTF-8').

    DATA(ls_json_response_table) = /ui2/cl_json=>serialize( data = lt_mara ).
    lo_entity->set_string_data( ls_json_response_table ).
  ENDMETHOD.


  METHOD if_rest_resource~delete.
    " Rota ATUAL
    DATA(lv_route) = mo_request->get_uri_path( ).

    REPLACE ALL OCCURRENCES OF SUBSTRING '/mat/' IN lv_route WITH ''.

    TRANSLATE lv_route TO UPPER CASE.

    IF lv_route NS 'DELETE'.
      DATA(lo_entity) = mo_response->create_entity( ).
      lo_entity->set_string_data( '{"msg": "Rota Necessita ser DELETE!" }').
      lo_entity->set_content_type( 'application/json; charset-UTF-8').
      RETURN.
    ENDIF.

    CALL METHOD (lv_route).
  ENDMETHOD.


  METHOD IF_REST_RESOURCE~GET.

    " Rota ATUAL
    DATA(lv_route) = mo_request->get_uri_path( ).

    REPLACE ALL OCCURRENCES OF SUBSTRING '/mat/' IN lv_route WITH ''.

    TRANSLATE lv_route TO UPPER CASE.

    IF lv_route NS 'GET'.
      DATA(lo_entity) = mo_response->create_entity( ).
      lo_entity->set_string_data( '{"msg": "Rota Necessita ser GET!" }').
      lo_entity->set_content_type( 'application/json; charset-UTF-8').
      RETURN.
    ENDIF.

    CALL METHOD (lv_route).


  ENDMETHOD.


  METHOD if_rest_resource~post.
    " Rota ATUAL
    DATA(lv_route) = mo_request->get_uri_path( ).

    REPLACE ALL OCCURRENCES OF SUBSTRING '/mat/' IN lv_route WITH ''.

    TRANSLATE lv_route TO UPPER CASE.

    IF lv_route NS 'POST'.
      DATA(lo_entity) = mo_response->create_entity( ).
      lo_entity->set_string_data( '{"msg": "Rota Necessita ser POST!" }').
      lo_entity->set_content_type( 'application/json; charset-UTF-8').
      RETURN.

    ENDIF.

    CALL METHOD (lv_route).
  ENDMETHOD.


  METHOD if_rest_resource~put.
    DATA(lv_route) = mo_request->get_uri_path( ).

    REPLACE ALL OCCURRENCES OF SUBSTRING '/mat/' IN lv_route WITH ''.

    TRANSLATE lv_route TO UPPER CASE.

    IF lv_route NS 'PUT'.
      DATA(lo_entity) = mo_response->create_entity( ).
      lo_entity->set_string_data( '{"msg": "Rota Necessita ser PUT!" }').
      lo_entity->set_content_type( 'application/json; charset-UTF-8').

      RETURN.
    ENDIF.

    CALL METHOD (lv_route).
  ENDMETHOD.


  METHOD post_material.
    DATA: ls_request TYPE MARA.

    DATA(lt_request_body) = mo_request->get_entity( )->get_string_data( ).
    /ui2/cl_json=>deserialize( EXPORTING json = lt_request_body
                               CHANGING data  = ls_request ).
    DATA(lo_entity) = mo_response->create_entity( ).
    lo_entity->set_content_type( 'application/json; charset-UTF-8').


    CALL FUNCTION 'ZFM_POST_API_ABAP_PLAYLIST'
      EXPORTING
        mat_type       = 'ROH'
        mat_ind_sector = 'P'
        matl_desc      = 'NEW DESCRIPTION'
        base_uom       = 'L'
        matl_group     = 'A001'
      IMPORTING
        es_mat =  ls_request
        .

    IF sy-subrc EQ 0 .
      DATA(ls_json_response_table) = /ui2/cl_json=>serialize( data = ls_request ).
      lo_entity->set_string_data( ls_json_response_table ).
    ELSE.
      lo_entity->set_string_data( `ERRO` ).

    ENDIF.

  ENDMETHOD.


  METHOD PUT_MATERIAL.
    DATA: ls_request TYPE ZRH_TB_EMPREGADO.

    DATA(lt_parameters) = mo_request->get_uri_query_parameters( ).

    DATA(ls_func) = VALUE #( lt_parameters[ name = 'id' ] OPTIONAL ).

    DATA(lo_entity) = mo_response->create_entity( ).
    lo_entity->set_content_type( 'application/json; charset-UTF-8').


    DATA(ls_request_body) = mo_request->get_entity( )->get_string_data( ).
    /ui2/cl_json=>deserialize( EXPORTING json = ls_request_body
                               CHANGING data  = ls_request ).

    ls_request-id    = ls_func-value.

    UPDATE ZRH_TB_EMPREGADO FROM ls_request.

    IF sy-subrc EQ 0 .
      DATA(ls_json_response_table) = /ui2/cl_json=>serialize( data = ls_request-id ).
      lo_entity->set_string_data( ls_json_response_table ).
    ELSE.
      lo_entity->set_string_data( `ERRO` ).

    ENDIF.
  ENDMETHOD.
ENDCLASS.
