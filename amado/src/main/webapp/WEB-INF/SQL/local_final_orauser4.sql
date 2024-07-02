
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



<<<<<<< HEAD
=======
		insert into tbl_board(boardseq, title, content, fk_userid, registerdate, password, commentcount, viewcount, status, orgfilename, filename, filesize)
		values(seq_board.nextval, '제목', '내용', 'ksj1024sj', default, '1234', 0, 0, default, '', '' , '')



		select boardseq, title, content, fk_userid, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
			 , password, commentcount, viewcount, status
			 , orgfilename, filename, filesize
		where status = 1 
				and lower(title) like '%'||lower('제목')||'%'
		order by boardseq desc

		select boardseq, title, content, fk_userid, to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
			 , password, commentcount, viewcount, status
			 , orgfilename, filename, filesize
		from tbl_board
		where status = 1
		order by boardseq desc

>>>>>>> branch 'main' of https://github.com/Lee-Narae/amado.git
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
,clubseq            NUMBER                   -- 동호회B(FK)
,result                nvarchar2(10)            -- 시합결과

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


<<<<<<< HEAD
=======

select *
from tbl_member


insert into tbl_member(USERID, PASSWORD, NAME, EMAIL, POSTCODE, ADDRESS, DETAILADDRESS, EXTRAADDRESS, MOBILE, GENDER, BIRTHDAY, REGISTERDAY, LASTPWDCHANGEDATE, STATUS, MEMBERRANK, GYMREGISTERSTATUS, SPEED, QUICK, POWER, EARTH, STRETCH, IDLE) 
values('ksj1024sj', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '김승진', 'Nb/STO9Z4GBQrKkY9koq/+g0lS1PgGRg/D4VpulV8QY=', '05237', '서울 강동구 아리수로 46', '201동 101호', ' (암사동)', 'L+bSt7E1AXYJSyebi4fSKA==', 1, '1995-10-24', default, default, default, default, default, default, default, default, default, default, default);

commit;


		select count(*) AS n
		from tbl_member 
		where email = 'Nb/STO9Z4GBQrKkY9koq/+g0lS1PgGRg/D4VpulV8QY='
>>>>>>> branch 'main' of https://github.com/Lee-Narae/amado.git
