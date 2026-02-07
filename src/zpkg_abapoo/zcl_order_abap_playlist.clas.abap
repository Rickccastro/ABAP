class ZCL_ORDER_ABAP_PLAYLIST definition
  public
  final
  create public .

public section.

  methods ADD_ITEM
    importing
      !ID_MATNR type INT4
      !ID_QTDE type INT4
      !ID_PRICE type NETWR
    raising
      ZCX_INVALID_MATERIAL .
  methods DYNAMIC_CHECK
    raising
      ZCX_DYNAMIC_CHECK .
  methods NO_CHECK .
  methods STATIC_CHECK
    raising
      ZCX_STATIC_CHECK .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ORDER_ABAP_PLAYLIST IMPLEMENTATION.


  method ADD_ITEM.
*    DATA lo_ex TYPE REF TO ZCX_INVALID_MATERIAL.
    IF id_matnr LE 0.
       DATA(lo_ex) = NEW ZCX_INVALID_MATERIAL(  textid = ZCX_INVALID_MATERIAL=>INVALID_MATERIAL  md_matnr = id_matnr ).
*      RAISE EXCEPTION TYPE ZCX_INVALID_MATERIAL.
      RAISE EXCEPTION lo_ex.
    ENDIF.
  endmethod.


  method DYNAMIC_CHECK.
    RAISE EXCEPTION TYPE ZCX_DYNAMIC_CHECK.
  endmethod.


  METHOD no_check.
    RAISE EXCEPTION TYPE zcx_no_check.
  ENDMETHOD.


  method STATIC_CHECK.
    RAISE EXCEPTION TYPE ZCX_STATIC_CHECK.
  endmethod.
ENDCLASS.
