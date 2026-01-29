PROCESS BEFORE OUTPUT.
  MODULE STATUS_1000.
  MODULE get_linecount_1000.

  loop at gt_role_table into gs_role_table
         with control tab_role_table
             cursor tab_role_table-current_line.
      module show_tab_role_table.
      module change_tab_role_table.
*     module get_looplines_tab_tc.
  endloop.
  loop at gt_role_value into gs_role_value
         with control tab_role_value
             cursor tab_role_value-current_line.
      module show_tab_role_value.
      module change_tab_role_value.
  endloop.
  loop at gt_user_role into gs_user_role
         with control tab_user_role
             cursor tab_user_role-current_line.
      module show_tab_user_role.
      module change_tab_user_role.
  endloop.

*
PROCESS AFTER INPUT.

  module back_1000 at EXIT-COMMAND.

  loop at gt_role_table.
    chain.
       field gs_role_table-tabname.
       field gs_role_table-fieldname.
       field gs_role_table-no_authority.
       field gs_role_table-mark1.
          module take_data_role_table on chain-request.
    endchain.
  endloop.
  loop at gt_role_value.
    chain.
       field gs_role_value-tabname.
       field gs_role_value-fieldname.
       field gs_role_value-mark2.
       field gs_role_value-dd_reftab.
          module take_data_role_value on chain-request.
    endchain.
  endloop.
  loop at gt_user_role.
    chain.
       field gs_user_role-uname.
       field gs_user_role-mark3.
          module take_data_user_role.
    endchain.
  endloop.

  MODULE USER_COMMAND_1000.

PROCESS ON VALUE-REQUEST.

  field gs_role_table-tabname   module f4_tab_table.
  field gs_role_table-fieldname module f4_field_table.
  field gs_role_value-tabname   module f4_tab_value.
  field gs_role_value-fieldname module f4_field_value.
