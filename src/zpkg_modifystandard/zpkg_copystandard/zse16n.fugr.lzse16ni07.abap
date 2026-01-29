*----------------------------------------------------------------------*
***INCLUDE LSE16NI07.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  FCODE_0120  INPUT
*&---------------------------------------------------------------------*
*       text
*   This module is indroduced by note 3285573
*----------------------------------------------------------------------*
MODULE FCODE_0120 INPUT.

*--- note 3285573 --------------------------------------
" comment code where calling GET CURSOR LINE on subscreen 121.
" ok_code below are handeled in MOULE subscreen 121
*when 'HAVING_OPTION'.
*when 'MORE'.
*when 'OPTION'.
*when 'DELETE'.  " delete value of selected line on subscreen
*---------------------------------------------

  save_ok_code = ok_code.
  clear ok_code.

*.if enter is pressed and gd_add_column is filled, add it
  if gd_add_column <> space and
     save_ok_code  =  space.
    save_ok_code = 'ADD_COLUMN'.
  endif.

  case save_ok_code.
    when 'MARKALL'.
      loop at gt_selfields.
        gt_selfields-mark = true.
        modify gt_selfields.
      endloop.
    when 'MARKKEY'.
      loop at gt_selfields where key = true.
        gt_selfields-mark = true.
        modify gt_selfields.
      endloop.
    when 'REMARKALL'.
      loop at gt_selfields.
        clear gt_selfields-mark.
        modify gt_selfields.
      endloop.
*...start selection in batch
    when 'BATCH'.
      perform fill_tc_0100.                                   "1779629
      perform execute using space true space.
*...create extract in batch
    when 'BATCH_EXTR'.
      perform fill_tc_0100.
      perform extract_create.
*...save variant for batch processing
    when 'BATCH_VAR'.
      perform fill_tc_0100.                                   "1779629
      perform execute using space true true.
*...display change documents
    when 'CD_DISPLAY'.
      perform display_cd.
*...delete change documents
    when 'CD_DEL'.
      perform delete_cd.
*...client pressed
    when 'CLIENT'.
      if gd-read_clnt = space.
         read table gt_selfields index 1.
         check: sy-subrc = 0.
         clear: gt_selfields-low,
                gt_selfields-high,
                gt_selfields-push,
                gt_selfields-option.
         gt_selfields-sign = opt-i.
         modify gt_selfields index 1.
         delete gt_multi where fieldname = gt_selfields-fieldname.
      endif.
    when 'COLNARROW'.
      gd-colopt = true.
    when 'COLWIDE'.
      gd-colopt = space.
******************************field sorting************************
*...get column to the top
    WHEN 'ADD_COLUMN'.
      PERFORM sort_by_add_column.
*...special sorting: show fields with values at the top
    WHEN 'SORTUSED'.
      PERFORM sort_by_used_fields.
*...special sorting: show fields with values at the top
    WHEN 'UNSORTUSED'.
      PERFORM unsort_by_used_fields.
*...delete sorting information
    WHEN 'ERASEUSED'.
      PERFORM erase_used_fields.
*...set cursor down to next field with criteria filled
    WHEN 'CRITNEXT'.
       PERFORM crit_next using '0100'.
*...set cursor up to next field with criteria filled
    WHEN 'CRITPREV'.
       PERFORM crit_prev using '0100'.
*...export field sorting to file
    WHEN 'PARAM_EXPORT'.
       PERFORM param_export.
*...import field sorting from file
    WHEN 'PARAM_IMPORT'.
       PERFORM param_import.
*******************************************************************
*...delete input in all lines
    when 'DELETE_ALL'.
      loop at gt_selfields
              where input <> '0'.
         clear: gt_selfields-low,
                gt_selfields-high,
                gt_selfields-push,
                gt_selfields-option,
                gt_selfields-setid.
         gt_selfields-sign = opt-i.
         modify gt_selfields index sy-tabix.
      endloop.
      refresh gt_multi.
**...delete input in one line                  "note 3285573
*    when 'DELETE'.
*      GET CURSOR LINE ld_line.
*      ld_line = selfields_tc-CURRENT_LINE
*                + ld_line - 1.
*      IF ld_line = 0 OR ld_line < selfields_tc-CURRENT_LINE.
*        EXIT.
*      endif.
*      read table gt_selfields index ld_line.
*      check: sy-subrc = 0,
*             gt_selfields-input <> '0'.
*      clear: gt_selfields-low,
*             gt_selfields-high,
*             gt_selfields-push,
*             gt_selfields-option,
*             gt_selfields-setid.
*      gt_selfields-sign = opt-i.
*      modify gt_selfields index ld_line.
*      delete gt_multi where fieldname = gt_selfields-fieldname.
*...delete input in all SE16H-fields
    when 'DEL_H_ALL'.
      loop at gt_selfields.
         clear: gt_selfields-sum_up,
                gt_selfields-group_by,
                gt_selfields-order_by,
                gt_selfields-toplow,
                gt_selfields-sortorder,
                gt_selfields-aggregate,
                gt_selfields-having_option,
                gt_selfields-having_value.
         modify gt_selfields index sy-tabix.
      endloop.
*...documentation
    when 'DOCU'.
      perform show_docu using '1636416'.
*...Execute
    when 'EXEC'.
*.....Perhaps the table did change without Return
      perform fill_tc_0100.
      perform execute using space space space.
*...start formula maintenance
    WHEN 'FORMULA'.
      PERFORM formula_maintain.
*...read extract
    when 'EXTR_READ'.
      perform show_extract.
*...extended search help on table
    when 'F4_EXT'.
      perform f4_tabname_extended.
**...having option                                   "note 3285573
*    when 'HAVING_OPTION'.
*      perform f4_having_option.
*...delete layout variant of first screen
    when 'L_DEL'.
      gs_se16n_lt-tab = gd-tab.
      perform layout_delete.
*...get layout variant of first screen
    when 'L_GET'.
      gs_se16n_lt-tab = gd-tab.
      perform layout_get.
*...save layout variant of first screen
    when 'L_SAVE'.
      gs_se16n_lt-uname = sy-uname.
      perform layout_save.
*...Select only number of entries
    when 'LINES'.
      perform fill_tc_0100.                                   "1779629
      perform execute using true space space.
*...Select only number of entries (batch)
    when 'LINES_BAT'.
      perform fill_tc_0100.                                   "1779629
      perform execute using true true space.
*...Save SE38-variant for number of entries
    when 'LINES_VAR'.
      perform fill_tc_0100.                                   "1779629
      perform execute using true true true.
**...multiple selection                               "note 3285573
*    when 'MORE'.
*      GET CURSOR LINE ld_line.
*      ld_line = selfields_tc-CURRENT_LINE
*                + ld_line - 1.
*      IF ld_line = 0 OR ld_line < selfields_tc-CURRENT_LINE.
*        EXIT.
*      endif.
*      perform show_multi_select using ld_line.
*...multi input of combined or-select-statements
    when 'MULTI_OR'.
      perform multi_or.
*...technical view
    when 'NOTECHVIEW'.
      gd-tech_view = false.
*...definition of outer joins
    when 'OJKEY'.
      perform ojkey.
**...change select option                              "note 3285573
*    when 'OPTION'.
*      perform set_sel_option using space.
*...Double-Click-Navigation
    when 'PICK'.
      perform pick_navigation.
*...save technical settings
    when 'SAVE_FLAGS'.
      perform save_flags.
*...set technical settings
    when 'SET_FLAGS'.
      perform set_tech_flags.
*...get table details            " 3285573 enhancement
    when 'TBDT'.                 " 3285573 enhancement
      perform get_table_details. " 3285573 enhancement
*...technical view
    when 'TECHVIEW'.
      gd-tech_view = true.
*...search for fieldname
    when 'SUCH'.
      perform search_fieldname.
*...search for fieldname
    when 'SUCHFROM'.
      perform search_fieldname.
*...jump to view maintenance
    when 'VIEW'.
      perform view_maint.
*...where used list for table
    when 'WUSLTABL'.
      perform wusl_table.
    when '&F03'.
      set screen 0.
      leave screen.
    when '&F15'.
      perform end.
      set screen 0.
      leave screen.
    when c_zebra.
      gd-zebra = true.
    when c_no_zebra.
      clear gd-zebra.
    when c_no_buffer.
      clear gd-buffer.
    when c_sap_no_edit.
      clear gd-edit.
      clear gd-sapedit.
    when c_sap_edit.
      perform fill_sap_edit.
    when c_sap_fda.
      if gd-fda_on = true.
        clear gd-fda_on.
      else.
        gd-fda_on = true.
      endif.
    when c_sap_no_check.
      gd-checkkey = true.
    when c_sap_picture.
      perform fill_picture.
*Scrolling..................................................
    WHEN 'PMM'.
      selfields_tc-top_line = 1.
    WHEN 'PM'.
      selfields_tc-top_line = selfields_tc-top_line - looplines.
      IF selfields_tc-top_line < 1.
        selfields_tc-top_line = 1.
      ENDIF.
    WHEN 'PP'.
      selfields_tc-top_line = selfields_tc-top_line + looplines.
      IF selfields_tc-top_line > linecount.
        selfields_tc-top_line = linecount - looplines + 1.
        IF selfields_tc-top_line < 1.
          selfields_tc-top_line = 1.
        ENDIF.
      ENDIF.
    WHEN 'PPP'.
      selfields_tc-top_line = linecount - looplines + 1.
      IF selfields_tc-top_line < 1.
        selfields_tc-top_line = 1.
      ENDIF.
*..................................................
  endcase.
  clear ok_code.

ENDMODULE.                 " FCODE_0120  INPUT

*&---------------------------------------------------------------------*
*&      Module  FCODE_0121  INPUT
*&---------------------------------------------------------------------*
*       text
*  This module is introduced by note 3285573
*  It handels the ok_code in subscreen 121, which were in screen 100.
*  Here just move the ABAP code of these ok_code from Module FCODE_0100.
*----------------------------------------------------------------------*
MODULE fcode_0121 INPUT.

  save_ok_code = ok_code.

  case save_ok_code.

*...delete input in one line
    when 'DELETE'.
      GET CURSOR LINE ld_line.
      ld_line = selfields_tc-CURRENT_LINE
                + ld_line - 1.
      IF ld_line = 0 OR ld_line < selfields_tc-CURRENT_LINE.
        EXIT.
      endif.
      read table gt_selfields index ld_line.
      check: sy-subrc = 0.
      clear: gt_selfields-low,
             gt_selfields-high,
             gt_selfields-push,
             gt_selfields-option,
             gt_selfields-setid.
      gt_selfields-sign = opt-i.
      modify gt_selfields index ld_line.
      delete gt_multi where fieldname = gt_selfields-fieldname.

*...having option
    when 'HAVING_OPTION'.
      perform f4_having_option.


*...multiple selection
    when 'MORE'.
      GET CURSOR LINE ld_line.
      ld_line = selfields_tc-CURRENT_LINE
                + ld_line - 1.
      IF ld_line = 0 OR ld_line < selfields_tc-CURRENT_LINE.
        EXIT.
      endif.
      perform show_multi_select using ld_line.

*...change select option
    when 'OPTION'.   " enhancement 2023
      perform set_sel_option using space.

  endcase.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  FCODE_0122  INPUT
*&---------------------------------------------------------------------*
*       text
*   This module is indroduced by note 3285573
*----------------------------------------------------------------------*
MODULE fcode_0122 INPUT.
   ok_code = sy-ucomm.

   case ok_code.

     when 'CANCEL'.
*      clear ok_code.  "will be done later
       set screen 0.
       leave screen.
     when 'OK'.
*      clear ok_code.  "will be done later
       set screen 0.
       leave screen.

    WHEN 'FORMULA'.
      PERFORM formula_maintain.

   endcase.

ENDMODULE.
