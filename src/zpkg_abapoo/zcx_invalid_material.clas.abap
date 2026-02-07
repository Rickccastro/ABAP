class ZCX_INVALID_MATERIAL definition
  public
  inheriting from CX_DYNAMIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .
  interfaces IF_T100_DYN_MSG .

  constants:
    begin of INVALID_MATERIAL,
      msgid type symsgid value 'ZCM_MATNR_ABAP_PLAY',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'MD_MATNR',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of INVALID_MATERIAL .
  data MD_MATNR type INT4 .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MD_MATNR type INT4 optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_INVALID_MATERIAL IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MD_MATNR = MD_MATNR .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
