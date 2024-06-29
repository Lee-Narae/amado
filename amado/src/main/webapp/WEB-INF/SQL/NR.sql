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
