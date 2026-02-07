class ZCL_ANA_FRIEND1 definition
  public
  final
  create public

  global friends ZCL_MARIA_FRIEND2 .

public section.

  data MD_NOME type CHAR100 value 'ANA' ##NO_TEXT.
  data MD_SALDO_BANCARIO type NETWR value -1500 ##NO_TEXT.

  methods FINANCE_SITUATION .
protected section.
private section.

  methods BUY
    importing
      !ID_VALUE type NETWR .
ENDCLASS.



CLASS ZCL_ANA_FRIEND1 IMPLEMENTATION.


  method BUY.
    me->md_saldo_bancario = me->md_saldo_bancario = id_value.
  endmethod.


  method FINANCE_SITUATION.
    IF ME->md_saldo_bancario < 0.
      WRITE: |{ md_nome }: Im broke :|.
   ELSEIF me->md_saldo_bancario EQ 0.
      WRITE: |{ md_nome }: I dont have money :|.
   ELSE.
      WRITE: |{ md_nome }: I have money :|.
    ENDIF.
  endmethod.
ENDCLASS.
