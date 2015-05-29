WBVardef today=@"select to_char(current_date,'mmddyyyy')";
WBExport -type=text
                 -file='c:/shoutbomb/Renewals/renew$[today].txt'
                 -delimiter='|'
                 -quotechar='"'
                 -quoteCharEscaping=escape
                 -lineEnding=crlf
                 -encoding=utf8;
                 
SELECT
     'p' || rmp.record_num || 'a'                                   AS patron_no,
     replace(ib.field_content,' ','')                               AS item_barcode,
     trim(regexp_replace(s.content, '(:|/|\.|\||\")', '', 'g'))     AS title,
     to_char(c.due_gmt,'MM-DD-YYYY')                                AS due_date,
     'i' || rmi.record_num || 'a'                                   AS item_no,
     round(p.owed_amt,2)                                            AS money_owed,
     c.loanrule_code_num                                            AS loan_rule,
     nullif (count(ih.id),0)                                        AS item_holds,
     nullif (count(bh.id),0)                                        AS bib_holds,
     c.renewal_count                                                AS renewals,
     'b' || rmb.record_num || 'a'                                   AS bib_no
     
         
  FROM sierra_view.checkout AS c
     RIGHT JOIN sierra_view.patron_record AS p
       ON ( p.id = c.patron_record_id )
     JOIN sierra_view.record_metadata AS rmp
       ON (rmp.id = c.patron_record_id AND rmp.record_type_code = 'p')
     JOIN sierra_view.item_record AS i
        ON ( i.id = c.item_record_id )
     JOIN sierra_view.record_metadata AS rmi    
        ON ( rmi.id = i.id AND rmi.record_type_code = 'i')
     JOIN sierra_view.varfield AS ib
      ON ( ib.record_id = i.id AND ib.varfield_type_code = 'b')
     JOIN sierra_view.bib_record_item_record_link AS bil
       ON ( bil.item_record_id = i.id)
     JOIN sierra_view.bib_record AS b
       ON ( b.id = bil.bib_record_id )
     JOIN sierra_view.subfield AS s
       ON ( s.record_id = b.id AND s.marc_tag='245' AND s.tag = 'a')
     LEFT JOIN sierra_view.hold as bh
       ON (bh.record_id = b.id) 
     LEFT JOIN sierra_view.hold as ih
       ON (ih.record_id = i.id and ih.status = '0')         
     LEFT JOIN sierra_view.record_metadata as rmb
       ON ( rmb.id = b.id AND rmb.record_type_code = 'b')
       
  WHERE
    (c.due_gmt::date - current_date) = 3

  GROUP BY 1,2,3,4,5,6,7,10,11

  ORDER BY
      patron_no;
