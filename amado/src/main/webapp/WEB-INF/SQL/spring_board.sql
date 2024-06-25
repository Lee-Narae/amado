
------ ***** spring 기초 ***** ------

show user;
-- USER이(가) "MYMVC_USER"입니다.

create table spring_test
(no         number
,name       varchar2(100)
,writeday   date default sysdate
);
-- Table SPRING_TEST이(가) 생성되었습니다.

select *
from spring_test;

desc spring_test;




--------------------------------------------------------



show user;
-- USER이(가) "HR"입니다.

create table spring_exam
(no         number
,name       varchar2(100)
,address    Nvarchar2(100)
,writeday   date default sysdate
);
-- Table SPRING_EXAM이(가) 생성되었습니다.

select *
from spring_exam;



--------------------------------------------------------


show user;
-- USER이(가) "MYMVC_USER"입니다.

insert into spring_test(no, name, writeday)
values(102, '박보영', default);

insert into spring_test(no, name, writeday)
values(102, '변우석', default);

commit;


select *
from spring_test
order by no asc;


select no, name, to_char(writeday, 'yyyy-mm-dd hh24:mi:ss') AS writeday
from spring_test
order by no asc




--------------------------------------------------------------------------------


show user;
-- USER이(가) "MYMVC_USER"입니다.

create table tbl_main_image_product
(imgno           number not null
,productname     Nvarchar2(20) not null
,imgfilename     varchar2(100) not null
,constraint PK_tbl_main_image_product primary key(imgno)
);
-- Table TBL_MAIN_IMAGE_PRODUCT이(가) 생성되었습니다.

create sequence seq_main_image_product
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_MAIN_IMAGE_product이(가) 생성되었습니다.

insert into tbl_main_image_product(imgno, productname, imgfilename) values(seq_main_image_product.nextval, '미샤', '미샤.png');  
insert into tbl_main_image_product(imgno, productname, imgfilename) values(seq_main_image_product.nextval, '원더플레이스', '원더플레이스.png'); 
insert into tbl_main_image_product(imgno, productname, imgfilename) values(seq_main_image_product.nextval, '레노보', '레노보.png'); 
insert into tbl_main_image_product(imgno, productname, imgfilename) values(seq_main_image_product.nextval, '동원', '동원.png'); 

commit;
-- 커밋 완료.

select imgno, productname, imgfilename
from tbl_main_image_product
order by imgno asc;

select *
from tbl_member
where userid = 'ksj1024sj' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382';





		select USERID, PWD, NAME, EMAIL, MOBILE, 
			   POSTCODE, ADDRESS, DETAILADDRESS, EXTRAADDRESS, 
			   GENDER, BIRTHDAY, COIN, POINT, REGISTERDAY, LASTPWDCHANGEDATE, STATUS, IDLE
		from tbl_member
		where STATUS = 1 and userid = 'ksj1024sj' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'




SELECT userid, name, coin, point, pwdchangegap, 
       NVL( lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap, 
       idle, 
       email, mobile, 
       postcode, address, detailaddress, extraaddress 
FROM 
( select userid, name, coin, point, 
        trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap, 
        registerday, idle, 
        email, mobile, 
        postcode, address, detailaddress, extraaddress 
from tbl_member 
where status = 1 and userid = 'eomjh' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382' ) M 
CROSS JOIN 
( select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap 
from tbl_loginhistory 
where fk_userid = 'eomjh' ) H 




select USERID, LASTPWDCHANGEDATE, status, idle
from tbl_member
where userid in ('ksj1024sj', 'eomjh', 'leess')


select *
from tbl_loginhistory
order by historyno desc;



update tbl_member  set idle = 1
where userid = 'leess' ;







    ------- **** spring 게시판(답변글쓰기가 없고, 파일첨부도 없는) 글쓰기 **** -------

show user;
-- USER이(가) "MYMVC_USER"입니다.    
    
    
desc tbl_member;

create table tbl_board
(seq         number                not null    -- 글번호
,fk_userid   varchar2(20)          not null    -- 사용자ID
,name        varchar2(20)          not null    -- 글쓴이 
,subject     Nvarchar2(200)        not null    -- 글제목
,content     Nvarchar2(2000)       not null    -- 글내용   -- clob (최대 4GB까지 허용) 
,pw          varchar2(20)          not null    -- 글암호
,readCount   number default 0      not null    -- 글조회수
,regDate     date default sysdate  not null    -- 글쓴시간
,status      number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,constraint PK_tbl_board_seq primary key(seq)
,constraint FK_tbl_board_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_board_status check( status in(0,1) )
);
-- Table TBL_BOARD이(가) 생성되었습니다.

create sequence boardSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



select *
from tbl_board
order by seq desc;

select *
from tbl_loginhistory
order by historyno desc;

-- 지금 ip 버젼 6 으로 나오기 때문에 4로 변환시켜준다. (JSP 파일을 실행시켰을 때 IP 주소가 제대로 출력되기위한 방법.txt) 에 설명되어있다.




select seq, fk_userid, name, subject
     , readCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate
from tbl_board
where status = 1
order by seq desc;






		select seq, fk_userid, name, subject, content, pw
		     , readCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, status
		from tbl_board
		where status = 1
		order by seq desc




select historyno, fk_userid, to_char(Logindate, 'yyyy-mm-dd hh24:mi:ss') as logindate, clientip
from tbl_loginhistory
order by historyno desc;


select *
from tbl_board



   select previousseq, previoussubject, seq, fk_userid, name, subject, content, readCount, regDate, pw, nextseq, nextsubject
    FROM
    (
        select lag (seq, 1) over(order by seq desc) AS previousseq
             , lag (subject, 1) over(order by seq desc)  AS previoussubject
             , seq, fk_userid, name, subject, content, readCount
             , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, pw
             , lead (seq, 1) over(order by seq desc) AS nextseq
             , lead (subject, 1) over(order by seq desc) AS nextsubject
        from tbl_board
        where status = 1
    ) V
    WHERE V.seq = 1;
 






-----------------------------------------------------------------------------

   ----- **** 댓글 게시판 **** -----

/* 
  댓글쓰기(tbl_comment 테이블)를 성공하면 원게시물(tbl_board 테이블)에
  댓글의 갯수(1씩 증가)를 알려주는 컬럼 commentCount 을 추가하겠다. 
*/
drop table tbl_board purge;
-- Table TBL_BOARD이(가) 삭제되었습니다.

create table tbl_board
(seq           number                not null    -- 글번호
,fk_userid     varchar2(20)          not null    -- 사용자ID
,name          varchar2(20)          not null    -- 글쓴이 
,subject       Nvarchar2(200)        not null    -- 글제목
,content       Nvarchar2(2000)       not null    -- 글내용   -- clob (최대 4GB까지 허용) 
,pw            varchar2(20)          not null    -- 글암호
,readCount     number default 0      not null    -- 글조회수
,regDate       date default sysdate  not null    -- 글쓴시간
,status        number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,commentCount  number default 0      not null    -- 댓글의 개수
,constraint PK_tbl_board_seq primary key(seq)
,constraint FK_tbl_board_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_board_status check( status in(0,1) )
);
-- Table TBL_BOARD이(가) 생성되었습니다.


drop sequence boardSeq;
-- Sequence BOARDSEQ이(가) 삭제되었습니다.

create sequence boardSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence BOARDSEQ이(가) 생성되었습니다.    




----- **** 댓글 테이블 생성 **** -----
create table tbl_comment
(seq           number               not null   -- 댓글번호
,fk_userid     varchar2(20)         not null   -- 사용자ID
,name          varchar2(20)         not null   -- 성명
,content       varchar2(1000)       not null   -- 댓글내용
,regDate       date default sysdate not null   -- 작성일자
,parentSeq     number               not null   -- 원게시물 글번호
,status        number(1) default 1  not null   -- 글삭제여부
                                               -- 1 : 사용가능한 글,  0 : 삭제된 글
                                               -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_tbl_comment_seq primary key(seq)
,constraint FK_tbl_comment_userid foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_comment_parentSeq foreign key(parentSeq) references tbl_board(seq) on delete cascade
,constraint CK_tbl_comment_status check( status in(1,0) ) 
);
-- Table TBL_COMMENT이(가) 생성되었습니다.

create sequence commentSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence COMMENTSEQ이(가) 생성되었습니다.

select seq, fk_userid, name, content, regdate, parentseq, status
from tbl_comment
where seq = 28;

select *
from tbl_board
order by seq desc;



select point
from tbl_member
where userid = 'ksj1024sj'



-- ==== Transaction 처리를 위한 시나리오 만들기 ==== --
---- 회원들이 게시판에 글쓰기를 하면 글작성 1건당 POINT 를 100점을 준다.
---- 회원들이 게시판에서 댓글쓰기를 하면 댓글작성 1건당 POINT 를 50점을 준다.
---- 그런데 데이터베이스 오류 발생시 스프링에서 롤백해주는 Transaction 처리를 알아보려고 일부러 POINT 는 300을 초과할 수 없다고 하겠다.

select point
from tbl_member
where userid = 'eomjh';


select COMMENTCOUNT
from tbl_board
order by seq desc;

select *
from tbl_board
order by seq desc;


		select seq, fk_userid, name, subject, content, subject||content AS subject_content, pw
		     , readCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, status, commentcount
		from tbl_board
		where status = 1 
		order by seq desc



update tbl_member set point = 100
where userid = 'ksj1024sj';


commit;



-- tbl_member 테이블에 point 컬럼에 check 제약을 추가한다.
alter table tbl_member
add constraint CK_tbl_member_point check( point between 0 and 300 );
-- Table TBL_MEMBER이(가) 변경되었습니다.

update tbl_member set point = 301
where userid = 'ksj1024sj';
/*
    오류 보고 -
    ORA-02290: 체크 제약조건(MYMVC_USER.CK_TBL_MEMBER_POINT)이 위배되었습니다
*/


update tbl_member set point = 300
where userid = 'ksj1024sj';
-- 1 행 이(가) 업데이트되었습니다.

rollback;
-- 롤백 완료.


select seq, fk_userid, name, content, to_char(regdate, 'yyyy-mm-dd hh24:mi:ss') as regdate
from tbl_comment
where status = 1 and parentSeq = 3
order by seq desc;


-- ==== 이제는 Transaction 처리를 위한 시나리오 때문에 만들었던 포인트 제약을 없애겠다. ==== --
alter table tbl_member
drop constraint CK_tbl_member_point
-- Table TBL_MEMBER이(가) 변경되었습니다.

update tbl_board set commentcount = 0;

select seq, subject, commentcount
from tbl_board
order by seq desc;

select userid, point
from tbl_member
where userid in ('eomjh','ksj1024sj');

select *
from tbl_member

update tbl_board set status = 1
where seq between 1 and 6

commit;



		select seq, fk_userid, name, subject, content, pw
		     , readCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, status, commentcount
		from tbl_board
		where status = 1 
				and lower(subject) like '%'||lower('java')||'%'
		order by seq desc


		select *
		from tbl_board
        where status = 1 
        
		select count(*)
		from tbl_board
		where status = 1 
        		and ( lower(subject) like '%'||lower('넵')||'%'
				or    lower(content) like '%'||lower('넵')||'%' )
				and lower(subject) like '%'||lower('java')||'%'
		

		select ROWNUM AS rno, seq, fk_userid, name, subject, content, pw, readcount, 
		       regdate, status, commentcount
		FROM
		    (
		     select ROWNUM AS rno, seq, fk_userid, name, subject, content, pw, readcount, 
		           	regdate, status, commentcount
		     from
		          (
		           select seq, fk_userid, name, subject, content, pw, readcount, 
		           		  regdate, status, commentcount
		           from tbl_board
		           where status = 1 
		           order by regdate desc
		           ) V
		     ) T
		where rno between 11 and 20;

		     select seq, fk_userid, name, subject, content, pw, readcount, 
		           	regDate, status, commentcount
		     from
		          (
		           select row_number() over(order by seq desc) AS rno, 
		           		  seq, fk_userid, name, subject, content, pw, readcount, 
		           		  to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, status, commentcount
		           from tbl_board
		           where status = 1 
							
		           order by regDate desc
		           ) V
			  where V.rno between 1 and 10;





-------------------------------------------------------------------------------
begin
    for i in 1..100 loop
        insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
        values(boardSeq.nextval, 'ksj1024sj', '김승진', '서영학 입니다'||i, '안녕하세요? 서영학'|| i ||' 입니다.', '1234', default, default, default);
    end loop;
end;

begin
    for i in 101..200 loop
        insert into tbl_board(seq, fk_userid, name, subject, content, pw, readCount, regDate, status)
        values(boardSeq.nextval, 'eomjh', '엄정화', '엄정화 입니다'||i, '안녕하세요? 엄정화'|| i ||' 입니다.', '1234', default, default, default);
    end loop;
end;

commit;
-- 커밋 완료.



	   select previousseq, previoussubject, seq, fk_userid, 
	   		  name, subject, content, readCount, regDate, pw, nextseq, nextsubject
	    FROM
	    (
	        select lag (seq, 1) over(order by seq desc) AS previousseq
	             , lag (subject, 1) over(order by seq desc)  AS previoussubject
	             , seq, fk_userid, name, subject, content, readCount
	             , to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate, pw
	             , lead (seq, 1) over(order by seq desc) AS nextseq
	             , lead (subject, 1) over(order by seq desc) AS nextsubject
	        from tbl_board
	        where status = 1
            and lower(subject) like '%'||lower('JaVa')||'%'
	    ) V
	    WHERE V.seq = 14	





		select seq, fk_userid, name, content, regDate
		FROM
		(
		select row_number() over(order by seq desc) AS rno,  
			   seq, fk_userid, name, content, 
			   to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') as regDate
		from tbl_comment
		where status = 1 and parentSeq = 214
		order by seq desc
		) V
		where rno BETWEEN 1 AND 10
        
        
        		select count(*) AS totalCount
		from tbl_comment
		where parentSeq = 214
