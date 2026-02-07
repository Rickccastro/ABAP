class ZCL_MARIA_FRIEND2 definition
  public
  final
  create public .

public section.

  methods SHOW_SECRET
    importing
      !IO_MARIA type ref to ZCL_ANA_FRIEND1 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MARIA_FRIEND2 IMPLEMENTATION.


  method SHOW_SECRET.
    WRITE: |MY FRIEND ANA HAVE { io_maria->md_saldo_bancario }|.
  endmethod.
ENDCLASS.
