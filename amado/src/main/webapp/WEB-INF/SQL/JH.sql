select *
from tbl_member

insert into tbl_member(userid, password, name, email, postcode, address, detailaddress, extraaddress, mobile, gender, birthday, registerday, lastpwdchangedate, status, memberrank, gymregisterstatus, speed, quick, power, earth, stretch)
values('eomjh', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '엄정수', '6IgBZkV4vNkPy8EhtvIxpg==', '05237', '서울 강동구 아리수로 46', '201동 101호', ' (암사동)', 'ThNxMGRJwvIZWWACIcQN3g==', 1, '1967-06-08', default, default, default, default, default, default, default, default, default, default);

insert into tbl_member(userid, password, name, email, postcode, address, detailaddress, extraaddress, mobile, gender, birthday, registerday, lastpwdchangedate, status, memberrank, gymregisterstatus, speed, quick, power, earth, stretch)
values('leess', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이순대', '2IjrnBPpI++CfWQ7CQhjIw====', '05237', '서울 강동구 아리수로 46', '201동 101호', ' (암사동)', 'ThNxMGRJwvIZWWACIcQN3g==', 1, '1997-06-08', default, default, default, default, default, default, default, default, default, default);

insert into tbl_member(userid, password, name, email, postcode, address, detailaddress, extraaddress, mobile, gender, birthday, registerday, lastpwdchangedate, status, memberrank, gymregisterstatus, speed, quick, power, earth, stretch)
values('chaew', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '차은우', '+5sBqvRKpvd52ZLajN32Dg==', '05237', '서울 강동구 아리수로 46', '201동 101호', ' (암사동)', 'ThNxMGRJwvIZWWACIcQN3g==', 1, '1987-06-08', default, default, default, default, default, default, default, default, default, default);

insert into tbl_member(userid, password, name, email, postcode, address, detailaddress, extraaddress, mobile, gender, birthday, registerday, lastpwdchangedate, status, memberrank, gymregisterstatus, speed, quick, power, earth, stretch)
values('leejy', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '내가제일예뻐', 'UFSS8FyOaNcv36yAYtD1Mrbb8aiEN8J+acRHHdsZQrY=', '05237', '서울 강동구 아리수로 46', '201동 101호', ' (암사동)', 'ThNxMGRJwvIZWWACIcQN3g==', 1, '2000-08-06', default, default, default, default, default, default, default, default, default, default);



commit


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
