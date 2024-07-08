
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

-- 플리마켓 게시글 insert
insert into tbl_fleamarket(fleamarketseq, sportseq, city, title, content, cost, deal, fk_userid, registerdate, password, status)
values(2, 3, '인천시', '다이소에서 사와 직접 기른 방울토마토 팝니다~', '창가에서 직접 기른 유기농 도마도! 면역력을 길러줘요', 1000, '직거래', 'leejy', default, '1234', 0);

