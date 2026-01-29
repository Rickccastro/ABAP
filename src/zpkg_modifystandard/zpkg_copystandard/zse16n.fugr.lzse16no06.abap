*----------------------------------------------------------------------*
***INCLUDE LSE16NO06.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module Module STATUS_0122 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0122 OUTPUT.
 SET PF-STATUS '0122'.
 SET TITLEBAR '122'.
ENDMODULE.  "STATUS_0122

**&---------------------------------------------------------------------*
**& Module FILL_TC_0122 OUTPUT
**&---------------------------------------------------------------------*
**&
**&---------------------------------------------------------------------*
*MODULE FILL_TC_0122 OUTPUT.
*
*   perform fill_tc_0122.
*
*ENDMODULE. "FILL_TC_0122

*&---------------------------------------------------------------------*
*& Module GET_LINECOUNT_0122 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*MODULE GET_LINECOUNT_0122 OUTPUT.
** SET PF-STATUS 'xxxxxxxx'.
** SET TITLEBAR 'xxx'.
*
*  data: ld_fieldname like dfies-lfieldname.
*
*  DESCRIBE TABLE GT_SELFIELDS LINES LINECOUNT.
*  SELFIELDS_TC-LINES = LINECOUNT.
*
**.only if tax audit, display text
*  CALL FUNCTION 'CA_USER_EXISTS'
*      EXPORTING
*        i_user       = sy-uname
*      EXCEPTIONS
*        user_missing = 1.
*  if sy-subrc <> 0.
*     loop at screen.
*        if screen-name = 'TXT_TAX_AUDIT'.
*           screen-invisible = 1.
*           modify screen.
*        endif.
*     endloop.
*  else.
*     loop at screen.
*        if screen-name = 'EXT_F4'.
*           screen-invisible = 1.
*           modify screen.
*        endif.
*     endloop.
*  endif.
*
**.if no proxy object -> no display of field
*  if gd-proxy_object is initial.
*     loop at screen.
*        if screen-group4 = 'PXY'.
*           screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
*
**.if no entity -> no display of field
*  if gd-entity is initial.
*     loop at screen.
*        if screen-group4 = 'ENT'.
*           screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
**.if no ddlname -> no display of field
*  if gd-ddlname is initial.
*     loop at screen.
*        if screen-group4 = 'DDL'.
*           screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
**.if not client dependent, do not bother user with client choose
*  if gd-clnt <> true or
*     gd-no_clnt_anymore = true or
*     gd-no_clnt_auth = true.
*     loop at screen.
*        if screen-group4 = 'CLT'.
*           screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
*
**.hide fast data access
*  if gd-fda_on <> true.
*     loop at screen.
*        if screen-group4 = 'FDA'.
*           screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
**.do not show formulas for non-technical view
*  IF gd-tech_view <> true.
*    LOOP AT SCREEN.
*      IF screen-group3 = 'FOR'.
*        screen-invisible = 1.
*        screen-input     = 0.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDLOOP.
*  ENDIF.
*
**.take care of exit-fields
*  if gd-add_fields <> true.
*    loop at screen.
*       if screen-group2 = 'EXI'.
*          screen-invisible = 1.
*          screen-input     = 0.
*          modify screen.
*       endif.
*    endloop.
*  endif.
**.change length of input field according data element
*  if gd-add_field_reftab <> space and
*     gd-add_field_reffld <> space.
*     ld_fieldname = gd-add_field_reffld.
*     CALL FUNCTION 'DDIF_FIELDINFO_GET'
*       EXPORTING
*         TABNAME              = gd-add_field_reftab
*         LFIELDNAME           = ld_fieldname
*       IMPORTING
*         DFIES_WA             = gs_dfies
*       EXCEPTIONS
*         OTHERS               = 3.
*     IF SY-SUBRC = 0.
*       loop at screen.
*         if screen-name = 'GD-ADD_FIELD'.
*            screen-length = gs_dfies-leng.
*            modify screen.
*         endif.
*       endloop.
*     endif.
*  else.
*     loop at screen.
*       if screen-name = 'GD-ADD_FIELD' or
*          screen-name = 'GD-ADD_FIELD_TEXT'.
*          screen-invisible = 1.
*          screen-input     = 0.
*          modify screen.
*       endif.
*     endloop.
*  endif.
*
*" Grouping minimum
*   if gd-hana_active <> true.
*    loop at screen.
*       if screen-group3 = 'DBC'.
*          screen-invisible = 1.
*          screen-input     = 0.
*          modify screen.
*       endif.
*    endloop.
*  else.
**...only allow input via F4
*    loop at screen.
*       if screen-name = 'GD-OJKEY'.
*          screen-input = 0.
**         modify screen.
*       endif.
*    endloop.
*  endif.
*
*ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  GET_LINECOUNT_0120  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE GET_LINECOUNT_0120 OUTPUT.
*
*" data: ld_fieldname like dfies-lfieldname. "note 3285573
*
*  DESCRIBE TABLE GT_SELFIELDS LINES LINECOUNT.
*  SELFIELDS_TC-LINES = LINECOUNT.
*
***.only if tax audit, display text      "note 3285573
**  CALL FUNCTION 'CA_USER_EXISTS'
**      EXPORTING
**        i_user       = sy-uname
**      EXCEPTIONS
**        user_missing = 1.
**  if sy-subrc <> 0.
**     loop at screen.
**        if screen-name = 'TXT_TAX_AUDIT'.
**           screen-invisible = 1.
**           modify screen.
**        endif.
**     endloop.
**  else.
**     loop at screen.
**        if screen-name = 'EXT_F4'.
**           screen-invisible = 1.
**           modify screen.
**        endif.
**     endloop.
**  endif.
**
***.if no text table -> no display of text table line  ""note 3285573
**  if gd-txt_tab is initial.
**     loop at screen.
**        if screen-group4 = 'TTA'.
***          screen-invisible = 1.
**           screen-input     = 0.
**           modify screen.
**        endif.
**     endloop.
**  endif.
*
**.in emergency mode restrict to necessary fields
*  if gd-emergency = true.
*     loop at screen.
*        if screen-group3 = 'FOR'.
*           screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
*
***.if no proxy object -> no display of field   "note 3285573
**  if gd-proxy_object is initial.
**     loop at screen.
**        if screen-group4 = 'PXY'.
**           screen-invisible = 1.
**           screen-input     = 0.
**           modify screen.
**        endif.
**     endloop.
**  endif.
**
***.if no entity -> no display of field     "note 3285573
**  if gd-entity is initial.
**     loop at screen.
**        if screen-group4 = 'ENT'.
**           screen-invisible = 1.
**           screen-input     = 0.
**           modify screen.
**        endif.
**     endloop.
**  endif.
***.if no ddlname -> no display of field    "note 3285573
**  if gd-ddlname is initial.
**     loop at screen.
**        if screen-group4 = 'DDL'.
**           screen-invisible = 1.
**           screen-input     = 0.
**           modify screen.
**        endif.
**     endloop.
**  endif.
**
***.if not client dependent, do not bother user with client choose  "note 3285573
**  if gd-clnt <> true or
**     gd-no_clnt_anymore = true or
**     gd-no_clnt_auth = true.
**     loop at screen.
**        if screen-group4 = 'CLT'.
**           screen-invisible = 1.
**           screen-input     = 0.
**           modify screen.
**        endif.
**     endloop.
**  endif.
*
***.hide fast data access                         "note 3285573
**  if gd-fda_on <> true.
**     loop at screen.
**        if screen-group4 = 'FDA'.
**           screen-invisible = 1.
**           screen-input     = 0.
**           modify screen.
**        endif.
**     endloop.
**  endif.
*
**.if hana-mode, show new DB-Connection, otherwise not
*  if gd-hana_active <> true.
*    loop at screen.
*       if screen-group3 = 'DBC'.
*          screen-invisible = 1.
*          screen-input     = 0.
*          modify screen.
*       endif.
*    endloop.
*  else.
**...only allow input via F4
*    loop at screen.
*       if screen-name = 'GD-OJKEY'.
*          screen-input = 0.
**         modify screen.
*       endif.
*    endloop.
*  endif.
*
**.if table is editable, allow to switch it off
*  if gd-tabedit <> true.
*     loop at screen.
*        if screen-group4 = 'EDT'.
**          screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
*
**.deactivate jump to SE16T if not wanted
*  if gd-se16t_off = true.
*     loop at screen.
*        if screen-group3 = '16T'.
*           screen-invisible = 1.
*           screen-input     = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
*
**.if special call via SE16N_START with only one table
**.do not allow to change the name of the table
*  if gd-single_tab = true.
*     loop at screen.
*        if screen-name = 'GD-TAB'.
*           screen-input  = 0.
**          screen-active = 0.
*           modify screen.
*        endif.
*        if screen-name = 'EXT_F4'.
*           screen-invisible = 1.
*           screen-active    = 0.
*           modify screen.
*        endif.
*     endloop.
*  endif.
*
**.change the order of the columns if wanted
*  if gd-tech_first = true.
**...First of all get the current position of the columns, because they
**...could have been changed by the user.
*    clear: tec_index, fld_index.
*    LOOP AT SELFIELDS_TC-COLS INTO WA.
*      IF WA-SCREEN-GROUP4 = 'TEC'.
*         tec_index = wa-index.
*      ENDIF.
*      IF WA-SCREEN-GROUP4 = 'FLD'.
*         fld_index = wa-index.
*      ENDIF.
*    endloop.
**...Now change the position of the columns
*    LOOP AT SELFIELDS_TC-COLS INTO WA.
*      IF WA-SCREEN-GROUP4 = 'TEC'.
*         if tec_index < fld_index.
*            WA-index = tec_index.
*         else.
*            wa-index = fld_index.
*         endif.
*         modify selfields_tc-cols from wa.
*      ENDIF.
*      IF WA-SCREEN-GROUP4 = 'FLD'.
*         if fld_index > tec_index.
*            WA-index = fld_index.
*         else.
*            wa-index = tec_index.
*         endif.
*         modify selfields_tc-cols from wa.
*      ENDIF.
*    endloop.
*  else.
**...First of all get the current position of the columns, because they
**...could have been changed by the user.
*    clear: tec_index, fld_index.
*    LOOP AT SELFIELDS_TC-COLS INTO WA.
*      IF WA-SCREEN-GROUP4 = 'TEC'.
*         tec_index = wa-index.
*      ENDIF.
*      IF WA-SCREEN-GROUP4 = 'FLD'.
*         fld_index = wa-index.
*      ENDIF.
*    endloop.
*    LOOP AT SELFIELDS_TC-COLS INTO WA.
*      IF WA-SCREEN-GROUP4 = 'TEC'.
*         if fld_index > tec_index.
*            WA-index = fld_index.
*         else.
*            wa-index = tec_index.
*         endif.
*         modify selfields_tc-cols from wa.
*      ENDIF.
*      IF WA-SCREEN-GROUP4 = 'FLD'.
*         if tec_index < fld_index.
*            WA-index = tec_index.
*         else.
*            wa-index = fld_index.
*         endif.
*         modify selfields_tc-cols from wa.
*      ENDIF.
*    endloop.
*  endif.
*
**.try to condense the fields to make more columns visible
*  if gd-colopt = true.
*    LOOP AT SELFIELDS_TC-COLS INTO WA.
*      case wa-screen-name.
*        when 'GS_SELFIELDS-LOW'.
*          wa-vislength = 15.
*        when 'GS_SELFIELDS-HIGH'.
*          wa-vislength = 15.
*        when 'GS_SELFIELDS-SETID'.
*          wa-vislength = 10.
*        when 'GS_SELFIELDS-MARK'.
*          wa-vislength = 3.
*        when 'GS_SELFIELDS-SUM_UP'.
*          wa-vislength = 3.
*        when 'GS_SELFIELDS-GROUP_BY'.
*          wa-vislength = 3.
*        when 'GS_SELFIELDS-ORDER_BY'.
*          wa-vislength = 3.
*        when 'GS_SELFIELDS-TOPLOW'.
*          wa-vislength = 5.
*        when 'GS_SELFIELDS-SORTORDER'.
*          wa-vislength = 3.
*        when 'GS_SELFIELDS-AGGREGATE'.
*          wa-vislength = 5.
*        when 'GS_SELFIELDS-FIELDNAME'.
*          wa-vislength = 12.
*        when 'GS_SELFIELDS-CURR_ADD_UP'.
*          wa-vislength = 3.
*        when 'GS_SELFIELDS-QUAN_ADD_UP'.
*          wa-vislength = 3.
*        when 'GS_SELFIELDS-HAVING_VALUE'.
*          wa-vislength = 15.
*      endcase.
*      modify selfields_tc-cols from wa.
*    endloop.
*  else.
*    LOOP AT SELFIELDS_TC-COLS INTO WA.
*      case wa-screen-name.
*        when 'GS_SELFIELDS-LOW'.
*          wa-vislength = 25.
*        when 'GS_SELFIELDS-HIGH'.
*          wa-vislength = 25.
*        when 'GS_SELFIELDS-SETID'.
*          wa-vislength = 15.
*        when 'GS_SELFIELDS-MARK'.
*          wa-vislength = 8.
*        when 'GS_SELFIELDS-SUM_UP'.
*          wa-vislength = 10.
*        when 'GS_SELFIELDS-GROUP_BY'.
*          wa-vislength = 12.
*        when 'GS_SELFIELDS-ORDER_BY'.
*          wa-vislength = 10.
*        when 'GS_SELFIELDS-TOPLOW'.
*          wa-vislength = 10.
*        when 'GS_SELFIELDS-SORTORDER'.
*          wa-vislength = 10.
*        when 'GS_SELFIELDS-AGGREGATE'.
*          wa-vislength = 12.
*        when 'GS_SELFIELDS-FIELDNAME'.
*          wa-vislength = 20.
*        when 'GS_SELFIELDS-CURR_ADD_UP'.
*          wa-vislength = 15.
*        when 'GS_SELFIELDS-QUAN_ADD_UP'.
*          wa-vislength = 15.
*        when 'GS_SELFIELDS-HAVING_VALUE'.
*          wa-vislength = 20.
*      endcase.
*      modify selfields_tc-cols from wa.
*    endloop.
*  endif.
*
**.if users wants the technical view, display more fields
*  if gd-tech_view <> true.
*     LOOP AT SELFIELDS_TC-COLS INTO WA.
*        IF WA-SCREEN-GROUP3 = 'TEC'.
*           WA-INVISIBLE = 1.
*           modify selfields_tc-cols from wa.
*        ENDIF.
*     endloop.
*  else.
*     LOOP AT SELFIELDS_TC-COLS INTO WA.
*        IF WA-SCREEN-GROUP3 = 'TEC'.
*           WA-INVISIBLE = 0.
*           modify selfields_tc-cols from wa.
*        ENDIF.
*     endloop.
*  endif.
*
**.if table has no CURR and QUAN-fields, do not show the totalling
*  read table gt_selfields into lls_selfields
*        with key datatype = 'CURR'.
*  if sy-subrc <> 0.
*     LOOP AT SELFIELDS_TC-COLS INTO WA.
*        IF WA-SCREEN-GROUP4 = 'TCU'.
*           WA-INVISIBLE = 1.
*           modify selfields_tc-cols from wa.
*        ENDIF.
*     endloop.
*  endif.
*  read table gt_selfields into lls_selfields
*        with key datatype = 'QUAN'.
*  if sy-subrc <> 0.
*     LOOP AT SELFIELDS_TC-COLS INTO WA.
*        IF WA-SCREEN-GROUP4 = 'TQU'.
*           WA-INVISIBLE = 1.
*           modify selfields_tc-cols from wa.
*        ENDIF.
*     endloop.
*  endif.
*
**.in case of no Hana-mode, do not show the columns at all
*  if gd-hana_active <> true.
*    LOOP AT SELFIELDS_TC-COLS INTO WA.
*       IF WA-SCREEN-GROUP4 = 'HSU' or
*          wa-screen-group4 = 'HGP' or
*          wa-screen-group4 = 'HOR' or
*          wa-screen-group4 = 'HAG' or
*          wa-screen-group4 = 'HSE' or
*          wa-screen-group4 = 'HAV'.
*          WA-INVISIBLE = 1.
*          modify selfields_tc-cols from wa.
*       ENDIF.
*    endloop.
*  endif.
*
**..do not allow aggregation or summation for pool-tables
**..check if table is a pool-table. DD02L is filled upfront
*   if dd02l-tabname = gd-tab and
*      ( dd02l-tabclass = 'POOL' or
*        dd02l-tabclass = 'CLUSTER' ).
*      LOOP AT SELFIELDS_TC-COLS INTO WA.
*         IF WA-SCREEN-GROUP4 = 'HAG' or
*            WA-SCREEN-GROUP4 = 'HSU' or
*            WA-SCREEN-GROUP4 = 'HGP' or
*            WA-SCREEN-GROUP4 = 'HOR' or
*            WA-SCREEN-GROUP4 = 'HAV'.
*            WA-INVISIBLE = 1.
*            modify selfields_tc-cols from wa.
*         ENDIF.
*      endloop.
*   else.
*     if gd-hana_active = true.
*       LOOP AT SELFIELDS_TC-COLS INTO WA.
*         IF WA-SCREEN-GROUP4 = 'HAG' or
*            WA-SCREEN-GROUP4 = 'HSU' or
*            WA-SCREEN-GROUP4 = 'HGP' or
*            WA-SCREEN-GROUP4 = 'HOR' or
*            WA-SCREEN-GROUP4 = 'HAV'.
*            WA-INVISIBLE = 0.
*            modify selfields_tc-cols from wa.
*         ENDIF.
*       endloop.
*     endif.
*   endif.
*
**.take care of exit-fields
*  if gd-add_fields <> true.
*    loop at screen.
*       if screen-group2 = 'EXI'.
*          screen-invisible = 1.
*          screen-input     = 0.
*          modify screen.
*       endif.
*    endloop.
*  endif.
**.change length of input field according data element
*  if gd-add_field_reftab <> space and
*     gd-add_field_reffld <> space.
*     ld_fieldname = gd-add_field_reffld.
*     CALL FUNCTION 'DDIF_FIELDINFO_GET'
*       EXPORTING
*         TABNAME              = gd-add_field_reftab
*         LFIELDNAME           = ld_fieldname
*       IMPORTING
*         DFIES_WA             = gs_dfies
*       EXCEPTIONS
*         OTHERS               = 3.
*     IF SY-SUBRC = 0.
*       loop at screen.
*         if screen-name = 'GD-ADD_FIELD'.
*            screen-length = gs_dfies-leng.
*            modify screen.
*         endif.
*       endloop.
*     endif.
*  else.
*     loop at screen.
*       if screen-name = 'GD-ADD_FIELD' or
*          screen-name = 'GD-ADD_FIELD_TEXT'.
*          screen-invisible = 1.
*          screen-input     = 0.
*          modify screen.
*       endif.
*     endloop.
*  endif.
*
**.do not show formulas for non-technical view
*  IF gd-tech_view <> true.
*    LOOP AT SCREEN.
*      IF screen-group3 = 'FOR'.
*        screen-invisible = 1.
*        screen-input     = 0.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDLOOP.
*  ENDIF.
*
**.CRIT_NEXT or CRIT_PREV has been used, set cursor
*  if gd_cursor_line = 1.
*     SET CURSOR FIELD 'GS_SELFIELDS-LOW' LINE 1.
*     gd_cursor_line = 0.
*  endif.
*
*ENDMODULE. "GET_LINECOUNT_0120
