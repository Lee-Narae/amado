select *
from tbl_member

select *
from tbl_gym

select *
from tbl_gymquestion

update tbl_gymquestion set category = 1;
commit;

select * from tbl_category;

desc tbl_fleamarketcomment      

create table tbl_member    
(userid                          nvarchar2(20)   not null         -- 회원아이디
,password                        nvarchar2(20)   not null         -- 비밀번호 (SHA-256 암호화 대상)
,name                            nvarchar2(10)   not null         -- 회원명
,email                           nvarchar2(50)   not null         -- 이메일 (AES-256 암호화/복호화 대상) (maxlength 가 60이지만 암호화 때문에 200글자로 설정해둠)
,postcode                        nvarchar2(5)    not null         -- 우편번호
,address                         nvarchar2(50)   not null         -- 주소
,detailaddress                   nvarchar2(100)  not null         -- 상세주소
,extraaddress                    nvarchar2(50)   not null         -- 참고항목
,mobile                          nvarchar2(50)   not null         -- 연락처 (AES-256 암호화/복호화 대상) 
,gender                          number(1)       not null         -- 성별   남자:1  / 여자:2
,birthday                        varchar2(10)    not null         -- 생년월일   
,registerday                     date default sysdate  not null   -- 가입일자 
,lastpwdchangedate               date default sysdate  not null   -- 마지막으로 암호를 변경한 날짜  
,status                          number(1) default 1 not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,memberrank                      number(1) default 0 not null     -- 회원직급
,gymregisterstatus               number(1) default 0 not null     -- 체육관등록여부
,speed                           number(1) default 1              -- 민첩성 (1 ~ 5까지 (높을 수록 스텟 높은 것) )
,quick                           number(1) default 1              -- 순발력 (1 ~ 5까지 (높을 수록 스텟 높은 것) )
,power                           number(1) default 1              -- 근력   (1 ~ 5까지 (높을 수록 스텟 높은 것) )
,earth                           number(1) default 1              -- 지구력 (1 ~ 5까지 (높을 수록 스텟 높은 것) ) 
,stretch                       number(1) default 1              -- 유연성 (1 ~ 5까지 (높을 수록 스텟 높은 것) )

,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in(1,2) )                  -- 1 남자 2 여자
,constraint CK_tbl_member_status check( status in(0,1) )                  -- 0 탈퇴 1 가입
,constraint CK_tbl_member_gymregsts check( gymregisterstatus in(0,1) )    -- 0 체육관등록X 1 체육관 등록
);
-- Table TBL_MEMBER이(가) 생성되었습니다.



create table tbl_board    
(boardseq                    NUMBER   not null                -- 전체게시판번호
,title                       nvarchar2(50)  not null          -- 글제목
,content                     nvarchar2(1000)   not null       -- 글내용
,fk_userid                   nvarchar2(20)  not null          -- 아이디(tbl_member 의 회원아이디)
,registerdate                date default sysdate  not null   -- 작성일자
,password                    nvarchar2(20)                    -- 게시글 글암호
,commentcount                NUMBER                           -- 댓글수
,viewcount                   NUMBER                           -- 조회수
,status                      number(1) default 1 not null     -- 게시글삭제유무   1: 사용가능(게시글등록) / 0:사용불능(게시글삭제) 
,orgfilename               nvarchar2(50)                    -- 첨부파일원본이름
,filename                   nvarchar2(50)                    -- 첨부파일이름
,filesize                   NUMBER                           -- 파일크기

,constraint PK_tbl_board_boardseq primary key(boardseq)
,constraint FK_tbl_board_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_board_status check( status in(0,1) )
);

-- Table TBL_BOARD이(가) 생성되었습니다.


create sequence seq_board
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_BOARD이(가) 생성되었습니다.



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

create sequence seq_club 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_CLUB이(가) 생성되었습니다.

commit;

select *
from tbl_gym

delete from tbl_gym

commit

insert(ymseq,gymname,fk_userid,postcode,postcode,address,detailaddress,extraaddress,status,info,imgfilename,cost,caution,membercount,likecount)
values(,);
INSERT INTO tbl_gym 
(ymseq, gymname, fk_userid, postcode, address, detailaddress, extraaddress, status, info, imgfilename, cost, caution, membercount, likecount) 
VALUES 
(seq_gym.nextval, '서울 체육관', 'eomjh', '12345', '서울시 강남구 테헤란로', '123-45 강남빌딩 3층', '강남역 인근', 1, '최신 운동 기구와 편안한 시설을 갖춘 체육관입니다.', 'gym1.jpg', 50000, '운동 시 개인 안전을 유의하세요.', 200, 150);

INSERT INTO tbl_gym 
(ymseq, gymname, fk_userid, postcode, address, detailaddress, extraaddress, status, info, imgfilename, cost, caution, membercount, likecount) 
VALUES 
(seq_gym.nextval, '부산 체육관', 'leess', '54321', '부산시 해운대구 해운대로', '678-90 해운대타워 5층', '해운대 해수욕장 인근', 1, '해운대 해변에서 운동을 즐길 수 있는 체육관입니다.', 'gym2.png', 45000, '음식물 반입 금지.', 150, 120);

INSERT INTO tbl_gym 
(ymseq, gymname, fk_userid, postcode, address, detailaddress, extraaddress, status, info, imgfilename, cost, caution, membercount, likecount) 
VALUES 
(seq_gym.nextval, '대구 체육관', 'chaew', '67890', '대구시 중구 동성로', '11-22 동성타워 7층', '동성로 중앙', 0, '대구 도심 속에서 운동을 즐길 수 있는 체육관입니다.', NULL, 55000, '화재 안전에 유의하세요.', 100, 80);

INSERT INTO tbl_gym 
(ymseq, gymname, fk_userid, postcode, address, detailaddress, extraaddress, status, info, imgfilename, cost, caution, membercount, likecount) 
VALUES 
(seq_gym.nextval, '대구 체육관', 'chaew', '67890', '대구시 중구 동성로', '11-22 동성타워 7층', '동성로 중앙', 0, '대구 도심 속에서 운동을 즐길 수 있는 체육관입니다.', NULL, 55000, '화재 안전에 유의하세요.', 100, 80);



create table tbl_gym    
(gymseq          NUMBER          NOT NULL    -- 체육관번호(PK)
,gymname      nvarchar2(30)   NOT NULL    -- 체육관명
,fk_userid      nvarchar2(20)   NOT NULL    -- 담당자아이디(FK)
,postcode      nvarchar2(5)    NOT NULL    -- 우편번호
,address      nvarchar2(50)   NOT NULL    -- 주소
,detailaddress   nvarchar2(100)  NOT NULL    -- 상세주소
,extraaddress   nvarchar2(50)   NOT NULL    -- 주소참고항목
,status          number(1)       NOT NULL    -- 운영여부
,info          nvarchar2(1000) NOT NULL    -- 정보
,imgfilename   nvarchar2(50)               -- 첨부파일
,cost          NUMBER                      -- 비용
,caution      nvarchar2(500)              -- 주의사항
,membercount   NUMBER                      -- 인원
,likecount       NUMBER                      -- 좋아요수
,constraint PK_tbl_gym_ymseq primary key(ymseq)
,constraint FK_tbl_gym_fk_userid foreign key(fk_userid) references tbl_member(userid)
);


CREATE TABLE tbl_gym_photos (
    photo_id      NUMBER          NOT NULL,      -- 사진 고유 ID
    fk_gymseq        NUMBER          NOT NULL,      -- 체육관 번호 (FK)
    filedrop     NVARCHAR2(200)  NOT NULL,      -- 여러개 사진첨부
    CONSTRAINT PK_tbl_gym_photos PRIMARY KEY (photo_id),
    CONSTRAINT FK_tbl_gym_photos_gymseq FOREIGN KEY (gymseq) REFERENCES tbl_gym(gymseq)
);
create sequence seq_photo 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


insidestatus
-- Table TBL_GYM이(가) 생성되었습니다.
select *
from tbl_gym;

create sequence seq_gym 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_GYM이(가) 생성되었습니다.



create table tbl_sport    
(sportseq                    NUMBER         not null          -- 종목번호
,sportname                   nvarchar2(20)  not null          -- 종목이름
,constraint PK_tbl_sport_sportseq primary key(sportseq)
);

SELECT * FROM TABLE

create sequence seq_sport
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_SPORT이(가) 생성되었습니다.

select *
from tbl_club

select *
from tbl_gym


insert into tbl_gym(gymseq ,gymname,fk_userid,postcode,address,detailaddress,status,info,imgfilename,cost,caution,membercount,likecount,insidestatus)
	values(seq_gym.nextval, #{gymname}, #{fk_userid}, #{postcode}, #{address}, #{detailaddress}, 0,#{info},#{imgfilename},to_number(#{cost}),#{caution},to_number(#{membercount}),0 ,to_number(#{insidestatus}))


select *
from tbl_gymanswer

drop table tbl_gymanswer
commit;
-- 체육관문의답변
commit;
create table tbl_gymanswer      
(gymanswerseq               NUMBER                              -- 체육관문의답변번호(PK)
,gymquestionseq             NUMBER                              -- 체육관문의번호(FK)
,content                    nvarchar2(500)                      -- 답변내용
,registerdate               date default sysdate  not null      -- 작성일자
,fk_userid                 nvarchar2(20)           -- 아이디(FK)

,constraint PK_tbl_gymawr_gymawrseq primary key(gymanswerseq)
,constraint FK_tbl_gymawr_gymquestionseq foreign key(gymquestionseq) references tbl_gymquestion(gymquestionseq)
,constraint FK_tbl_gymanswer_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_GYMANSWER이(가) 생성되었습니다.


create sequence seq_gymanswer 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_GYMANSWER이(가) 생성되었습니다.


create table tbl_gymanswerreply
(gymquestionseq           NUMBER                  -- 댓글번호(PK)
,gymanswerseq             NUMBER                  -- 중고마켓게시판번호(FK)
,commentreply_text              nvarchar2(200)          -- 댓글내용
,registerdate              date default sysdate  not null                     -- 댓글작성일자
,fk_userid                 nvarchar2(20)           -- 아이디(FK)
,changestatus              number(1)        default 0

,constraint PK_tbl_fktcommentre_fmkcmreseq primary key(gymquestionseq)
,constraint FK_tbl_fktcommentre_fmketcmseq foreign key(gymanswerseq) references tbl_fleamarketcomment(gymanswerseq)
,constraint FK_tbl_fktcommentre_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

select *
from tbl_gym

        select *
		from tbl_gym
		where gymseq=77
desc  tbl_gym
select *
from tbl_gym


SELECT g.gymseq,
       g.gymname,
       g.fk_userid,
       g.postcode,
       g.address,
       g.detailaddress,
       g.status,
       g.info,
       g.cost,
       g.caution,
       g.membercount,
       g.likecount,
       g.insidestatus,
       g.orgfilename AS gym_orgfilename,
       g.filename AS gym_filename,
       g.filesize AS gym_filesize,
       g.lat,
       g.lng,
       gi.orgfilename AS gymimg_orgfilename
  FROM tbl_gym g
  LEFT JOIN tbl_gymimg gi
    ON g.gymseq = gi.gymseq
 WHERE g.gymseq = 77;

select *
from tbl_fleamarketcomment 

select *
from tbl_fleamarketcommentreply 
---------------------------------------------------------------------------------------------
ALTER TABLE tbl_gymquestion ADD (changestatus NUMBER(1));
ALTER TABLE tbl_gym ADD (commentcount NUMBER);
commit;
ALTER TABLE tbl_gymquestion ADD (commentcount NUMBER(5));

select * from tbl_gymquestion

ALTER TABLE tbl_gymquestion ADD COLUMN RECOMMENDCOUNT NUMBER(5);

desc 

drop table tbl_gymquestion;

select *
from tbl_gymquestion;

select *
from tbl_fleamarket

desc tbl_gym
desc tbl_fleamarket

create table tbl_gymquestion      
(gymquestionseq               NUMBER                                 -- 체육관문의번호(PK)
,gymseq                       NUMBER                                 -- 체육관번호(FK)
,category                     NUMBER                                 -- 카테고리(FK)
,content                      nvarchar2(500)                         -- 문의내용
,fk_userid                       nvarchar2(20)                          -- 작성자아이디
,registerdate                 date default sysdate  not null         -- 작성일자
,changestatus                 NUMBER(1)  
,RECOMMENTCOUNT                NUMBER(5)   

,constraint PK_tbl_gyq_gymquestionseq primary key(gymquestionseq)
,constraint FK_tbl_gyq_gymseq foreign key(gymseq) references tbl_gym(gymseq)
,constraint FK_tbl_gyq_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

select *
from tbl_gym

-- Table TBL_GYMQUESTION이(가) 생성되었습니다.
commit
create sequence seq_gymquestion
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_GYMQUESTION이(가) 생성되었습니다.
drop sequence seq_gymquestion

select *
from tbl_answer
-- 체육관문의답변

select *
from tbl_fleamarketcomment

select *
from tbl_gymquestion

select *
from tbl_gymanswer


create table tbl_gymanswer      
(gymanswerseq               NUMBER                              -- 체육관문의답변번호(PK)
,gymquestionseq             NUMBER                              -- 체육관문의번호(FK)
,content                    nvarchar2(500)                      -- 답변내용
,registerdate               date default sysdate  not null      -- 작성일자
,fk_userid                 nvarchar2(20)           -- 아이디(FK)
,changestatus              number(1)        default 0


,constraint PK_tbl_gymawr_gymawrseq primary key(gymanswerseq)
,constraint FK_tbl_gymawr_gymquestionseq foreign key(gymquestionseq) references tbl_gymquestion(gymquestionseq)
,constraint FK_tbl_gymawr_fk_userid foreign key(fk_userid) references tbl_member(userid)
);
select *
from tbl_gym

desc tbl_gym

content_reply

create sequence seq_gymanswerseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

ALTER TABLE tbl_gymanswer
MODIFY (content number not null);

ALTER TABLE tbl_gymanswer RENAME COLUMN CONTENT_RELPY TO content_reply;

select gymquestionseq, fk_userid,category, content, changestatus
		     , to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
             , V.memberimg
		from tbl_gymquestion A join tbl_member V
		ON A.fk_userid = V.userid
		where A.gymseq = 77
		order by gymquestionseq desc
        
        
select gymanswerseq, fk_userid, content, changestatus
     , to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
     , V.memberimg
from tbl_gymanswer A join tbl_member V
ON A.fk_userid = V.userid
where A.gymquestionseq = 20
order by gymanswerseq desc
        
        
select *
from tbl_gymimg
        
        
SELECT g.gymseq,
       g.gymname,
       g.fk_userid,
       g.postcode,
       g.address,
       g.detailaddress,
       g.status,
       g.info,
       g.cost,
       g.caution,
       g.membercount,
       g.likecount,
       g.insidestatus,
       g.orgfilename AS gym_orgfilename,
       g.filename AS gym_filename,
       g.filesize AS gym_filesize,
       g.lat,
       g.lng,
       gi.orgfilename AS gymimg_orgfilename
  FROM tbl_gym g
  LEFT JOIN tbl_gymimg gi
    ON g.gymseq = gi.gymseq
 WHERE g.gymseq = 93;      
 
 select * from tbl_gym where gymseq = 93;
 
 select * from tbl_gymimg where gymseq = 93;
 
 desc tbl_gymimg
 
select GYMIMGSEQ,GYMSEQ,FILENAME,ORGFILENAME    
		from tbl_gymimg
		where gymseq= 77
 gymimgseq,gymseq,filename,orgfilename 
GYMIMGSEQ   
GYMSEQ                    
FILENAME              
ORGFILENAME       
FILESIZE   

select *
from  tbl_gym

update tbl_gym set status = 1;
commit;
select gymimgseq,gymseq,filename,orgfilename    
			from tbl_gym
			where gymseq= 
            
delete from tbl_gym where gymseq= 94 
    commit;
            
desc tbl_gymquestion;

select *
from tbl_gym

select * from tbl_gymquestion;


select *
from tbl_member

select *
from tbl_club

select gymname,address
from tbl_gym
where fk_userid= 'seosh'