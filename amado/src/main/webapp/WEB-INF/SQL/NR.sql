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
        
select title, content, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') registerdate, viewcount, orgfilename, filename, filesize
from tbl_notice
where status = 0 and noticeseq = 102;

select * from tab;

create table tbl_noticecomment    
(noticecommentseq          NUMBER                                   -- 댓글번호(PK)
,parentseq                NUMBER                                   -- 게시판번호(FK)
,comment_text             nvarchar2(200)                           -- 댓글내용(시)
,registerdate             DATE DEFAULT SYSDATE NOT NULL            -- 댓글작성일자
,fk_userid                nvarchar2(20)                            -- 아이디(FK)
,status                   number(1) default 1 not null             -- 댓글 상태 1 : 작성 0 : 삭제
,constraint PK_tbl_ntcmt_ntcmtseq primary key(noticecommentseq)
,constraint FK_tbl_ntcmt_ntcmtseq foreign key(parentseq) references tbl_notice(noticeseq)
,constraint FK_tbl_ntcmt_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_ntcmt_status check( status in(0,1) )                  -- 1 : 작성 0 : 삭제
);

select count(*)
from tbl_noticecomment
where status = 1 and parentseq = 102;

create sequence seq_noticecomment
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_noticecomment(noticecommentseq, parentseq, comment_text, registerdate, fk_userid, status)
values(seq_noticecomment.nextval, 102, 'ㅋㅋㅋ이게 공지냐', default, 'test1', default);

select noticecommentseq, parentseq, comment_text, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') registerdate, fk_userid, memberimg
from tbl_noticecomment A join tbl_member B
on A.fk_userid = B.userid
where A.status = 1 and parentseq = 102;


select * from tbl_notice;

alter table tbl_notice add commentcount number default 0;
update tbl_notice set commentcount = 4 where noticeseq = 102;
commit;

update tbl_notice set 
		title = '첨부파일 테스트 수정',
		content = '테스트중 수정',
		registerdate = sysdate 
        where noticeseq = 104;
        
        
rollback;


ALTER TABLE tbl_notice MODIFY orgfilename nvarchar2(100);

desc tbl_noticecomment;

select * from tbl_noticecomment;
delete from tbl_noticecomment;
commit;

select * from tbl_notice;
update tbl_notice set commentcount = 4 where noticeseq = 103;
commit;


alter table tbl_matchingapply add status number(1) default 0;

select * from tbl_matchingapply;

select * from tbl_matchingreg;

select * from user_constraints
where table_name = 'TBL_MEMBER';

desc tbl_gym;


select * from tbl_gym;
delete from tbl_gym;
commit;

alter table tbl_gym drop column imgfilename;
alter table tbl_gym add filesize number;

insert into tbl_gym(gymseq, gymname, fk_userid, postcode, address, detailaddress, status, info, cost, caution, membercount, likecount, insidestatus, orgfilename, filename, filesize)
values (SEQ_GYM.nextval, '서면체육관', 'leess', '10111', '부산시 가나다구', '가나다동', 0, '좋은 체육관입니다.', '120000', '대관 시간을 잘 지켜주세요', 50, 0, 1, 'casual-life-3d-pink-basketball.png', '234234234893.png', '1233');
commit;

update tbl_gym set status = 0;
commit;

select * from tbl_member;

insert into tbl_clubmember(fk_userid, sportseq, clubseq)
values('leejy', 3, 4);

select * from tbl_club order by fk_sportseq;
select * from tbl_clubmember;
delete from tbl_club where clubseq = 24;

alter table tbl_clubmember
add constraint FK_TBL_CLUBMEMBER_FK_USERID
foreign key (fk_userid)
references tbl_member(userid)
on delete cascade;

select * from user_constraints where constraint_type = 'R' order by table_name;

alter table tbl_clubmember foreign key FK_TBL_CLUBMEMBER_CLUBSEQ;
alter table TBL_CLUBMEMBER drop constraint FK_TBL_CLUBMEMBER_FK_USERID;

select * from TBL_CATEGORY;

purge recyclebin;

 select A.table_name, A.constraint_name, A.delete_rule, A.constraint_type, A.search_condition, 
           B.column_name, B.position
    from user_constraints A join user_cons_columns B 
    on A.constraint_name = B.constraint_name
    where constraint_type = 'R'
    order by 1;
    
desc TBL_MATCHINGAPPLY;

alter table 테이블명 add constraint 제약조건명 foreign key(컬럼명) references 부모테이블명(식별자컬럼명) on delete cascade;

alter table TBL_NOTICECOMMENT drop constraint FK_TBL_NTCMT_FK_USERID;
alter table TBL_NOTICECOMMENT add constraint FK_TBL_NTCMT_FK_USERID foreign key(FK_USERID) references tbl_member(userid) on delete cascade;

select * from tbl_club order by fk_sportseq, fk_userid;

delete from tbl_club where clubseq = 23;
commit;
rollback;



select count(*) from tbl_clubmember where fk_userid ='leejy' and sportseq = 1;



select * from tbl_clubmember;
select * from tbl_club;

insert into tbl_clubmember(fk_userid, sportseq, clubseq, status) values ('test3', 8, 31, 1);
update tbl_member set memberrank = 1 where userid = 'test3';
commit;

select matchingapplyseq, B.matchingregseq, E.sportname, B.clubseq A, D.clubname "A-name", D.fk_userid, A.clubseq B, C.clubname "B-name", A.message, A.membercount, to_char(B.matchdate, 'yyyy-mm-dd hh24:mi'), B.city, B.local, B.area, B.status
from tbl_matchingapply A join tbl_matchingreg B
on A.matchingregseq = B.matchingregseq
join tbl_club C
on A.clubseq = C.clubseq
join tbl_club D
on B.clubseq = D.clubseq
join tbl_sport E
on B.sportseq = E.sportseq
where D.fk_userid = 'test3';

select *
from tbl_clubmember A join tbl_sport B
on A.sportseq = B.sportseq
join tbl_club C
on A.clubseq = C.clubseq
where A.fk_userid = 'ksj1024sj' and sportname = '배드민턴';

update tbl_clubmember set fk_userid = 'ksj1024sj' where sportseq = 8 and clubseq = 30;
commit;

select * from tbl_sport where sportname = '배드민턴';

desc tbl_matching;        


select matchingapplyseq, B.matchingregseq, E.sportname, B.clubseq Aseq, D.clubname "A-name", D.fk_userid, A.clubseq Bseq,
       C.clubname "B-name", A.message, A.membercount, to_char(B.matchdate, 'yyyy-mm-dd hh24:mi') matchdate, B.city, B.local, B.area, B.status
from tbl_matchingapply A join tbl_matchingreg B
on A.matchingregseq = B.matchingregseq
join tbl_club C
on A.clubseq = C.clubseq
join tbl_club D
on B.clubseq = D.clubseq
join tbl_sport E
on B.sportseq = E.sportseq
where A.status = 0;

select * from tbl_matchingapply;

select * from tbl_matchingreg;

update tbl_matchingapply set status = 0;
commit;
