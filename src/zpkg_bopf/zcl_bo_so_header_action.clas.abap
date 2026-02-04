class ZCL_BO_SO_HEADER_ACTION definition
  public
  inheriting from /BOBF/CL_LIB_A_SUPERCLASS
  final
  create public .

public section.

  methods /BOBF/IF_FRW_ACTION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_BO_SO_HEADER_ACTION IMPLEMENTATION.


  method /BOBF/IF_FRW_ACTION~EXECUTE.
  DATA: lt_req_attribute TYPE /bobf/t_frw_name, lt_soheader_root TYPE ZBO_SALES_ORDER_HEADER_CTT.

  CLEAR: et_failed_key, eo_message, et_data, ev_static_action_failed.

  INSERT ZIF_SALES_ORDER_C=>sc_node_attribute-root-status
    INTO TABLE lt_req_attribute.

  io_read->retrieve(
    EXPORTING
      iv_node = ZIF_SALES_ORDER_C=>sc_node-root
      it_key = it_key
      iv_fill_data = abap_true
      it_requested_attributes = lt_req_attribute
    IMPORTING
      et_data = lt_soheader_root
  ).

  eo_message = /bobf/cl_frw_factory=>get_message( ).

  LOOP AT lt_soheader_root REFERENCE INTO DATA(lr_soheader_root).
    CASE is_ctx-act_key.
      WHEN ZIF_SALES_ORDER_C=>sc_action-root-provide.
        IF lr_soheader_root->status <> '1'.
          eo_message->add_message(
            EXPORTING
              is_msg       = value #(
                msgid = 'ACM'
                msgno = '001'
                msgv1 = 'Status deve ser 1 (Novo)'
              )
              iv_node      = is_ctx-node_key
              iv_key       = lr_soheader_root->key
              iv_attribute = ZIF_SALES_ORDER_C=>sc_node_attribute-root-status
          ).
          RETURN.
        ENDIF.
        lr_soheader_root->status = '2'.
      WHEN ZIF_SALES_ORDER_C=>sc_action-root-invoice.
        IF lr_soheader_root->status NE '2'.
          eo_message->add_message(
            EXPORTING
              is_msg       = value #(
                msgid = 'ACM'
                msgno = '001'
                msgv1 = 'Status deve ser 2 (FORNECIDO)'
              )
              iv_node      = is_ctx-node_key
              iv_key       = lr_soheader_root->key
              iv_attribute = ZIF_SALES_ORDER_C=>sc_node_attribute-root-status
          ).
          RETURN.
        ENDIF.
        lr_soheader_root->status = '3'.
    ENDCASE.

    io_modify->update(
      iv_node = is_ctx-node_key
      iv_key  = lr_soheader_root->key
      is_data = lr_soheader_root
      it_changed_fields = lt_req_attribute
  ).
  ENDLOOP.
  endmethod.
ENDCLASS.
