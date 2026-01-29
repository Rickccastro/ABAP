PROCESS BEFORE OUTPUT.
  MODULE SET_CUA_variant.
*
PROCESS AFTER INPUT.
  MODULE back AT EXIT-COMMAND.
  CHAIN.
    FIELD gs_se16n_lt-uspec.
    FIELD gs_se16n_lt-name.
    FIELD gs_se16n_lt-txt.
    FIELD gs_se16n_lt-uname.
    FIELD OK_CODE        MODULE OWN_VARIANT_CREATE.
  ENDCHAIN.
*
PROCESS ON VALUE-REQUEST.
   FIELD gs_se16n_lt-name MODULE OWN_VARIANT_F4.















