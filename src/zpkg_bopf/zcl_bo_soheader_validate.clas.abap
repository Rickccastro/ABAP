class ZCL_BO_SOHEADER_VALIDATE definition
  public
  inheriting from /BOBF/CL_LIB_V_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_VALIDATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_BO_SOHEADER_VALIDATE IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.
    CLEAR: eo_message, et_failed_key.
    DATA: lt_data   TYPE zbo_sales_order_header_ctt, ls_message TYPE symsg.

    io_read->retrieve(
      EXPORTING
        iv_node                 = is_ctx-node_key
        it_key                  = it_key
        iv_fill_data            = abap_true
        it_requested_attributes = VALUE #(
          ( zif_sales_order_c=>sc_node_attribute-root-customerid )
        )
      IMPORTING
        et_data                 = lt_data
    ).

    eo_message = /bobf/cl_frw_factory=>get_message( ).

    LOOP AT lt_data INTO DATA(ls_data).
      IF ls_data-customerid = 0.
        CLEAR ls_message.
        ls_message-msgid = 'ACM'.
        ls_message-msgno = 001.
        ls_message-msgty = 'E'.
        ls_message-msgv1 = 'Cliente vazio'.

        eo_message->add_message(
          EXPORTING
            is_msg       = ls_message
            iv_node      = is_ctx-node_key
            iv_key       = ls_data-key
            iv_attribute = zif_sales_order_c=>sc_node_attribute-root-customerid
        ).

        INSERT VALUE #( key = ls_data-key ) INTO TABLE et_failed_key.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
