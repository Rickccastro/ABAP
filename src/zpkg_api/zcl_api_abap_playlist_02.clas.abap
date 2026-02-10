class ZCL_API_ABAP_PLAYLIST_02 definition
  public
  inheriting from CL_REST_HTTP_HANDLER
  final
  create public .

public section.

  methods IF_REST_APPLICATION~GET_ROOT_HANDLER
    redefinition .
protected section.

  methods HANDLE_CSRF_TOKEN
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_API_ABAP_PLAYLIST_02 IMPLEMENTATION.


  method HANDLE_CSRF_TOKEN.

  endmethod.


  METHOD IF_REST_APPLICATION~GET_ROOT_HANDLER.

    DATA(lo_router) = NEW cl_rest_router( ).

    SELECT * FROM ZTAP_ROUTES_01 INTO TABLE @DATA(lt_rotas).


    LOOP AT lt_rotas REFERENCE INTO DATA(lrf_rota).

      lo_router->attach(
        iv_template = |{ lrf_rota->rota }|
        iv_handler_class = lrf_rota->classe
      ).

    ENDLOOP.

    ro_root_handler = lo_router.


  ENDMETHOD.
ENDCLASS.
