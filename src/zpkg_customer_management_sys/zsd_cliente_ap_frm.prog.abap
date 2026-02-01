FORM inserir.

  gs_cliente-erdat = sy-datum.
  gs_cliente-erzet = sy-uzeit.

  INSERT zsd_cliente_ap FROM gs_cliente.

  IF sy-subrc = 0.
    MESSAGE 'Cliente inserido com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'ERRO ao inseir cliente' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

FORM modificar.

  gs_cliente-erdat = sy-datum.
  gs_cliente-erzet = sy-uzeit.

  MODIFY zsd_cliente_ap FROM gs_cliente.

  IF sy-subrc = 0.
    MESSAGE 'Cliente atualizar com sucesso' TYPE 'S'.
  ELSE.
    MESSAGE 'ERRO ao atualizar cliente' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

FORM modificar_cliente.

  SELECT SINGLE * FROM zsd_cliente_ap INTO gs_cliente WHERE zclinr = gd_zclinr.

  IF sy-subrc NE 0.
    MESSAGE |O cliente { gd_zclinr } não existe| TYPE 'S'.
    EXIT.
  ENDIF.

  CALL SCREEN 9000.

ENDFORM.
