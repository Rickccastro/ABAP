class ZCL_CUSTOMER_ABAP_PLAYLIST definition
  public
  final
  create public .

public section.

  types:
    MY_USR01_T type STANDARD TABLE OF USR01 .
  types:
    BEGIN OF my_usr01_s,
         ID TYPE int4,
         NAME TYPE STRING,
         END OF MY_USR01_S .

  class-data MD_CPF_STATICO type CHAR11 .

  methods DESTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !ID_CPF type CHAR11 optional
      !ID_NAME type STRING optional .
  methods SET_CPF
    importing
      value(ID_CPF) type CHAR11 .
  methods GET_CPF
    returning
      value(RD_CPF) type CHAR11 .
  methods SET_NAME
    importing
      !ID_NAME type STRING .
  methods GET_NAME
    returning
      value(RD_NAME) type STRING .
protected section.
private section.

  data MD_CPF type CHAR11 .
  data MD_NAME type STRING .
ENDCLASS.



CLASS ZCL_CUSTOMER_ABAP_PLAYLIST IMPLEMENTATION.


  method GET_CPF.
    rd_cpf  = md_cpf.
  endmethod.


  method GET_NAME.
     rd_name = md_name.
  endmethod.


  method SET_CPF.
      md_cpf = id_cpf.
  endmethod.


  method SET_NAME.
    md_name = id_name.
  endmethod.


  method CLASS_CONSTRUCTOR.
     BREAK-POINT.
  endmethod.


  method CONSTRUCTOR.
    me->set_cpf( id_cpf  =  id_cpf ).
    me->set_name( id_name = id_name ).

  endmethod.


  method DESTRUCTOR.
*        SYSTEM-CALL c-destructor 'name' USING attr.
  endmethod.
ENDCLASS.
