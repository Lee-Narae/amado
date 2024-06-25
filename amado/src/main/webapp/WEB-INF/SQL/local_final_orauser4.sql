
show user;
-- USER이(가) "FINAL_ORAUSER4"입니다.


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
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in(0,1) )
,constraint CK_tbl_member_gymregsts check( gymregisterstatus in(0,1) )
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
,imgfilename                 nvarchar2(50)                    -- 첨부파일
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



create table tbl_sport    
(sportseq                    NUMBER         not null          -- 종목번호
,sportname                   nvarchar2(20)  not null          -- 종목이름
,constraint PK_tbl_sport_sportseq primary key(sportseq)
);


create sequence seq_sport
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- Sequence SEQ_SPORT이(가) 생성되었습니다.\


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
,IP                          nvarchar2(20)  not null          -- 접속IP주소
,constraint PK_tbl_loginhistory_loginseq primary key(loginseq)
,constraint FK_tbl_loginhistory_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_LOGINHISTORY이(가) 생성되었습니다.

create table tbl_club    
(clubseq		NUMBER              not null        -- 동호회번호
,clubname		nvarchar2(20)       not null        -- 동호회명
,sportseq		NUMBER              not null        -- 종목번호(tbl_sport(sportseq) fk)
,fk_userid		nvarchar2(20)       not null        -- 회장아이디(tbl_member(userid) fk)
,clubtel		nvarchar2(50)       not null        -- 연락처
,clubarea		nvarchar2(20)       not null        -- 지역     
,clubgym		nvarchar2(20)       not null        -- 활동구장
,clubtime	    nvarchar2(30)       not null        -- 운영시간
,membercount	NUMBER              not null        -- 정원  
,clubpay	    NUMBER              not null        -- 회비
,clubstatus	    NUMBER(1)           not null        -- 동호회상태
,clubscore	    NUMBER              not null        -- 점수
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




create table tbl_clubboard    
(clubboardseq		NUMBER              not null        -- 동호회게시판번호
,clubseq		    NUMBER              not null        -- 동호회번호(tbl_club(clubseq) fk)
,title		        nvarchar2(50)       not null        -- 글제목
,content		    nvarchar2(1000)     not null        -- 글내용
,fk_userid		    nvarchar2(20)       not null        -- 회장아이디(tbl_member(userid) fk)
,registerdate		DATE                not null        -- 작성일자
,password		    nvarchar2(20)       not null        -- 글암호   
,commentcount		NUMBER              not null        -- 댓글수
,viewcount	        NUMBER              not null        -- 조회수
,status	            number(1)           not null        -- 삭제유무
,imgfilename	    nvarchar2(50)                       -- 첨부파일
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




