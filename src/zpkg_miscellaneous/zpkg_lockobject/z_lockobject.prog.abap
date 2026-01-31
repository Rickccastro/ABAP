*&---------------------------------------------------------------------*
*& Report Z_LOCKOBJECT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_lockobject.

DATA: gd_gravar TYPE char1.
DATA: gd_name   TYPE zlockobject-name.
DATA: gd_bloqueado  TYPE char1.

SELECTION-SCREEN BEGIN OF BLOCK bl WITH FRAME.
  PARAMETERS p_kunnr TYPE zlockobject-kunnr.
SELECTION-SCREEN END OF BLOCK bl.

START-OF-SELECTION.
  PERFORM bloquear.

  IF gd_bloqueado NE 'X' .
    MESSAGE |The user { sy-msgv1 } is blocking your register { p_kunnr }| TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

  PERFORM obter_nome.

  IF gd_gravar NE 'X'.
    EXIT.
  ENDIF.

  PERFORM gravar_nome.
  PERFORM desbloquear.

FORM desbloquear.
*  DATA: ls_varkey TYPE vim_enqkey.
*  ls_varkey = |{ sy-mandt } { p_kunnr }|.

  CALL FUNCTION 'DEQUEUE_EZLOCKOBJ'
    EXPORTING
*     MODE_ZLOCKOBJECT       = 'E'
*     MANDT                  = SY-MANDT
      KUNNR                  = p_kunnr
*     X_KUNNR                = ' '
*     _SCOPE                 = '3'
*     _SYNCHRON              = ' '
*     _COLLECT               = ' '
            .

" Generic
*  CALL FUNCTION 'DEQUEUE_E_TABLE'
*    EXPORTING
**     MODE_RSTABLE       = 'E'
*      tabname = 'ZLOCKOBJECT'
*      varkey  = ls_varkey
**     X_TABNAME          = ' '
**     X_VARKEY           = ' '
**     _SCOPE  = '3'
**     _SYNCHRON          = ' '
**     _COLLECT           = ' '
*    .

ENDFORM.


FORM bloquear.
*  DATA: ls_varkey TYPE vim_enqkey.

  gd_bloqueado = ''.

*  ls_varkey = |{ sy-mandt } { p_kunnr }|.

    CALL FUNCTION 'ENQUEUE_EZLOCKOBJ'
   EXPORTING
*     MODE_ZLOCKOBJECT       = 'E'
*     MANDT                  = SY-MANDT
      KUNNR                  = p_kunnr
*     X_KUNNR                = ' '
*     _SCOPE                 = '2'
*     _WAIT                  = ' '
*     _COLLECT               = ' '
   EXCEPTIONS
     FOREIGN_LOCK           = 1
     SYSTEM_FAILURE         = 2
     OTHERS                 = 3
            .
  " Generic
*  CALL FUNCTION 'ENQUEUE_E_TABLE'
*    EXPORTING
**     MODE_RSTABLE   = 'E'
*      tabname        = 'ZLOCKOBJECT'
*      varkey         = ls_varkey
**     X_TABNAME      = ' '
**     X_VARKEY       = ' '
**     _SCOPE         = '2'
**     _WAIT          = ' '
**     _COLLECT       = ' '
*    EXCEPTIONS
*      foreign_lock   = 1
*      system_failure = 2
*      OTHERS         = 3.

  IF sy-subrc EQ 0.
    gd_bloqueado = 'X'.
  ENDIF.

ENDFORM.

FORM obter_nome.
  DATA: lt_field TYPE STANDARD TABLE OF sval.
  DATA: ls_field TYPE sval.
  DATA: ld_rc    TYPE char1.

  CLEAR lt_field.

  SELECT SINGLE name
    INTO gd_name
    FROM zlockobject
    WHERE kunnr = p_kunnr.

  CLEAR ls_field.
  ls_field-tabname  = 'ZLOCKOBJECT'.
  ls_field-fieldname = 'NAME'.
  ls_field-value     = gd_name.
  APPEND ls_field TO lt_field.

  CALL FUNCTION 'POPUP_GET_VALUES'
    EXPORTING
      popup_title     = 'Informe o nome'
    IMPORTING
      returncode      = ld_rc
    TABLES
      fields          = lt_field
    EXCEPTIONS
      error_in_fields = 1
      OTHERS          = 2.

  gd_gravar = ''.


  IF sy-subrc = 0 AND ld_rc = ''.
    gd_gravar = 'X'.
    READ TABLE lt_field INTO ls_field INDEX 1.
    IF sy-subrc = 0.
      gd_name = ls_field-value.
    ENDIF.
  ELSE.
    MESSAGE 'Atualização cancelada' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.

FORM gravar_nome.
  UPDATE zlockobject SET name = gd_name WHERE kunnr = p_kunnr.

  IF sy-subrc = 0.
    MESSAGE 'Cliente Atualizado' TYPE 'S'.
  ENDIF.
ENDFORM.
