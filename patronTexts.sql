WBVardef today=@"Select to_char(current_date,'mmddyyyy')";
WBExport -type=text
                 -file='c:/shoutbomb/Text/text$[today].txt'
                 -delimiter='|'
				 				 -quotechar='"'
				 				 -quoteCharEscaping=escape
                 -lineEnding=crlf
                 -encoding='ISO-8859-1';                 

SELECT
    regexp_replace(r.phone_number, '[- \.]', '', 'g'), v.barcode, iii_language_pref_code 
  FROM sierra_view.patron_view v 
    JOIN sierra_view.patron_record_phone r 
      ON v.id = r.patron_record_id 
    JOIN sierra_view.patron_record_phone_type ty 
      ON r.patron_record_phone_type_id = ty.id
  WHERE ty.code = 'p' 
  --p is field tag for the telephone2 var field
  --AND v.notification_medium_code = 't' 
  AND expiration_date_gmt > current_date;
