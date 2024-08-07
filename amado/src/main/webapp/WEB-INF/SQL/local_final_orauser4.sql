
show user;
-- USER이(가) "FINAL_ORAUSER4"입니다.
      
 DROP TABLE tbl_member
 
 SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;


SELECT *
FROM USER_CONSTRAINTS

select *
from tbl_matching

SELECT * FROM TAB

select *
from user_constraints
where table_name = 'PK_tbl_sport_sportseq';

select *
from tbl_member

delete from tbl_member 
where userid = 'TestID';

commit;
        
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


		insert into tbl_board(boardseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize)
		values(seq_board.nextval, '제목', '내용', 'ksj1024sj', default, '1234', 0, 0, default, '', '' , '')



		select boardseq, title, content, fk_userid, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
			 , password, commentcount, viewcount, status
			 , orgfilename, filename, filesize
        from tbl_board
		where status = 1 
				and lower(title) like '%'||lower('제목')||'%'
		order by boardseq desc

		select boardseq, title, content, fk_userid, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
			 , password, commentcount, viewcount, status
			 , orgfilename, filename, filesize
		from tbl_board
		where status = 1
		order by boardseq desc



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

select *
from tbl_club

select *
from tbl_sport

		select clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
         , rank() over(order by clubscore desc) AS rank
		from tbl_club
		where clubstatus = 1


		order by membercount asc	




create table tbl_club    
(clubseq      NUMBER              not null        -- 동호회번호
,clubname      nvarchar2(20)       not null        -- 동호회명
,clubimg      nvarchar2(50)                       -- 대표이미지
,fk_sportseq      NUMBER              not null        -- 종목번호(tbl_sport(sportseq) fk)
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
,constraint FK_tbl_club_sportseq foreign key(fk_sportseq) references tbl_sport(sportseq)
,constraint FK_tbl_club_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

alter table tbl_club add constraint FK_tbl_club_sportseq foreign key(fk_sportseq) references tbl_sport(sportseq) on delete casecade;

select *
from tbl_club

-- Table TBL_CLUB이(가) 생성되었습니다.

create sequence seq_club 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_CLUB이(가) 생성되었습니다.


select *
from TBL_SPORT    

create table tbl_gym    
(gymseq          NUMBER          NOT NULL    -- 체육관번호(PK)
,gymname      nvarchar2(30)   NOT NULL    -- 체육관명
,fk_userid      nvarchar2(20)   NOT NULL    -- 담당자아이디(FK)
,postcode      nvarchar2(5)    NOT NULL    -- 우편번호
,address      nvarchar2(50)   NOT NULL    -- 주소
,detailaddress   nvarchar2(100)  NOT NULL    -- 상세주소
,extraaddress   nvarchar2(50)   NOT NULL    -- 주소참고항목
,status          number(1) default 1 NOT NULL    -- 운영여부
,info          nvarchar2(1000) NOT NULL    -- 정보
,imgfilename   nvarchar2(50)               -- 첨부파일
,cost          NUMBER                      -- 비용
,caution      nvarchar2(500)              -- 주의사항
,membercount   NUMBER                      -- 인원
,likecount       NUMBER                      -- 좋아요수
,constraint PK_tbl_gym_ymseq primary key(ymseq)
,constraint FK_tbl_gym_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_GYM이(가) 생성되었습니다.


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


create table tbl_clubmember    
(fk_userid       nvarchar2(20)  not null          -- (tbl_member(userid) fk)  아이디
,sportseq        NUMBER         not null          -- (tbl_sport(sportseq) fk) 종목번호
,clubseq         NUMBER                           -- (tbl_club(clubseq) fk)   동호회번호
,constraint FK_tbl_clubmember_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint FK_tbl_clubmember_sportseq foreign key(sportseq) references tbl_sport(sportseq)
,constraint FK_tbl_clubmember_clubseq foreign key(clubseq) references tbl_club(clubseq)
);

-- Table TBL_CLUBMEMBER이(가) 생성되었습니다.


create table tbl_loginhistory    
(loginseq                    NUMBER         not null          -- 회원로그인번호
,fk_userid                   nvarchar2(20)  not null          -- 아이디
,logindate                   nvarchar2(20)  not null          -- 로그인 날짜 시각
,clientip                    nvarchar2(30)  not null          -- 접속IP주소
,constraint PK_tbl_loginhistory_loginseq primary key(loginseq)
,constraint FK_tbl_loginhistory_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_LOGINHISTORY이(가) 생성되었습니다.






create table tbl_clubboard    
(clubboardseq      NUMBER              not null        -- 동호회게시판번호
,clubseq          NUMBER              not null        -- 동호회번호(tbl_club(clubseq) fk)
,title              nvarchar2(50)       not null        -- 글제목
,content          nvarchar2(1000)     not null        -- 글내용
,fk_userid          nvarchar2(20)       not null        -- 회장아이디(tbl_member(userid) fk)
,registerdate      DATE                not null        -- 작성일자
,password          nvarchar2(20)       not null        -- 글암호   
,commentcount      NUMBER              not null        -- 댓글수
,viewcount           NUMBER              not null        -- 조회수
,status               number(1)           not null        -- 삭제유무
,orgfilename       nvarchar2(50)                       -- 첨부파일원본이름
,filename           nvarchar2(50)                       -- 첨부파일이름
,filesize           NUMBER                              -- 파일크기
,constraint PK_tbl_clubboard_clubboardseq primary key(clubboardseq)
,constraint FK_tbl_clubboard_sportseq foreign key(clubseq) references tbl_club(clubseq)
,constraint FK_tbl_clubboard_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_CLUBBOARD이(가) 생성되었습니다.



create sequence seq_clubboard
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CLUBBOARD이(가) 생성되었습니다.


select *
from tbl_matchingreg

create table tbl_matchingreg    
(matchingregseq  NUMBER   not null                -- 시합등록번호
,clubseq          NUMBER                           -- 동호회번호(FK)
,sportseq        NUMBER                           -- 종목번호(FK)
,membercount        NUMBER                           -- 인원
,matchdate        DATE                             -- 시합일자
,city            nvarchar2(50)                    -- 시
,local            nvarchar2(50)                    -- 구
,area            nvarchar2(30)                    -- 장소
,status            NUMBER(1) default 0  not null              -- 매칭여부
                                                  -- 0: 매칭 없음
                                                  -- 1: 매칭 대기중(시합 등록한 동호회가 어떤 동호회를 대결상태로 선택할지 대기중인 상태)
                                                  -- 2: 매칭 완료(마감)

,constraint PK_tbl_matchingreg_matregseq primary key(matchingregseq)
,constraint FK_tbl_matchingreg_clubseq foreign key(clubseq) references tbl_club(clubseq)
,constraint FK_tbl_matchingreg_sportseq foreign key(sportseq) references tbl_sport(sportseq)
,constraint CK_tbl_matchingreg_status check( status in(0,1,2) )
);

-- Table TBL_MATCHINGREG이(가) 생성되었습니다.


create sequence seq_matchingreg
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_MATCHINGREG이(가) 생성되었습니다.


create table tbl_matching    
(matchingseq         NUMBER   not null        -- 시합번호
,matchingregseq      NUMBER                   -- 시합등록번호(FK)
,clubseq2            NUMBER                   -- 동호회A(FK)
,clubseq             NUMBER                   -- 동호회B(FK)
,result              NUMBER   default 0       -- 시합결과(시합전:0, 승:1, 패:2)

,constraint PK_tbl_matching_matchingseq primary key(matchingseq)
,constraint FK_tbl_matching_matchingregseq foreign key(matchingregseq) references tbl_matchingreg(matchingregseq)
,constraint FK_tbl_matching_clubseq2 foreign key(clubseq2) references tbl_club(clubseq)
,constraint FK_tbl_matching_clubseq foreign key(clubseq) references tbl_club(clubseq)
);

-- Table TBL_MATCHING이(가) 생성되었습니다.


create sequence seq_matching 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_MATCHING이(가) 생성되었습니다.

create table tbl_matchingapply    
(matchingapplyseq        NUMBER   not null        -- 시합신청번호
,matchingregseq          NUMBER                   -- 시합등록번호(FK)
,clubseq                NUMBER                   -- 동호회번호(FK)
,membercount            NUMBER                   -- 인원
,message                nvarchar2(50)            -- 요청메세지

,constraint PK_tbl_matchingapply_mgpseq primary key(matchingapplyseq)
,constraint FK_tbl_matchingapply_mregseq foreign key(matchingregseq) references tbl_matchingreg(matchingregseq)
,constraint FK_tbl_matchingapply_clubseq foreign key(clubseq) references tbl_club(clubseq)
);

-- Table TBL_MATCHINGAPPLY이(가) 생성되었습니다.


create sequence seq_matchingapply   
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_MATCHINGAPPLY이(가) 생성되었습니다.



create table tbl_notice    
(noticeseq                   NUMBER   not null                -- 전체게시판번호
,title                       nvarchar2(50)  not null          -- 글제목
,content                     nvarchar2(1000)   not null       -- 글내용
,registerdate                date default sysdate  not null   -- 작성일자
,viewcount                   NUMBER                           -- 조회수
,status                      number(1) default 0 not null     -- 게시글삭제유무   0: 사용가능(게시글등록) / 1:사용불가(게시글삭제) 
,orgfilename               nvarchar2(50)                    -- 첨부파일원본이름
,filename                   nvarchar2(50)                    -- 첨부파일이름
,filesize                   NUMBER                           -- 파일크기

,constraint PK_tbl_notice_noticeseq primary key(noticeseq)
,constraint CK_tbl_notice_status check( status in(0,1) )
);
-- Table TBL_NOTICE이(가) 생성되었습니다.

create sequence seq_notice  
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_NOTICE이(가) 생성되었습니다.



create table tbl_gymimg    
(gymimgseq                   NUMBER   not null   -- 체육관추가이미지
,gymseq                      NUMBER              -- 체육관번호
,imgfilename                 nvarchar2(50)       -- 이미지파일명
 
,constraint PK_tbl_gymimg_gymimgseq primary key(gymimgseq)
,constraint FK_tbl_gymimg_gymseq foreign key(gymseq) references tbl_gym(gymseq)
);

-- Table TBL_GYMIMG이(가) 생성되었습니다.

create sequence seq_gymimg  
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_GYMIMG이(가) 생성되었습니다.




-- 금요일 이후 제작 완료 --

 alter table tbl_gym rename column ymseq to gymseq;
-- tbl_gym 시퀀스 이름 잘못지음.

-- comment ==> comment_text ( comment 가 예약어라 사용 불가라 comment_text 로 변경)


create table tbl_clubboardcomment    
(clubboardcommentseq      NUMBER                                   -- 댓글번호(PK)
,clubboardseq             NUMBER                                   -- 동호회게시판번호(FK)
,comment_text             nvarchar2(200)                           -- 댓글내용(시)
,registerdate             DATE DEFAULT SYSDATE NOT NULL            -- 댓글작성일자
,fk_userid                nvarchar2(20)                            -- 아이디(FK)

,constraint PK_tbl_cbbdcmt_clcmtseq primary key(clubboardcommentseq)
,constraint FK_tbl_cbbdcmt_clubboardseq foreign key(clubboardseq) references tbl_clubboard(clubboardseq)
,constraint FK_tbl_cbbdcmt_fk_userid foreign key(fk_userid) references tbl_member(userid)
);
-- Table TBL_CLUBBOARDCOMMENT이(가) 생성되었습니다.

create sequence seq_clubboardcomment   
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CLUBBOARDCOMMENT이(가) 생성되었습니다.


create table tbl_fleamarket    
(fleamarketseq      NUMBER                  -- 중고마켓번호(PK)
,sportseq          NUMBER                  -- 종목번호(FK)
,city              nvarchar2(50)           -- 지역(시)
,local              nvarchar2(50)           -- 지역(구)
,title              nvarchar2(50)           -- 글제목
,content          nvarchar2(500)          -- 글내용
,cost              NUMBER                  -- 가격
,deal               nvarchar2(20)           -- 거래방법
,fk_userid          nvarchar2(20)           -- 작성자아이디(FK)
,registerdate      DATE DEFAULT SYSDATE NOT NULL    -- 작성일자
,password          nvarchar2(20)           -- 글암호
,commentcount      NUMBER                  -- 댓글수
,viewcount          NUMBER                  -- 조회수
,status              number(1) default 0 not null -- 삭제유무 (0 등록 1 삭제)
,imgfilename      nvarchar2(50)           -- 첨부파일

,constraint PK_tbl_fleamarket_fmaketseq primary key(fleamarketseq)
,constraint FK_tbl_fleamarket_sportseq foreign key(sportseq) references tbl_sport(sportseq)
,constraint FK_tbl_fleamarket_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_fleamarket_status check( status in(0,1) )
);

-- Table TBL_FLEAMARKET이(가) 생성되었습니다.

create sequence seq_fleamarket   
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_FLEAMARKET이(가) 생성되었습니다.



create table tbl_fleamarketimg    
(fleamarketimgseq      NUMBER                  -- 이미지번호(PK)
,fleamarketseq          NUMBER                  -- 중고마켓번호(FK)
,imgfilename          nvarchar2(50)           -- 이미지파일명

,constraint PK_tbl_fleamarket_fmkimgseq primary key(fleamarketimgseq)
,constraint FK_tbl_fleamarket_fmketseq foreign key(fleamarketseq) references tbl_fleamarket(fleamarketseq)
);

-- Table TBL_FLEAMARKETIMG이(가) 생성되었습니다.

create sequence seq_fleamarketimg    
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_FLEAMARKETIMG이(가) 생성되었습니다.




create table tbl_fleamarketcomment    
(fleamarketcommentseq      NUMBER                  -- 댓글번호(PK)
,fleamarketseq             NUMBER                  -- 중고마켓게시판번호(FK)
,comment_text              nvarchar2(200)          -- 댓글내용
,registerdate              date default sysdate  not null                     -- 댓글작성일자
,fk_userid                 nvarchar2(20)           -- 아이디(FK)

,constraint PK_tbl_fktcomment_fmkimgseq primary key(fleamarketcommentseq)
,constraint FK_tbl_fktcomment_fmketseq foreign key(fleamarketseq) references tbl_fleamarket(fleamarketseq)
,constraint FK_tbl_fktcomment_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_FLEAMARKETCOMMENT이(가) 생성되었습니다.


create sequence seq_fleamarketcomment 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_FLEAMARKETCOMMENT이(가) 생성되었습니다.




-- 체육관문의카테고리
create table tbl_category    
(categoryseq      NUMBER                  -- 카테고리번호(PK)
,categoryname             nvarchar2(10)                  -- 카테고리명(FK)

,constraint PK_tbl_category_categoryseq primary key(categoryseq)
);
-- Table TBL_CATEGORY이(가) 생성되었습니다.

create sequence seq_category  
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CATEGORY이(가) 생성되었습니다.


-- 체육관문의

create table tbl_gymquestion      
(gymquestionseq               NUMBER                                 -- 체육관문의번호(PK)
,gymseq                       NUMBER                                 -- 체육관번호(FK)
,categoryseq                  NUMBER                                 -- 카테고리번호(FK)
,content                      nvarchar2(500)                         -- 문의내용
,userid                       nvarchar2(20)                          -- 작성자아이디
,registerdate                 date default sysdate  not null         -- 작성일자
,commentstatus                number(1) default 0  not null          -- 체육관문의 테이블 commentstatus 컬럼
                                                                     -- 0: 미답변
                                                                     -- 1: 답변완료
,constraint PK_tbl_gyq_gymquestionseq primary key(gymquestionseq)
,constraint FK_tbl_gyq_gymseq foreign key(gymseq) references tbl_gym(gymseq)
,constraint FK_tbl_gyq_categoryseq foreign key(categoryseq) references tbl_category(categoryseq)
,constraint FK_tbl_gyq_userid foreign key(userid) references tbl_member(userid)
,constraint CK_tbl_gyq_commentstatus check( commentstatus in(0,1) )
);
-- Table TBL_GYMQUESTION이(가) 생성되었습니다.

create sequence seq_gymquestion
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_GYMQUESTION이(가) 생성되었습니다.



-- 체육관문의답변

create table tbl_gymanswer      
(gymanswerseq               NUMBER                              -- 체육관문의답변번호(PK)
,gymquestionseq             NUMBER                              -- 체육관문의번호(FK)
,content                    nvarchar2(500)                      -- 답변내용
,registerdate               date default sysdate  not null      -- 작성일자

,constraint PK_tbl_gymawr_gymawrseq primary key(gymanswerseq)
,constraint FK_tbl_gymawr_gymquestionseq foreign key(gymquestionseq) references tbl_gymquestion(gymquestionseq)
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



select *
from tbl_member


insert into tbl_member(USERID, PASSWORD, NAME, EMAIL, POSTCODE, ADDRESS, DETAILADDRESS, EXTRAADDRESS, MOBILE, GENDER, BIRTHDAY, REGISTERDAY, LASTPWDCHANGEDATE, STATUS, MEMBERRANK, GYMREGISTERSTATUS, SPEED, QUICK, POWER, EARTH, STRETCH, IDLE) 
values('ksj1024sj', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김승진', 'Nb/STO9Z4GBQrKkY9koq/+g0lS1PgGRg/D4VpulV8QY=', '05237', '서울 강동구 아리수로 46', '201동 101호', ' (암사동)', 'L+bSt7E1AXYJSyebi4fSKA==', 1, '1995-10-24', default, default, default, default, default, default, default, default, default, default, default);

commit;


		select count(*) AS n
		from tbl_member 
		where email = 'Nb/STO9Z4GBQrKkY9koq/+g0lS1PgGRg/D4VpulV8QY='




		select count(*)
 		from tbl_club
		where clubstatus = 1		

				and fk_sportseq = 1




	    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , rank	
		FROM
(
		select row_number() over(order by clubscore asc) AS rno 
		 , clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , rank() over(order by clubscore desc) AS rank	
 		from tbl_club
		where clubstatus = 1
				and fk_sportseq = 1
                and city like '%'||'서울'||'%'
		order by rno asc	
)
where rno between '1' and '10'



		select count(*) AS totalPage
 		from tbl_club
		where clubstatus = 1		
				and fk_sportseq = 1
				and city like '%'||'서울'||'%'



	    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , rank() over(order by clubscore desc) AS rank	
		FROM
(
		select row_number() over(order by clubscore asc) AS rno 
		 , clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , rank() over(order by clubscore desc) AS rank	
 		from tbl_club
		where clubstatus = 1
				and fk_sportseq = 1
		order by rno desc
)
where rno between 1 and 10        




		select count(*) AS totalPage
 		from tbl_club
		where clubstatus = 1
        and fk_sportseq = 1
        
        
        
        	    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
			 , city, local, clubgym, clubtime
			 , membercount, clubpay, clubstatus, clubscore
			 , rank	
		FROM
		(
        select row_number() over(order by clubscore desc) AS rno 
		 , clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , rank() over(order by clubscore desc) AS rank	
 		from tbl_club
		where clubstatus = 1
        and fk_sportseq = 1
        )
		where rno between #{startno} and #{startno}
        
        select *
        from tbl_sport
        
     alter table tbl_board 
     add fk_sportseq NUMBER;   
        
     alter table tbl_board add constraint FK_tbl_board_sportseq foreign key(fk_sportseq) references tbl_sport(sportseq);   
     
     commit
     
     
     
     
     
         select *
         from tbl_board
         
         
         
         
	    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
			 , city, local, clubgym, clubtime
			 , membercount, clubpay, clubstatus, clubscore
			 , rank	
		FROM
		(
		select row_number() over(order by clubscore desc) AS rno 
		 , clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , ROW_NUMBER() over(order by clubscore desc) AS rank	
 		from tbl_club
		where clubstatus = 1
    	and fk_sportseq = 5
		)
		where rno between to_number('1') and to_number('10')
		order by rno asc	




select * from tab

select *
from tbl_boardcomment

PURGE TABLE "BIN$W71/r1iXROmezAcnCMa6KQ==$0";   

commit

ALTER SESSION SET ddl_lock_timeout=60;
rollback



create table tbl_boardcomment    
(boardcommentseq          NUMBER                                   -- 댓글번호(PK)
,parentseq                NUMBER                                   -- 게시판번호(FK)
,comment_text             nvarchar2(200)                           -- 댓글내용(시)
,registerdate             DATE DEFAULT SYSDATE NOT NULL            -- 댓글작성일자
,fk_userid                nvarchar2(20)                            -- 아이디(FK)
,status                   number(1) default 1 not null             -- 댓글 상태 1 : 작성 0 : 삭제

,constraint PK_tbl_bdcmt_bdcmtseq primary key(boardcommentseq)
,constraint FK_tbl_bdcmt_bdcmtseq foreign key(parentseq) references tbl_board(boardseq)
,constraint FK_tbl_bdcmt_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_bdcmt_status check( status in(0,1) )                  -- 1 : 작성 0 : 삭제
);
-- Table TBL_BOARDCOMMENT이(가) 생성되었습니다.

commit

alter table tbl_boardcomment
add status number(1) default 1 not null;

select *
from tbl_boardcomment

alter table tbl_boardcomment
add groupno number not null;

alter table tbl_boardcomment
add fk_boardcommentseq number default 0 not null;

alter table tbl_boardcomment
add depthno number default 0 not null;

select *
from tbl_board

alter table tbl_boardcomment add constraint CK_tbl_bdcmt_status check( status in(0,1) );

select *
from tbl_boardcomment
order by boardcommentseq desc

		select NVL(max(groupno), 0)
		from tbl_boardcomment

create sequence seq_boardcomment 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_BOARDCOMMENT이(가) 생성되었습니다.



create sequence seq_fk_boardcommentseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;





select *
from tbl_member


update tbl_board  set COMMENTCOUNT = 0

update tbl_board  set VIEWCOUNT = 0

commit

select *
from tbl_board
order by boardseq desc

delete from tbl_boardcomment

commit

ALTER TABLE tbl_gym_photos CHANGE several_photos fileDrop NVARCHAR2(200);

desc tbl_gym_photos

delete from tbl_gym_photos

drop table tbl_gym_photos

select *
from tbl_gym;

select *
from tbl_gym_photos

delete from tbl_boardcomment
where fk_userid = 'TestID'

commit;

orgfilename 

filename

filesize

select *from tab

select *
from TBL_SPORT


/*
1	축구
2	야구
3	배구
4	농구
5	족구
6	테니스
7	볼링
8	배드민턴
*/


select clubseq
from tbl_club
order by clubseq desc

/*
---------------
1	축구
THE CHEERS
이나래와 친구들
최준혁과 친구들
테스트클럽3
---------------

---------------
2	야구
야구빠따
---------------

---------------
3	배구
서한솔과 친구들
---------------

---------------
4	농구
김승진과 친구들
---------------

---------------
5	족구
서영학의 제자들
축구가 조아
---------------

---------------
6	테니스
영학씨의 마니또들
---------------

---------------
7	볼링
서울대학교 동호회
---------------

---------------
8	배드민턴
날아라닭털공
강원대 배드민턴 동호회
가평잣막걸리
---------------
*/









/* 1대1 문의 테이블 */


create table tbl_inquiry   
(inquiryseq                  NUMBER   not null                -- 문의번호
,content                     nvarchar2(1000)   not null       -- 글내용
,fk_userid                   nvarchar2(20)  not null          -- 아이디(tbl_member 의 회원아이디)
,email                       nvarchar2(50)   not null         -- 이메일
,phone                       nvarchar2(50)   not null         -- 휴대폰
,registerdate                date default sysdate  not null   -- 작성일자
,searchType_a                NUMBER                           -- 문의유형 A
,searchType_b                NUMBER                           -- 문의유형 B
,status                      number(1) default 1 not null     -- 게시글삭제유무   1: 사용가능(게시글등록) / 0:사용불능(게시글삭제) 

,constraint PK_tbl_inquiry_boardseq primary key(inquiryseq)
,constraint FK_tbl_inquiry_fk_userid foreign key(fk_userid) references tbl_member(userid)
,constraint CK_tbl_inquiry_status check( status in(0,1) )
);
// Table TBL_INQUIRY이(가) 생성되었습니다.


alter table tbl_inquiry
add answer number(1) default 0;
-- Table TBL_INQUIRY이(가) 변경되었습니다.

desc tbl_inquiry;

select *
from tbl_inquiry


		WITH InquiryWithFiles AS (
		  SELECT I.inquiryseq, I.content, I.fk_userid, I.email, I.phone, I.registerdate, I.searchtype_a, I.searchtype_b, I.status, I.answer,
		         F.orgfilename, F.filename, F.filesize,
		         ROW_NUMBER() OVER (PARTITION BY I.inquiryseq ORDER BY F.filename) AS row_num
		  FROM tbl_inquiryFile F
		  JOIN tbl_inquiry I ON F.inquiryseq = I.inquiryseq
		  WHERE I.fk_userid = 'ksj1024sj' AND I.status = 1
		)
		SELECT inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status, answer,
		       orgfilename, filename, filesize
		FROM InquiryWithFiles
		WHERE row_num = 1
		ORDER BY inquiryseq DESC


create sequence seq_inquiry 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_INQUIRY이(가) 생성되었습니다.

commit

select *
from tbl_club
where CLUBSEQ = 121

select *
from tbl_member

delete from tbl_club
where CLUBSEQ = 121
commit

select *
from tbl_inquiryanswers
order by registerdate desc


SELECT constraint_name, table_name, column_name, r_constraint_name
FROM all_cons_columns
WHERE constraint_name = 'FK_TBL_IQRYAWS_FK_USERID';


   alter table tbl_inquiry
   add title nvarchar2(50);

alter table tbl_inquiryanswers add constraint PK_IQAS_inquiryanswerseq primary key(inquiryanswerseq);


delete from tbl_inquiryanswers
where inquiryanswerseq = inquiryanswerseq and inquiryseq = inquiryseq

commit

select *
from tbl_inquiry

    update tbl_inquiry set title = '적당한 제목 만들기'
    
    commit
    
    where INQUIRYSEQ != 11;

commit

select *
from tbl_inquiry

drop table tbl_inquiryanswers purge;

select *
from tbl_member



-- 문의답변(운영자용)
create table tbl_inquiryanswers
(inquiryanswerseq           number   not null
,inquiryseq                  NUMBER   not null
,content                     nvarchar2(1000)   not null       -- 글내용
,registerdate                date default sysdate  not null   -- 작성일자
,fk_userid                   nvarchar2(20)  not null          -- 아이디(tbl_member 의 회원아이디)
,constraint FK_tbl_iqryaws_inquiryseq foreign key(inquiryseq) references tbl_inquiry(inquiryseq)
,constraint FK_tbl_iqryaws_fk_userid foreign key(fk_userid) references tbl_member(userid)
,CONSTRAINT CK_tbl_iqryaws_admin CHECK (fk_userid = 'admin')
);
-- Table TBL_INQUIRYANSWERS이(가) 생성되었습니다.

-- 지금 admin 이 아니라 MEMBERRANK == 2 이걸로 관리자 권한 만들었음

ALTER TABLE tbl_inquiryanswers
DROP CONSTRAINT CK_tbl_iqryaws_admin;



create sequence seq_inquiryanswers 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;
-- 커밋 완료.





create table tbl_inquiryFile 
(inquiryseq                NUMBER   not null
,orgfilename               nvarchar2(50)                    -- 첨부파일원본이름
,filename                  nvarchar2(50)                    -- 첨부파일이름
,filesize                  NUMBER                           -- 파일크기
,constraint FK_tbl_inquiryFile_inquiryseq foreign key(inquiryseq) references tbl_inquiry(inquiryseq)
);
-- Table TBL_INQUIRYFILE이(가) 생성되었습니다.



select *
from tbl_inquiry
order by inquiryseq desc

select *
from tbl_inquiryFile
order by inquiryseq desc
<<<<<<< HEAD

select *
from tbl_inquiry
order by inquiryseq desc

select *
from tbl_inquiryFile

SELECT I.inquiryseq, I.content, I.fk_userid, I.email, I.phone, I.registerdate, I.searchtype_a, I.searchtype_b, I.status
     , F.orgfilename, F.filename, F.filesize  
FROM tbl_inquiryFile F JOIN(select *
                        from tbl_inquiry
                        where fk_userid = 'ksj1024sj' and status = 1) I
ON F.inquiryseq = I.inquiryseq
order by inquiryseq desc

-- 1대1 문의 디테일(파일보여주기)
SELECT I.inquiryseq, I.content, I.fk_userid, I.email, I.phone, I.registerdate, I.searchtype_a, I.searchtype_b, I.status
     , F.orgfilename, F.filename, F.filesize  
FROM tbl_inquiryFile F JOIN(select *
                        from tbl_inquiry
                        where fk_userid = 'ksj1024sj' and inquiryseq = 6) I
ON F.inquiryseq = I.inquiryseq
order by inquiryseq desc

select *
from tbl_member



select *
from tbl_clubmember
where fk_userid = 'ksj1024sj' and sportseq = 1

delete from tbl_clubmember
where fk_userid = 'ksj1024sj' and STATUS = 0;


commit;

select *
from tbl_sport






		WITH InquiryWithFiles AS (
		  SELECT I.inquiryseq, I.content, I.fk_userid, I.email, I.phone, I.registerdate, I.searchtype_a, I.searchtype_b, I.status,
		         F.orgfilename, F.filename, F.filesize,
		         ROW_NUMBER() OVER (PARTITION BY I.inquiryseq ORDER BY F.filename) AS row_num
		  FROM tbl_inquiryFile F
		  JOIN tbl_inquiry I ON F.inquiryseq = I.inquiryseq
		  WHERE I.fk_userid ='ksj1024sj' AND I.status = 1
		)
		SELECT inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status,
		       orgfilename, filename, filesize
		FROM InquiryWithFiles
		WHERE row_num = 1
		ORDER BY inquiryseq DESC
        
        
	    SELECT inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status
		FROM
(        select row_number() over(order by inquiryseq asc) AS rno 
             , inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status
             
        from tbl_inquiry
        where fk_userid = 'ksj1024sj' and status = 1
        and searchtype_a = 2 and lower(content) like '%'||lower('')||'%' 
        order by rno desc
)
where rno between 1 and 10
        
        
        
	    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , rank() over(order by clubscore desc) AS rank	
		FROM
(
		select row_number() over(order by clubscore asc) AS rno 
		 , clubseq, clubname, clubimg, fk_sportseq, clubtel
		 , city, local, clubgym, clubtime
		 , membercount, clubpay, clubstatus, clubscore
		 , rank() over(order by clubscore desc) AS rank	
 		from tbl_club
		where clubstatus = 1
				and fk_sportseq = 1
		order by rno desc
)
where rno between 1 and 10          




	    SELECT inquiryseq
	    FROM (
	        SELECT INQUIRYSEQ, ORGFILENAME, FILENAME, FILESIZE
	        FROM tbl_inquiryFile
            where inquiryseq = 6
	        ORDER BY inquiryseq DESC
	    )
	    WHERE ROWNUM = 1
        
        
        
        		WITH InquiryWithFiles AS (
		  SELECT I.inquiryseq, I.content, I.fk_userid, I.email, I.phone, I.registerdate, I.searchtype_a, I.searchtype_b, I.status,
		         F.orgfilename, F.filename, F.filesize,
		         ROW_NUMBER() OVER (PARTITION BY I.inquiryseq ORDER BY F.filename) AS row_num
		  FROM tbl_inquiryFile F
		  JOIN tbl_inquiry I ON F.inquiryseq = I.inquiryseq
		  WHERE I.fk_userid = 'ksj1024sj' AND I.status = 1
		)
		SELECT inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status,
		       orgfilename, filename, filesize
		FROM InquiryWithFiles
		WHERE row_num = 1
		ORDER BY inquiryseq DESC
        
        
        
        
SELECT inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status, answer
FROM tbl_inquiry
ORDER BY fk_userid ASC, inquiryseq DESC;        
        
        
        
        
	    SELECT inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status, answer
	    FROM (
	        SELECT row_number() over(order by inquiryseq asc) AS rno,
	               inquiryseq, content, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status, answer
	        FROM tbl_inquiry
	        WHERE status = 1
	        ORDER BY fk_userid DESC, rno DESC
	    )
	    WHERE rno BETWEEN 11 AND 20
        
        
        select count(*)
	    from tbl_inquiry
	    where status = 1
        and fk_userid = 'ksj1024sj'
        and searchtype_a = 1
        and answer = 0
        and lower(fk_userid) like CONCAT(CONCAT('%', lower('ksj')), '%')
        
        
        
        
        	    SELECT title, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status, answer
	    FROM (
	        SELECT row_number() over(order by inquiryseq desc) AS rno,
	               inquiryseq, title, fk_userid, email, phone, registerdate, searchtype_a, searchtype_b, status, answer
	        FROM tbl_inquiry
	        WHERE status = 1
	        ORDER BY fk_userid DESC, rno asc
	    )
	    WHERE rno BETWEEN 1 AND 10
        
        
        

select gymimgseq,gymseq,filename,orgfilename    
from tbl_gymimg  
where gymseq = 125

select *
from tbl_gym
where gymseq = 125

desc tbl_gym

ALTER TABLE tbl_gym
MODIFY CAUTION NVARCHAR2(2000);


ALTER TABLE tbl_gym
MODIFY INFO NVARCHAR2(2000);

commit

select *
from tbl_member
where userid = 'ksj1024sj'


select *
from tbl_club
where clubname = '테스트클럽3'

select *
from tbl_clubmember
where clubseq = 15

update tbl_clubmember set status = 1
where fk_userid = 'ksj1024sj' and clubseq = 15

commit



select * from tab


TBL_BOARD
TBL_BOARDCOMMENT

TBL_CALENDAR_LARGE_CATEGORY
TBL_CALENDAR_SCHEDULE
TBL_CALENDAR_SMALL_CATEGORY
TBL_CATEGORY
TBL_CITY

TBL_CLUB
TBL_CLUBBOARD
TBL_CLUBBOARDCOMMENT
TBL_CLUBMEMBER

TBL_FLEAMARKET
TBL_FLEAMARKETCOMMENT
TBL_FLEAMARKETCOMMENTREPLY
TBL_FLEAMARKETIMG

TBL_GYM
TBL_GYMANSWER
TBL_GYMIMG
TBL_GYMQUESTION
TBL_GYMRES

TBL_INQUIRY
TBL_INQUIRYANSWERS
TBL_INQUIRYFILE

TBL_LOCAL
TBL_LOGINHISTORY

TBL_MATCHING
TBL_MATCHINGAPPLY
TBL_MATCHINGREG

TBL_MEMBER

TBL_NOTICE
TBL_NOTICECOMMENT

TBL_OPENDATA_GYM
TBL_SPORT


select *
from TBL_GYMQUESTION



SELECT *
FROM (
    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
         , city, local, clubgym, clubtime
         , membercount, clubpay, clubstatus, clubscore
         , ROW_NUMBER() OVER (ORDER BY clubscore DESC) AS rank
    FROM tbl_club
    WHERE clubstatus = 1 AND fk_sportseq = 1
)
WHERE rank IN (1)
ORDER BY rank;


SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
         , city, local, clubgym, clubtime
         , membercount, clubpay, clubstatus, clubscore
         , rank
FROM (
    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
         , city, local, clubgym, clubtime
         , membercount, clubpay, clubstatus, clubscore
         , ROW_NUMBER() OVER (ORDER BY clubscore DESC) AS rank
    FROM tbl_club
    WHERE clubstatus = 1 AND fk_sportseq = 1
)
WHERE rank IN (2)
ORDER BY rank;



SELECT clubname
FROM (
    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
         , city, local, clubgym, clubtime
         , membercount, clubpay, clubstatus, clubscore
         , ROW_NUMBER() OVER (ORDER BY clubscore DESC) AS rank
    FROM tbl_club
    WHERE clubstatus = 1 AND fk_sportseq = 2
)
WHERE rank IN (1)
ORDER BY rank;


select *
from tbl_calendar_small_category

select *
from TBL_CATEGORY





select *
from tbl_member



-- 여기서 1등 클럽이름 조회

SELECT clubname
FROM (
    SELECT clubseq, clubname, clubimg, fk_sportseq, clubtel
         , city, local, clubgym, clubtime
         , membercount, clubpay, clubstatus, clubscore
         , ROW_NUMBER() OVER (ORDER BY clubscore DESC) AS rank
    FROM tbl_club
    WHERE clubstatus = 1 AND fk_sportseq = 2
)
WHERE rank IN (1)
ORDER BY rank;

-- 클럽 시퀀스 조회

select clubseq, clubname, clubimg, fk_sportseq, fk_userid, clubtel, city, LOCAL, clubgym, clubtime, membercount, clubpay, clubstatus, clubscore, wasfilename, viewcount
from tbl_club
where clubname = '크로우즈'

select *
from tbl_clubmember
where clubseq = 78

select *
from tab

select *
from TBL_CLUBBOARD

select *
from TBL_CLUBBOARDCOMMENT

select *
from tbl_clubmember
where clubseq = 123

select *
from tbl_board

where fk_userid = 'amado2' and fk_sportseq = 1



select clubseq, clubname, clubimg, fk_sportseq, fk_userid, clubtel, city, LOCAL, clubgym, clubtime, membercount, clubpay, clubstatus, clubscore, wasfilename, viewcount
from tbl_club
where clubname = '최강볼링'
where clubseq = 130

select *
from tab

select *
from TBL_MATCHINGREG

select *
from TBL_MATCHINGAPPLY
where clubseq = '146';

select *
from tbl_matchingreg
where sportseq = 8 and clubseq = '135';

select *
from TBL_MATCHINGREG
where sportseq = 3 and clubseq = '130';

update TBL_MATCHINGREG set STATUS = 1
where sportseq = 3 and clubseq = '130';

update tbl_matchingreg set STATUS = 0
where MATCHINGREGSEQ = 152;

update tbl_matchingreg set MATCHDATE = '24/06/22'
where MATCHINGREGSEQ = 180;

commit


delete from tbl_matchingreg
where MATCHINGREGSEQ > 90 and clubseq = 149;

commit


select *
from tbl_clubmember


select *
from tbl_board

update tbl_board set COMMENTCOUNT = 0
commit

select *
from tbl_clubmember
where STATUS = 0


select *
from tbl_clubmember
order by clubseq desc

update tbl_clubmember set STATUS = 1
where STATUS = 0;

commit



select *
from tab

select *
from TBL_BOARDCOMMENT

alter table TBL_BOARDCOMMENT
add changestatus number default 0 not null;

select *
from TBL_FLEAMARKETCOMMENT

select *
from TBL_FLEAMARKETCOMMENTREPLY