*&---------------------------------------------------------------------*
*& Report Z_AUTHORITY_CHECK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_AUTHORITY_CHECK.
* Criar Classe e Objeto de Autorização
* Transação SU21
*
* Exibir verificação de autorização
* Transação SU53
*
* Dar autorização para um usuário
* Transação PFCG

CONSTANTS: lc_green TYPE char4 VALUE '@5B@'.
CONSTANTS: lc_red   TYPE char4 VALUE '@5C@'.

START-OF-SELECTION.
  AUTHORITY-CHECK OBJECT 'ZABAPPLAY'
         ID 'ACTVT' FIELD '01'.

  CASE sy-subrc.
    WHEN 0.
      WRITE lc_green AS ICON.
      WRITE 'Você tem autorização'.
    WHEN 4.
      WRITE lc_red AS ICON.
      WRITE |Você não tem autorização|.
    WHEN 12.
      WRITE lc_red AS ICON.
      WRITE |Nenhuma autorização encontrada|.
    WHEN OTHERS.
      WRITE lc_red AS ICON.
      WRITE |Erro em verificar autorização ({ sy-subrc })|.
  ENDCASE.
