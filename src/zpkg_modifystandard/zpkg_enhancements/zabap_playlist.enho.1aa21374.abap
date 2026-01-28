"Name: \PR:SAPMV45A\FO:USEREXIT_MOVE_FIELD_TO_VBAK\SE:BEGIN\EI
ENHANCEMENT 0 ZABAP_PLAYLIST.
**HOW TO USE MODIFY VBAK-LIFSK WITH A USER EXIT - TCODE VA01 EXAMPLE
*  IF vbak-vbeln IS INITIAL AND SY-ucomm = 'SICH' AND KUAGV-kunnr = '1000272'.
*    VBAK-LIFSK = '01'.
*  ENDIF.

*  vbak-zzfield = xxxx-zzfield2.
"$$
"$$
  IF  zz_gs_info IS INITIAL AND vbak-kunnr IS NOT INITIAL.
"$$
"$$
"$$
    DATA id_valor_liquido LIKE  zz_gs_info-total.
    DATA id_impostos      LIKE  zz_gs_info-total.

    SELECT SINGLE COUNT(*) INTO zz_gs_info-qtde FROM vbak
      WHERE kunnr = vbak-kunnr.

    SELECT SINGLE SUM( t1~netwr ) SUM( t1~mwsbp ) INTO (id_valor_liquido, id_impostos)
  FROM vbap AS t1
  JOIN  vbak AS t2
  ON t1~vbeln = t2~vbeln
  WHERE t2~kunnr = vbak-kunnr.

*   SELECT SINGLE SUM( t1~netwr ) INTO (id_valor_liquido)
*       FROM vbap AS t1
*      JOIN  vbak AS t2 ON t1~vbeln = t2~vbeln
*    WHERE t2~kunnr = vbak-kunnr.
*
*    SELECT SINGLE SUM( t1~mwsbp ) INTO ( id_impostos )
*      FROM vbap AS t1
*      JOIN  vbak AS t2
*      ON t1~vbeln = t2~vbeln
*      WHERE t2~kunnr = vbak-kunnr.

    zz_gs_info-total = id_valor_liquido + id_impostos.

  ENDIF.

ENDENHANCEMENT.
