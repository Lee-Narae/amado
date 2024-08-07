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

update tbl_matchingreg set status = 0;
commit;

select * from tbl_clubmember order by 1,2;
update tbl_clubmember set clubseq=15 where fk_userid = 'ksj1024sj' and clubseq=29;
delete from tbl_clubmember where fk_userid = 'ksj1024sj' and clubseq in(15,2);
commit;
select * from tbl_club;

select * from tbl_matching;
desc tbl_matching;
delete from tbl_matching where matchingseq = 19;
commit;

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(SEQ_MATCHING.nextval, #{matchingregseq}, #{clubseq1}, #{clubseq2}, 0, 0, 0, 0);

select * from tbl_matchingreg;
select * from tbl_matching;

select A.matchingseq, A.matchingregseq, A.clubseq1, A.clubseq2, B.sportseq, to_char(B.matchdate, 'yyyy-mm-dd hh24:mi') matchdate, B.city, B.local, B.status
from tbl_matching A join tbl_matchingreg B
on A.matchingregseq = B.matchingregseq;

select * from seoul_bicycle_rental;

create table tbl_watch  -- 테이블 명
--  (watchname varchar2(10)             -- 컬럼 명 // 최대 10 bytes 문자열 허용 -> 쌍용교육센터 X(12 bytes)
    (watchname Nvarchar2(10),           -- Nvarchar2: 최대 10글자까지 허용 -> 쌍용교육센터 O (6 글자)
     bigo Nvarchar2(100));

create sequence opendata_gymseq
    start with 1    -- 첫번째 출발은 1 부터 한다. 
    increment by 1  -- 증가치는 1 이다. 즉, 1씩 증가한다. 
    nomaxvalue      -- 최대값은 없는 무제한. 계속 증가시키겠다는 말이다. 
    nominvalue      -- 최소값이 없다.
    nocycle         -- 반복을 안한다.
    nocache;



create table tbl_opendata_gym
(opendata_gymseq number,
 name nvarchar2(50),
 type nvarchar2(50),
 status nvarchar2(50),
 postcode nvarchar2(50),
 oldAdd nvarchar2(50),
 newAdd nvarchar2(50),
 city nvarchar2(50));

 -- SUBSTR("문자열", "시작위치", "길이")


select * from tbl_opendata_gym;

select A.city, 구, name
from
(select substr(oldadd,instr(oldadd, ' ', 1, 1)+1,instr(oldadd, ' ', 1, 2)-1-instr(oldadd, ' ', 1, 1)) 구, name, city
from tbl_opendata_gym) A join (select city
                               from tbl_opendata_gym
                               group by city) B
on A.city = B.city
order by 1, 2;

select 구, count(*) cnt
from
(select city, substr(oldadd,instr(oldadd, ' ', 1, 1)+1,instr(oldadd, ' ', 1, 2)-1-instr(oldadd, ' ', 1, 1)) 구
from tbl_opendata_gym) A join (select city
                               from tbl_opendata_gym
                               group by city) B
on A.city = B.city
where A.city = '경기도'
group by A.city, 구
order by 1, 2;


select substr(oldadd,instr(oldadd, ' ', 1, 1)+1,instr(oldadd, ' ', 1, 2)-1-instr(oldadd, ' ', 1, 1)) 구, count(*) cnt
from tbl_opendata_gym
where city = '경기도'
group by city, substr(oldadd,instr(oldadd, ' ', 1, 1)+1,instr(oldadd, ' ', 1, 2)-1-instr(oldadd, ' ', 1, 1))
order by 1, 2;

desc tbl_opendata_gym;

select opendata_gymseq, name, type, status, newadd, city
from tbl_opendata_gym;

select rn, userid, name, email, gender, memberrank
		from
		(select rownum rn, userid, name, email, gender, memberrank
		from
		(select userid, name, email, gender, case memberrank when 0 then '일반회원' when 1 then '동호회장' else '관리자' end memberrank
		from tbl_member
		where 1=1
		<if test="searchType == 'name' and searchWord != ''">and name like '%'||#{searchWord}||'%'</if>
		<if test="searchType == 'userid' and searchWord != ''">and userid like '%'||#{searchWord}||'%'</if>
		<if test="searchType == 'email' and searchWord != ''">and email like '%'||#{searchWord}||'%'</if>
		order by registerday desc)
		)
		where rn between to_number(#{currentShowPageNo})*to_number(#{sizePerPage})-(to_number(#{sizePerPage})-1) and to_number(#{currentShowPageNo})*to_number(#{sizePerPage});
        
select rn, name, type, status, newadd, city
from
(select rownum rn, name, type, status, newadd, city
from     
(select distinct  name, newadd,type, status, city
from tbl_opendata_gym
order by city, newadd));
        
select * from tbl_matching;

select matchingseq, C.clubname myteam, D.clubname, to_char(B.matchdate, 'yyyy-mm-dd hh24:mi') matchdate
from tbl_matching A join tbl_matchingreg B
on A.matchingregseq = B.matchingregseq
join tbl_club C
on B.clubseq = C.clubseq
join tbl_club D
on A.clubseq2 = D.clubseq
join tbl_member E
on C.fk_userid = E.userid
where E.userid = 'leejy' and A.result1 = 0;

select * from tbl_club;
select * from tbl_member;
select * from tbl_matchingreg;
select * from tbl_matchingapply;
select * from tbl_matching;

update tbl_club set fk_userid = 'test4' where clubseq = 3;
commit;

select * from tbl_clubmember;

insert into tbl_clubmember (fk_userid, sportseq, clubseq, status) values('test4', 1, 3, 1);
update tbl_member set memberrank = 1 where userid = 'test4';


select A.matchingseq, A.matchingregseq, E.sportname, C.clubname teamA, D.clubname teamB,
			   to_char(B.matchdate, 'yyyy-mm-dd hh24:mi') matchdate, B.area, B.status
		from tbl_matching A join tbl_matchingreg B
		on A.matchingregseq = B.matchingregseq
		join tbl_club C
		on A.clubseq1 = C.clubseq
		join tbl_club D
		on A.clubseq2 = D.clubseq
		join tbl_sport E
		on B.sportseq = E.sportseq
		where B.status = 1 and B.matchdate >= sysdate and (A.clubseq1 = 2 or A.clubseq2 = 2);


select matchdate, clubseq, area
from
(select *
from tbl_matchingreg A join tbl_matchingapply B
on A.matchingregseq = B.matchingregseq
where B.status = 1);


select C.clubname regteam, D.clubname appteam, to_char(A.matchdate, 'yyyy-mm-dd hh24:mi') matchdate, A.area
from tbl_matchingreg A join tbl_matchingapply B
on A.matchingregseq = B.matchingregseq
join tbl_club C
on A.clubseq = C.clubseq
join tbl_club D
on B.clubseq =  D.clubseq
join tbl_member E
on C.fk_userid = E.userid
join tbl_member F
on D.fk_userid = F.userid
where B.status = 1 and (C.clubseq=2 or D.clubseq=2);

select * from tbl_matchingapply;
select * from tbl_club;

select matchingseq, C.clubname myteam, D.clubname, to_char(B.matchdate, 'yyyy-mm-dd hh24:mi') matchdate, area
		from tbl_matching A join tbl_matchingreg B
		on A.matchingregseq = B.matchingregseq
		join tbl_club C
		on B.clubseq = C.clubseq
		join tbl_club D
		on A.clubseq2 = D.clubseq
		join tbl_member E
		on C.fk_userid = E.userid
		where E.userid = 'leejy' and A.result1 = 0;
        
        
select * from tbl_matching;
select * from tbl_club;

desc tbl_member;

select * from tbl_member;
update tbl_member set status = 1;
commit;
select count(*) from tbl_member where userid = 'leenr' and password = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382';


Desc tbl_club;

select sportseq, A.clubseq, clubname, clubimg, clubtel, city, local, clubgym, clubtime
from tbl_clubmember A join tbl_club B
on A.clubseq = B.clubseq
where A.fk_userid = 'ksj1024sj' and sportseq = 1;

select * from tbl_sport;
select * from tbl_clubmember;

update tbl_clubmember set status = 1 where fk_userid = 'leenr' and clubseq = 15;
commit;


desc tbl_club;

select fk_userid, memberrank from tbl_club A join tbl_member B on A.fk_userid = B.userid;

select clubseq, clubname, clubimg, sportname, fk_userid, clubtel, city, local, clubgym, clubtime, membercount, clubpay, clubstatus, clubscore, wasfilename, viewcount from tbl_club A join tbl_sport B on A.fk_sportseq = B.sportseq where clubstatus = 1 and fk_userid = 'leejy';


select count(*) from tbl_club where clubseq = 5 and fk_userid = 'leejy';

select * from tbl_clubmember order by 1, 2;

insert into tbl_clubmember(fk_userid, sportseq, clubseq, status) values ('leejy', 7, 8, 1);
commit;

select * from tbl_city order by to_number(cityseq);
select * from tbl_club;
select * from tbl_clubmember;

update tbl_city set cityname = '' where cityseq = '16';
commit;

alter table tbl_city modify cityname nvarchar2(10);

select * from tbl_noticecomment;
select * from tbl_notice;
update tbl_notice set commentcount = 0;
commit;

select * from tbl_club;

insert into tbl_clubmember(fk_userid, sportseq, clubseq, status) values('test20', 1, 3, 1);
commit;

select userid, name, email, mobile, gender
from tbl_clubmember A join tbl_member B
on A.fk_userid = B.userid
where A.clubseq = 3;

select * from tbl_clubmember;

select rn, userid, name, email, mobile, gender
from
(select rownum rn, userid, name, email, mobile, gender
from
(select userid, name, email, mobile, gender
from tbl_clubmember A join tbl_member B
on A.fk_userid = B.userid
where A.clubseq = 3))
where rn between 1 and 7;

select * from tbl_club;

select sportname, count(*) cnt
		from tbl_club A right join tbl_sport B
		on A.fk_sportseq = B.sportseq
		group by B.sportname;

select sportname, count(clubname) cnt
from tbl_club A right join tbl_sport B
on A.fk_sportseq = B.sportseq
group by B.sportname;

select * from tbl_matching;


select matchingseq, C.clubname myteam, D.clubname, to_char(B.matchdate, 'yyyy-mm-dd hh24:mi') matchdate, area
		from tbl_matching A join tbl_matchingreg B
		on A.matchingregseq = B.matchingregseq
		join tbl_club C
		on B.clubseq = C.clubseq
		join tbl_club D
		on A.clubseq2 = D.clubseq
		join tbl_member E
		on C.fk_userid = E.userid
		where E.userid = 'test3' and A.result1 = 0;

select * from tbl_clubmember;



select C.clubname regteam, D.clubname appteam, to_char(A.matchdate, 'yyyy-mm-dd hh24:mi') matchdate, A.area
		from tbl_matchingreg A join tbl_matchingapply B
		on A.matchingregseq = B.matchingregseq
		join tbl_club C
		on A.clubseq = C.clubseq
		join tbl_club D
		on B.clubseq =  D.clubseq
		join tbl_member E
		on C.fk_userid = E.userid
		join tbl_member F
		on D.fk_userid = F.userid
		where B.status = 1 and (C.clubseq=29 or D.clubseq=29)
        order by 3;


select clubboardseq, clubseq, title, fk_userid, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') registerdate, commentcount, viewcount
		from TBL_CLUBBOARD where clubseq = 2 and registerdate > sysdate-7
		order by 5 desc;

select case when length(title) > 20 then substr(title, 0, 20)||'...' else title end title from tbl_notice;

select * from tbl_notice;

select * from tbl_gymres;

select * from tbl_club where fk_userid = 'leejy';


select A.clubseq, A.clubname, B.fk_userid from tbl_club A join tbl_clubmember B 
on A.clubseq = B.clubseq
where A.fk_userid = 'leejy' and B.status = 0
order by 1;

ALTER TABLE TBL_CLUB DROP constraint FK_TBL_CLUB_SPORTSEQ;
select * from TBL_GYMANSWER;
select * from user_constraints;
select * from TBL_CLUB;
select * from user_constraints where constraint_type = 'R' and delete_rule = 'NO ACTION';
alter table TBL_CLUB add constraint FK_TBL_CLUB_SPORTSEQ foreign key(fk_sportseq) references tbl_sport(sportseq) on delete cascade;


select A.clubseq, A.clubname, B.fk_userid, C.name from tbl_club A join tbl_clubmember B 
		on A.clubseq = B.clubseq
        join tbl_member C
        on B.fk_userid = C.userid
		where A.fk_userid = 'leejy' and B.status = 0
		order by 1;
        
select * from tbl_clubmember;
select * from tbl_club;

desc tbl_calendar_small_category;


select * from tbl_clubmember where status = 0;
select * from tbl_matching;

update tbl_matching set result1 = 0, result2 = 0, score1 = 0, score2 = 0
where matchingseq = 25;
commit;

select * from tbl_calendar_small_category;

select * from tbl_gym;

select * from tbl_clubmember;
delete from tbl_clubmember where fk_userid like 'test%';
insert into tbl_clubmember values('test4', 1, 3, 1);
commit;

select * from tbl_matchingreg order by 2, 5;
delete from tbl_matchingreg where matchingregseq in (17, 16, 10);
commit;

select * from tbl_member where userid = 'leenr';
update tbl_member set memberrank = 2 where userid = 'leenr';
commit;


select * from tbl_club where fk_userid in ('amado11', 'amado12', 'amado13');
update tbl_club set clubname = 'FC 허수아비' where clubseq = 89;
commit;

delete from tbl_member where userid like 'amado%';
commit;
desc tbl_notice;
select * from tbl_notice;
update tbl_gym set status = 1;
delete from tbl_club where clubseq = 112;
commit;
select * from user_sequences;
/*
begin
    for i in 1..100 loop
        insert into tbl_notice(noticeseq, title, content, registerdate, viewcount, status, commentcount)
        values(SEQ_NOTICE.nextval, '공지'||i, '공지사항입니다.', sysdate, 0, 1, 0);
    end loop;
end;
*/
commit;


ALTER TABLE tbl_notice ADD (ex_content nvarchar2(000));
UPDATE tbl_notice SET ex_content = content;
UPDATE tbl_notice SET CONTENT = NULL;
ALTER TABLE tbl_notice DROP COLUMN content;
ALTER TABLE tbl_notice RENAME COLUMN ex_content TO content;


desc tbl_notice;
select * from tbl_notice;
update tbl_notice set status = 0;
commit;

select previousseq, previoustitle, noticeseq, title, content, registerdate, viewcount, orgfilename, filename, filesize, nextseq, nexttitle
		from 
		(
		select lag(noticeseq, 1) over(order by noticeseq desc) previousseq,
		       lag(title, 1) over(order by noticeseq desc) previoustitle,
		       noticeseq, title, content, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') registerdate, viewcount, orgfilename, filename, filesize,
		       lead(noticeseq, 1) over(order by noticeseq desc) nextseq,
		       lead(title, 1) over(order by noticeseq desc) nexttitle
		from tbl_notice
		where status = 0
		<if test="searchType == 'title' and searchWord != ''">and title like '%'||#{searchWord}||'%'</if>
		<if test="searchType == 'content' and searchWord != ''">and content like '%'||#{searchWord}||'%'</if>
		) A
		where A.noticeseq = #{noticeseq};
        
        
select distinct to_char(case when length(content) > 10 then substr(content, 0, 10)||'...' else content end) content
from tbl_notice
where status = 0
and DBMS_LOB.INSTR(content, '공지')>0;


