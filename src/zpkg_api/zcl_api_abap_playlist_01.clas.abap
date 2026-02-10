class ZCL_API_ABAP_PLAYLIST_01 definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_API_ABAP_PLAYLIST_01 IMPLEMENTATION.


  method IF_HTTP_EXTENSION~HANDLE_REQUEST.
    DATA(v_type_crud) = server->request->get_header_field( name = `~request_method` ).

    CASE v_type_crud.
      WHEN 'GET'.
        SELECT * FROM MARA INTO TABLE @DATA(lt_partner) UP TO 5 ROWS.

          DATA(ls_json_response) = /ui2/cl_json=>serialize( EXPORTING data = lt_partner ).

          server->response->set_cdata( data = ls_json_response ).
    ENDCASE.
  endmethod.
ENDCLASS.
