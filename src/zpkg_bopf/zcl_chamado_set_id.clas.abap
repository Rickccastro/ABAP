class ZCL_CHAMADO_SET_ID definition
  public
  inheriting from /BOBF/CL_LIB_D_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_DETERMINATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CHAMADO_SET_ID IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.
    CLEAR et_failed_key.
    CLEAR eo_message.

    DATA: lt_data  TYPE ztddchamados.
    DATA: ld_id    TYPE zsddchamados-chamadoid.

    io_read->retrieve(
      EXPORTING
        iv_node = is_ctx-node_key
        it_key  = it_key
      IMPORTING
        et_data = lt_data
    ).

    SELECT MAX( chamadoid )
      FROM zrickt_chamado
      INTO ld_id.

    ld_id = ld_id + 1.

    LOOP AT lt_data REFERENCE INTO DATA(lr_data) WHERE chamadoid = 0.
      lr_data->chamadoid = ld_id.

      TRY.
          CALL METHOD io_modify->update
            EXPORTING
              iv_node           = is_ctx-node_key
              iv_key            = lr_data->key
              is_data           = lr_data
              it_changed_fields = VALUE #( ( zif_dd_chamados_c=>sc_node_attribute-zdd_chamados-chamadoid ) ).
        CATCH /bobf/cx_frw.
      ENDTRY.

      ld_id = ld_id + 1.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
