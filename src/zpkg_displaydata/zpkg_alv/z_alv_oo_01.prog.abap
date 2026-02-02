*&---------------------------------------------------------------------*
*& Report Z_ALV_OO_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ALV_OO_01.

* Programas exemplos do BCALV_GRID_01 até BCALV_GRID_11

  DATA: lo_table     TYPE REF TO cl_salv_table.
  DATA: lo_columns   TYPE REF TO cl_salv_columns_table.
  DATA: lo_column    TYPE REF TO cl_salv_column.
  DATA: lo_functions TYPE REF TO cl_salv_functions_list.
  DATA: lo_display   TYPE REF TO cl_salv_display_settings.

  DATA lo_layout_settings TYPE REF TO cl_salv_layout.
  DATA ls_layout_key      TYPE salv_s_layout_key.

  DATA: lt_result TYPE STANDARD TABLE OF stravelag.

  SELECT *
    INTO TABLE lt_result
    FROM stravelag.

  cl_salv_table=>factory(
    IMPORTING
      r_salv_table = lo_table
    CHANGING
      t_table = lt_result
  ).

  " otimizando largura das colunas
  lo_columns = lo_table->get_columns( ).
  lo_columns->set_optimize( ).

  " exibindo barra de ferramentas (barra de botões acima do ALV)
  lo_functions = lo_table->get_functions( ).
  lo_functions->set_all( ).

  " efeito zebra (alternar cor de fundo das linhas)
  lo_display = lo_table->get_display_settings( ).
  lo_display->set_striped_pattern( cl_salv_display_settings=>true ).

  " habilitar opções de layout (salvar, carregar etc)
  lo_layout_settings = lo_table->get_layout( ).
  ls_layout_key-report = sy-repid.
  lo_layout_settings->set_key( ls_layout_key ).
  lo_layout_settings->set_save_restriction( if_salv_c_layout=>restrict_none ).

  " alterando propriedades de uma coluna (nome, alinhamento etc.)
  lo_column = lo_columns->get_column( 'NAME' ).
  lo_column->set_long_text( 'NAME' ).
  lo_column->set_alignment( IF_SALV_C_ALIGNMENT=>CENTERED ).
  "lo_column->set_visible( if_salv_c_bool_sap=>false ).

  lo_table->display( ).
