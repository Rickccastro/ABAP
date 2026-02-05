CLASS zcl_load_data_zrickt_chamado DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_load_data_zrickt_chamado IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

*/        "Inserir Registros
*    TYPES tt_chamado TYPE TABLE OF  zrickt_chamado  WITH DEFAULT KEY.
*    DATA(lt_chamados) = VALUE tt_chamado(
*  (  chamadoid = '1' assunto = 'Description' descricao = 'Description' solicianteid = '1' status = 'A') ).

*    MODIFY zrickt_chamado FROM TABLE @lt_chamados.
   SELECT * FROM zrickt_chamado INTO TABLE @DATA(lt_print).

   LOOP AT lt_print INTO DATA(ls_data).
     out->write( ls_data-chamadoid ).
   ENDLOOP.



  ENDMETHOD.
ENDCLASS.
