 select *
 from tbl_clubboard
 where userid ='leejy';
 
DELETE FROM tbl_clubboard WHERE fk_userid = 'leejy';


select *
from tbl_fleamarket
where status = 0 and lower('축구') like


	
    select fleamarketseq, city, local, title, content, cost, deal, fk_userid, to_char(registerdate,'yyyy-mm-dd hh24:mi:ss') AS registerdate, commentcount, viewcount, status, imgfilename, wasfilename
    from tbl_fleamarket
    where status = 0
            and lower(title) like '%' || lower('셔틀') || '%'
    order by fleamarketseq desc
