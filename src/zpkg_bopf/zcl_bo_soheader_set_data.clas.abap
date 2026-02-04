class ZCL_BO_SOHEADER_SET_DATA definition
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



CLASS ZCL_BO_SOHEADER_SET_DATA IMPLEMENTATION.


  method /BOBF/IF_FRW_DETERMINATION~EXECUTE.
    CLEAR: et_failed_key, eo_message.
    DATA: lt_data TYPE ZBO_SALES_ORDER_HEADER_CTT,
          ld_id TYPE ZBO_SALES_ORDER-soid.

    io_read->retrieve(

      EXPORTING
        iv_node = is_ctx-node_key
        it_key = it_key
       IMPORTING
         et_data = lt_data
    ).

   SELECT MAX( soid ) FROM zbo_sales_order INTO ld_id.

    ld_id = ld_id + 1.

     LOOP AT lt_data REFERENCE INTO DATA(lr_data) WHERE soid = 0.

       lr_data->soid = ld_id.
       lr_data->erdat = sy-datum.
       lr_data->erzet = sy-uzeit.
       lr_data->status = '1'.

       TRY.
          call METHOD io_modify->update
           EXPORTING
              iv_node = is_ctx-node_key
              iv_key = lr_data->key
              is_data = lr_data
              it_changed_fields = VALUE #(
              ( ZIF_SALES_ORDER_C=>sc_node_attribute-root-soid )
              ( ZIF_SALES_ORDER_C=>sc_node_attribute-root-erdat )
              ( ZIF_SALES_ORDER_C=>sc_node_attribute-root-erzet )
              ( ZIF_SALES_ORDER_C=>sc_node_attribute-root-status )
              ).
       CATCH /bobf/cx_frw.
       ENDTRY.

       ld_id = ld_id + 1.

     ENDLOOP.

  endmethod.
ENDCLASS.
