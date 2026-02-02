*&---------------------------------------------------------------------*
*& Report Z_LOCALCLASS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_localclass.


CLASS lcl_cliente DEFINITION.
  PUBLIC SECTION.
    METHODS: set_cpf IMPORTING id_cpf TYPE char11,
      get_cpf RETURNING VALUE(rd_cpf) TYPE char11,
      get_cpf_formatado  RETURNING VALUE(rd_cpf) TYPE char14,
      set_nome IMPORTING id_nome TYPE string,
      get_nome RETURNING VALUE(rd_nome) TYPE string.

  PRIVATE SECTION.
    DATA md_cpf  TYPE char11.
    DATA md_nome TYPE string.
ENDCLASS.

CLASS lcl_cliente IMPLEMENTATION.
  METHOD set_cpf.

    IF strlen( id_cpf ) NE 11.
      RETURN.
    ENDIF.

    me->md_cpf = id_cpf.
  ENDMETHOD.

  METHOD get_cpf.
    rd_cpf = md_cpf.
  ENDMETHOD.

  METHOD get_cpf_formatado.
    CONCATENATE md_cpf+0(3) '.' md_cpf+3(3) '.' md_cpf+6(3) '-' md_cpf+9(2) INTO rd_cpf.
  ENDMETHOD.

  METHOD set_nome.
    me->md_nome = id_nome.
  ENDMETHOD.

  METHOD get_nome.
    rd_nome = md_nome.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_pedido DEFINITION.
  PUBLIC SECTION.
    METHODS: set_cliente IMPORTING io_cliente TYPE REF TO lcl_cliente,
      get_cliente RETURNING VALUE(ro_cliente) TYPE REF TO lcl_cliente.

  PRIVATE SECTION.
    DATA mo_cliente TYPE REF TO lcl_cliente.
ENDCLASS.

CLASS lcl_pedido IMPLEMENTATION.
  METHOD set_cliente.
    mo_cliente = io_cliente.
  ENDMETHOD.

  METHOD get_cliente.
    ro_cliente = mo_cliente.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA lo_cliente1 TYPE REF TO lcl_cliente.
  DATA lo_pedido TYPE REF TO lcl_pedido.

  lo_cliente1 = NEW lcl_cliente( ).
  lo_pedido = NEW lcl_pedido( ).

  lo_cliente1->set_cpf( id_cpf = '12345678910' ).

  lo_pedido->set_cliente( io_cliente = lo_cliente1 ).
*  WRITE lo_cliente1->get_cpf( ).
