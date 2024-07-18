
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
select count(*) 
(
select clubseq
from tbl_clubboard
where userid = 'leejy'
)
group by clubseq;

insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 2, '토마토맛토마토맛토', '먹어볼사람', 'leejy', sysdate , '1234', 0 , 0, 1);
insert into tbl_clubboard(clubboardseq, clubseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status)
values(seq_clubboard.nextval, 3, '토마토김치전', '만들어줄게요', 'leejy', sysdate , '1234', 0 , 0, 1);

ALTER TABLE tbl_clubboard
MODIFY (registerdate DEFAULT sysdate);


