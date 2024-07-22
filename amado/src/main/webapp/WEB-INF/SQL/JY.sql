
select *
from tbl_club





create table tbl_club    
(clubseq      NUMBER              not null        -- 동호회번호
,clubname      nvarchar2(20)       not null        -- 동호회명
,clubimg      nvarchar2(50)                       -- 대표이미지
,sportseq      NUMBER              not null        -- 종목번호(tbl_sport(sportseq) fk)
,fk_userid      nvarchar2(20)       not null        -- 회장아이디(tbl_member(userid) fk)
,clubtel      nvarchar2(50)       not null        -- 연락처
,city          nvarchar2(50)       not null        -- 지역  (시)   
,local          nvarchar2(50)       not null        -- 지역  (구) 
,clubgym      nvarchar2(20)       not null        -- 활동구장
,clubtime       nvarchar2(30)       not null        -- 운영시간
,membercount   NUMBER              not null        -- 정원  
,clubpay       NUMBER              not null        -- 회비
,clubstatus       NUMBER(1)           not null        -- 동호회상태
,clubscore       NUMBER              not null        -- 점수
,constraint PK_tbl_club_clubseq primary key(clubseq)
,constraint FK_tbl_club_sportseq foreign key(sportseq) references tbl_sport(sportseq)
,constraint FK_tbl_club_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_CLUB이(가) 생성되었습니다.


select *
from tbl_member
where userid = 'test1'

update tbl_member set memberrank = 1
where userid = 'test1'



select *
from tbl_fleamarket

select *
from tbl_club

-- 플리마켓 게시글 insert
insert into tbl_fleamarket(fleamarketseq, sportseq, city, title, content, cost, deal, fk_userid, registerdate, password, status)
values(2, 3, '인천시', '다이소에서 사와 직접 기른 방울토마토 팝니다~', '창가에서 직접 기른 유기농 도마도! 면역력을 길러줘요', 1000, '직거래', 'leejy', default, '1234', 0);
insert into tbl_fleamarket(fleamarketseq, sportseq, city, title, content, cost, deal, fk_userid, registerdate, password, commentcount, viewcount, status, imgfilename)
values(4, 7, '강원도', '강원도에서 캔 감자 분양합니다', '말을 잘 들어요', 1000, '직거래', 'leejy', default, '1234', 0, 0, default, '영학선생님.png');
insert into tbl_fleamarket(fleamarketseq, sportseq, city, local, title, content, cost, deal, fk_userid, registerdate, password, commentcount, viewcount, status, imgfilename)
values(5, 3, '경기도', '가평군', '잣막걸리 공장을 물려드립니다', '떼돈 벌 수 있는 기회는 지금뿐!', 5000000, '직거래', 'leejy', default, '1234', 0, 0, default, '가평잣.png');
commit;



-- 플리마켓 등록된 상품들 select
select *
from tbl_sport S
JOIN tbl_fleamarket F
ON S.sportseq = F.sportseq
where sportname = '축구';

alter table tbl_fleamarket add (wasfilename varchar2(100));

ALTER TABLE tbl_fleamarket MODIFY commentcount DEFAULT 0;
ALTER TABLE tbl_fleamarket MODIFY viewcount DEFAULT 0;


select * from tbl_fleamarket
order by fleamarketseq desc;

select * from user_sequences;

drop sequence SEQ_FLEAMARKET;

create sequence SEQ_FLEAMARKET 
start with 50
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

DELETE FROM tbl_fleamarket where fleamarketseq != 1;

commit

update tbl_fleamarket set imgfilename = '가평잣.png'
where fleamarketseq = 1;
commit;  


select fleamarketseq,  city, local, title, content, cost, deal, fk_userid, to_char(registerdate,'yyyy-mm-dd hh24:mi:ss') AS registerdate, commentcount, viewcount, status, imgfilename
from tbl_fleamarket;


-- 동호회등록 할 때 동호회장 소속 indert하기
select *
from tbl_clubmember;


-- insert 하기 전에 이미 동호회장으로 가입한 sportseq 가 존재한다면 가입 안되게 하기
select *
from tbl_clubmember
where fk_userid = 'leenr';

select count(*)
from tbl_clubmember
where fk_userid = #{userid} and sportseq = #{category}

select *
from tbl_board
where fk_userid = 'ksj1024sj'  ;

select *
from tbl_club;



select * 
from tbl_clubboard;

-- 종목별 동호회 게시판
select clubseq, count(*) 
from tbl_clubboard
where fk_userid = 'leejy'
group by clubseq;

insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '토마토맛토마토맛토', '먹어볼사람', 'leejy', sysdate , '1234', 0 , 0, 1);
insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 3, '토마토김치전', '만들어줄게요', 'leejy', sysdate , '1234', 0 , 0, 1);
insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 4, '여의도 가양얼큰버섯칼국수', '먹고싶어요', 'leenr', sysdate , '1234', 0 , 0, 1);

insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '11칼국슈', '무짜', 'leejy', sysdate , '1234', 0 , 0, 1);
insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '시러 칼국수!', '시러시러', 'leenr', sysdate , '1234', 0 , 0, 1);
insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '조아 칼국수!', '조아조아', 'leenr', sysdate , '1234', 0 , 0, 1);

insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '12칼국슈', '무짜', 'leenr', sysdate , '1234', 0 , 0, 1);
insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '13칼국슈', '무짜', 'leenr', sysdate , '1234', 0 , 0, 1);
insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '14칼국슈', '무짜', 'leenr', sysdate , '1234', 0 , 0, 1);
commit;

ALTER TABLE tbl_clubboard
MODIFY (registerdate DEFAULT sysdate);


<<<<<<< HEAD
select rn, clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize
from
(select rownum rn, clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize
from

(
select clubboardseq, clubseq, title, content, fk_userid, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize
from tbl_clubboard)
where clubseq = '2'
order by registerdate desc
) 

select ceil(count(*)/1)
from tbl_clubboard
where fk_userid = 'leenr'


select rn, clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize
		from
		(select rownum rn, clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize
		from
		(
		select clubboardseq, clubseq, title, content, fk_userid, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize
		from tbl_clubboard)
		where fk_userid = 'leejy'
		
		
		order by registerdate desc
		)
		where rn between to_number(1)*to_number(10)-(to_number(10)-1) and to_number(1)*to_number(10)	

desc tbl_member


select *
from tbl_member

------------- >>>>>>>> 일정관리(풀캘린더) 시작 <<<<<<<< -------------
show user;
-- USER이(가) "MYMVC_USER"입니다.


-- *** 캘린더 대분류(내캘린더, 동호회캘린더  분류) ***
create table tbl_calendar_large_category 
(lgcatgono   number(3) not null      -- 캘린더 대분류 번호
,lgcatgoname varchar2(50) not null   -- 캘린더 대분류 명
,constraint PK_tbl_calendar_large_category primary key(lgcatgono)
);
-- Table TBL_CALENDAR_LARGE_CATEGORY이(가) 생성되었습니다.

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(1, '내캘린더');

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(2, '동호회캘린더');

commit;
-- 커밋 완료.

select * 
from tbl_calendar_large_category;


-- *** 캘린더 소분류 *** 
-- (예: 내캘린더중 점심약속, 내캘린더중 저녁약속, 내캘린더중 운동, 내캘린더중 휴가, 내캘린더중 여행, 내캘린더중 출장 등등) 
-- (예: 사내캘린더중 플젝주제선정, 사내캘린더중 플젝요구사항, 사내캘린더중 DB모델링, 사내캘린더중 플젝코딩, 사내캘린더중 PPT작성, 사내캘린더중 플젝발표 등등) 
create table tbl_calendar_small_category 
(smcatgono    number(8) not null      -- 캘린더 소분류 번호
,fk_lgcatgono number(3) not null      -- 캘린더 대분류 번호
,smcatgoname  varchar2(400) not null  -- 캘린더 소분류 명
,fk_userid    NVARCHAR2(20) not null   -- 캘린더 소분류 작성자 유저아이디
,constraint PK_tbl_calendar_small_category primary key(smcatgono)
,constraint FK_small_category_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(lgcatgono) on delete cascade
,constraint FK_small_category_fk_userid foreign key(fk_userid) references tbl_member(userid)            
);
-- Table TBL_CALENDAR_SMALL_CATEGORY이(가) 생성되었습니다.


create sequence seq_smcatgono
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SMCATGONO이(가) 생성되었습니다.


select *
from tbl_calendar_small_category
order by smcatgono desc;


-- *** 캘린더 일정 *** 
create table tbl_calendar_schedule 
(scheduleno    number                 -- 일정관리 번호
,startdate     date                   -- 시작일자
,enddate       date                   -- 종료일자
,subject       varchar2(400)          -- 제목
,color         varchar2(50)           -- 색상
,place         varchar2(200)          -- 장소
,joinuser      varchar2(4000)         -- 공유자	
,content       varchar2(4000)         -- 내용	
,fk_smcatgono  number(8)              -- 캘린더 소분류 번호
,fk_lgcatgono  number(3)              -- 캘린더 대분류 번호
,fk_userid     NVARCHAR2(20) not null  -- 캘린더 일정 작성자 유저아이디
,constraint PK_schedule_scheduleno primary key(scheduleno)
,constraint FK_schedule_fk_smcatgono foreign key(fk_smcatgono) 
            references tbl_calendar_small_category(smcatgono) on delete cascade
,constraint FK_schedule_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(lgcatgono) on delete cascade	
,constraint FK_schedule_fk_userid foreign key(fk_userid) references tbl_member(userid) 
);
-- Table TBL_CALENDAR_SCHEDULE이(가) 생성되었습니다.

create sequence seq_scheduleno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SCHEDULENO이(가) 생성되었습니다.

select *
from tbl_calendar_schedule 
order by scheduleno desc;


-- 일정 상세 보기
select SD.scheduleno
     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
     , SD.subject
     , SD.color
     , nvl(SD.place,'-') as place
     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
     , nvl(SD.content,'') as content
     , SD.fk_smcatgono
     , SD.fk_lgcatgono
     , SD.fk_userid
     , M.name
     , SC.smcatgoname
from tbl_calendar_schedule SD 
JOIN tbl_member M
ON SD.fk_userid = M.userid
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
where SD.scheduleno = 21;


insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday, coin, point, registerday, lastpwdchangedate, status, idle, gradelevel)  
values('leesunsin', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이순신', '2IjrnBPpI++CfWQ7CQhjIw==', 'fCQoIgca24/q72dIoEVMzw==', '15864', '경기 군포시 오금로 15-17', '101동 202호', ' (금정동)', '1', '1995-10-04', 0, 0, default, default, default, default, default);
-- 1 행 이(가) 삽입되었습니다.

commit;

select *
from tbl_member
where name = '이순신';

------------- >>>>>>>> 일정관리(풀캘린더) 끝 <<<<<<<< -------------

