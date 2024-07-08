select * from tbl_member;

desc tbl_loginhistory;

ALTER TABLE tbl_member ADD idle number(1);



SELECT userid, name, coin, point, pwdchangegap, 
       NVL( lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap,  
       idle, email, mobile, postcode, address, detailaddress, extraaddress
     , gradelevel       
FROM 
     ( select userid, name, coin, point, 
              trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap,  
              registerday, idle, email, mobile, postcode, address, detailaddress, extraaddress
            , gradelevel   
       from tbl_member 
       where status = 1 and userid = #{userid} and pwd = #{pwd} ) M   
CROSS JOIN 
( select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap  
  from tbl_loginhistory 
  where fk_userid = #{userid} ) H;


select userid, name, email, postcode, address, detailaddress, extraaddress, mobile, gender, birthday,
       memberrank, speed, quick, power, earth, stretch, pwdchangegap, NVL( lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap
from
(select userid, password, name, email, postcode, address, detailaddress, extraaddress, mobile, gender,
       birthday, registerday, status, memberrank, gymregisterstatus, speed, quick,
       power, earth, stretch, idle, trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap
from tbl_member
where status = 1 and userid = 'leejy' and password = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382') A
cross join
(select trunc(months_between(sysdate, max(logindate))) as lastlogingap
 from tbl_loginhistory
 where fk_userid = 'leejy') B;



insert into tbl_loginhistory(loginseq, fk_userid, logindate, clientip) values (seq_loginhistory.nextval, 'leejy', sysdate, '127.0.0.1');

commit;


select * from tbl_loginhistory;

select * from tbl_club;

ALTER TABLE tbl_club RENAME COLUMN SPORTSEQ TO fk_sportseq;

desc tbl_sport;

select clubseq
from tbl_clubmember
where fk_userid = 'leenr' and sportseq = 1;

select clubseq, clubname, clubimg, fk_sportseq, fk_userid, clubtel, city, local, clubgym, clubtime, membercount, clubpay, clubstatus, clubscore, name, sportname
from tbl_club A join tbl_member B
on A.fk_userid = B.userid
join tbl_sport C
on A.fk_sportseq = C.sportseq
where clubseq = 2;

select * from tab;

select * from TBL_MATCHINGREG;

update tbl_matchingreg set matchdate = to_date('2024-07-21 13:00', 'yyyy-mm-dd hh24:mi') where matchingregseq = 7;
commit;

desc TBL_MATCHINGREG;

insert into tbl_matchingreg(matchingregseq, clubseq, sportseq, membercount, matchdate, city, local, area, status)
values(SEQ_MATCHINGREG.nextval, 2, 1, 14, to_date('2024-08-21 09:00', 'yyyy-mm-dd hh24:mi'), '충청북도', '청주시', '아라초등학교', 0);

commit;

select matchingregseq, clubname, A.membercount, substr(to_char(matchdate, 'yyyy-mm-dd hh24:mi'), 0, 10) matchdate, substr(to_char(matchdate, 'yyyy-mm-dd hh24:mi'), 12) matchtime, A.city, A.local, A.area, A.status
from tbl_matchingreg A join tbl_club B
on A.clubseq = B.clubseq;

select localname from tbl_local A join tbl_city B on A.fk_cityseq = B.cityseq where cityname = '서울시';

select matchingregseq, clubname, A.membercount,
       substr(to_char(matchdate, 'yyyy-mm-dd hh24:mi'), 0, 10) matchdate,
       substr(to_char(matchdate, 'yyyy-mm-dd hh24:mi'), 12) matchtime, A.city, A.local, A.area, A.status
from tbl_matchingreg A join tbl_club B
on A.clubseq = B.clubseq
where A.sportseq = 1
and matchdate >= sysdate
order by matchdate, matchtime;

select * from tbl_clubmember;

select A.clubseq, clubname from tbl_clubmember A join tbl_sport B
on A.sportseq = B.sportseq
join tbl_club C
on A.clubseq = C.clubseq
where A.fk_userid = 'leenr' and sportname = '축구';


select * from tbl_matchingreg;


select * from tbl_member;

update tbl_member set memberrank = 2 where userid='admin';
commit;


userid, name, email, postcode, address, detailaddress, extraaddress, mobile, gender, birthday, memberimg,
		       memberrank, speed, quick, power, earth, stretch, pwdchangegap, NVL( lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap


select userid, name, email, postcode, address, detailaddress, extraaddress, mobile, gender, birthday
from tbl_member
where userid = 'leenr' and password = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382' and memberrank = 2;

select rn, userid, name, email, gender, memberrank
from
(select rownum rn, userid, name, email, gender, memberrank
from
(select userid, name, email, gender, case memberrank when 0 then '일반회원' when 1 then '동호회장' else '관리자' end memberrank
from tbl_member
where userid = 'leenr'
order by registerday desc)
)
where rn between 1 and 10;

desc tbl_member;

select * from tbl_loginhistory
order by logindate;

insert into tbl_loginhistory(loginseq, fk_userid, logindate, clientip) values (SEQ_LOGINHISTORY.nextval, 'leenr', sysdate-30, '127.0.0.1');

commit;

select to_char(sysdate, 'yyyy-mm-dd')
from dual;

select count(*)
from tbl_loginhistory
where logindate = '24/06/05';

select noticeseq, title, content, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') registerdate, viewcount, status, orgfilename, filename, filesize from tbl_notice;

desc tbl_notice;        
        
select * from tbl_notice
order by registerdate desc;

