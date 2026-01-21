class ZCL_IM_BADI_SD_REF_DOC_CUST2 definition
  public
  final
  create public .

*"* public components of class CL_EXM_IM_SD_REF_DOC_CUST
*"* do not include other source files here!!!
public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_SD_REF_DOC_CUST .
protected section.
*"* protected components of class CL_EXM_IM_SD_REF_DOC_CUST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_EXM_IM_SD_REF_DOC_CUST
*"* do not include other source files here!!!
ENDCLASS.



CLASS ZCL_IM_BADI_SD_REF_DOC_CUST2 IMPLEMENTATION.


METHOD if_sd_ref_doc_cust~get_info_structures.

* ====================================================================== *
* 1) Archive info strucures (CT_AIND_STR1) can be checked and it is allowed
*    to delete archive info strucures if archived sales documents shall not
*    be selected from deleted archive info strucures. The consequence of this
*    term is that it is not allowed to add (e.g. by INSERT or APPEND) lines.
*    The imported archive info strucures are the maximum valid one.
* ====================================================================== *

* Archive information structure 'Z_SAP_SD_VBAK4' shall not be considered by searching archived sales documents
  DELETE ct_aind_str1 WHERE archindex = 'Z_SAP_SD_VBAK4'  " Archive information structure 'Z_SAP_SD_VBAK4'
                           and ITYPE  = 'I'.              " ITYPE shall be 'I' ('I' means info structure)

ENDMETHOD.


method if_sd_ref_doc_cust~search_for_ref_doc.

  data: lt_item      type msr_t_listvbap,
        ls_item      type listvbap,
        lt_arch_item type sdinfo_t_archived_sales_docs.

  data: lv_read_archiv type charx.

* ====================================================================== *
* 1) Common checks for business process
* ====================================================================== *
* Normaly only in appropriate business process reference documents will be used.
* Thus here should run respective checks against given header and item
* data of actual sales document as maybe sales document or item category.

  if not is_vbak-vbtyp = IF_SD_DOC_CATEGORY=>RETURNS.             "only in case of returns
* IF NOT is_vbap-pstyv = .                "only in case of special item category
* IF is_vbap-shkzg IS INITIAL.            "only in case of returns items
    return.
  endif.

* ====================================================================== *
* 2) search for existing reference documents on database
* ====================================================================== *
* select respective sales order reference document from database
  select vbeln posnr
    from v_vapma_cds
    into corresponding fields of table lt_item
    where matnr = is_vbap-matnr
      and kunnr = is_vbak-kunnr.

* Also a reference to a billing document is posible
* Therefore you can use a select on table VRPMA respectively

* ====================================================================== *
* 3) search for reference documents already archived
* ====================================================================== *
* Condition for additional search for reference documents already archived

* set flag according to read from archiv
  lv_read_archiv = 'X'.

  if lv_read_archiv is not initial.
    call method cl_sd_archived_sales_documents=>get_archived_sales_docs
      exporting
        iv_kunnr               = is_vbak-kunnr
        iv_matnr               = is_vbap-matnr
*       iv_bstnk               =
*       iv_auart               =
*       iv_vbtyp               =
*       iv_archivekey          =
      importing
        et_archived_sales_docs = lt_arch_item.
  endif.

* ====================================================================== *
* 4) Check result
* ====================================================================== *
* Check result table for appropriate reference document to use as reference
* for actual to create new customer order item
* Remark: Only one single reference document item can be exported to use
* as found reference for actual sales order item.

* Within this example no multireferencing is handled.
* In case of several underlying sales orders as reference with minor quantity
* only one reference order can be selected here as reference for new order item.
* In case that the now to create order item has a higher quantity as a single
* appropriate reference this can be manually split into several to create
* order items with respective quantity and with respective reference order
* for each order item.


* ====================================================================== *
* 5) Message Handling
* ====================================================================== *
* message handling Info, Warning, Error

* Reference to a billing document item ?
* Only complete reference regarding quantity is possible!
* In this case an info message might be useful.
* -> e. g. "Check and/or change the quantity in the target document"

* ====================================================================== *
* 6) Return data
* ====================================================================== *
* please fill ct_hnw_vbap with lines of lt_arch_item at your convenience

* if you add one or more items in the empty hnw_vbap
  if lt_item is not initial and ct_hnw_vbap is initial.
    cv_answer = '2'.
  endif.
* if you add one or more items in the already filled hnw_vbap
  if lt_item is not initial and ct_hnw_vbap is not initial.
    cv_answer         = '2'.
    cv_ang_item_exist = ' '.
    cv_kon_item_exist = ' '.
  endif.

* Reference to a billing document item ?
* Refresh ct_hnw_vbap (if already filled)
* clear cv_ang_item_exist and cv_kon_item_exist and
* set cv_rec_item_exist = 'X'

  loop at lt_item into ls_item.
    append ls_item to ct_hnw_vbap.
  endloop.

* fill 'hnw_vbap' header line with the first table element
  read table ct_hnw_vbap index 1
    into cs_hnw_vbap.

endmethod.
ENDCLASS.
