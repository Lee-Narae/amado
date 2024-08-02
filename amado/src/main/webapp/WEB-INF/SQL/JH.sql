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


select *
from tbl_fleamarketcomment;

select *
from tbl_fleamarket;

insert into tbl_fleamarketcomment(fleamarketcommentseq, fleamarketseq, comment_text, registerdate, fk_userid)
values(1, 1, '구매하고 싶은데 에눌 가능할까요?ㅎㅎ', default, 'chaew');



select *
from tbl_sport;

select *
from tbl_fleamarket

select *
from tbl_member


insert into tbl_fleamarket(fleamarketseq, sportseq, city, title, content, cost, deal, fk_userid, registerdate, password, status)
values(1, 1, '서울', '호날두가 신었던 축구화 팝니다!!', '제가 직접 신었답니다ㅎㅎ', 50000000, '직거래', 'leejy', default, '1234', 0);

ALTER TABLE tbl_member ADD (memberImg VARCHAR2(50));
ALTER TABLE tbl_gym ADD (insidestatus number(1));
ALTER TABLE tbl_fleamarketcomment ADD (changestatus number(1) default 0);
ALTER TABLE tbl_fleamarketcomment ADD (recommentcount number(5) default 0);
ALTER TABLE tbl_club ADD (viewcount number(10) default 0);
ALTER TABLE tbl_matching ADD (result2 NUMBER default 0);
ALTER TABLE tbl_matching ADD (score1 number(3));
ALTER TABLE tbl_matching ADD (score2 number(3));
ALTER TABLE tbl_gym ADD (lng number); -- 경도
ALTER TABLE tbl_gym ADD (lat number); -- 위도
          

update tbl_fleamarket set commentCount = commentCount+1
where fleamarketseq = 1


insert into tbl_fleamarketcomment(fleamarketcommentseq, fleamarketseq, comment_text, registerdate, fk_userid)
values(seq_fleamarket.nextval, 1, 'ㅎㅇㅎㅇ', default, 'leess')


insert into tbl_fleamarketcomment(fleamarketcommentseq, fleamarketseq, comment_text, registerdate, fk_userid)
values(seq_fleamarketcomment.nextval, 1, 'ㅎㅇㅎㅇ2', default, 'leess')
        
commit

update tbl_fleamarket set commentcount = commentcount+1
where fleamarketseq = 1

update tbl_club set fk_sportseq = 1
where clubname = '최준혁과 친구들'

update tbl_member set memberImg = '차은우.jpg'
where userid = 'chaew';


update tbl_fleamarketcomment set comment_text = '수정했습니다', registerdate = sysdate
where fleamarketcommentseq = 21

select *
from tbl_fleamarketcomment

select *
from tbl_sport

select *
from tbl_fleamarketcommentreply


select fleamarketcommentseq, fk_userid, comment_text
		     , to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
             ,V.memberimg
from tbl_fleamarketcomment A join tbl_member V
ON A.fk_userid = V.userid
where A.fleamarketseq = 1
order by fleamarketcommentseq desc

select *
from tbl_gymanswer

ALTER TABLE tbl_gym
MODIFY (lng number not null);

ALTER TABLE tbl_club
MODIFY (clubstatus DEFAULT 1);

ALTER TABLE tbl_matching
MODIFY (result NUMBER DEFAULT 0);

commit

ALTER TABLE tbl_matching
MODIFY (result NUMBER DEFAULT 0);

ALTER TABLE tbl_matching RENAME COLUMN result TO result1;
ALTER TABLE tbl_matching RENAME COLUMN clubseq2 TO clubseq1;
ALTER TABLE tbl_matching RENAME COLUMN clubseq TO clubseq2;
commit



create table tbl_fleamarketcommentreply    
(fleamarketcommentreplyseq      NUMBER                  -- 댓글번호(PK)
,fleamarketcommentseq             NUMBER                  -- 중고마켓게시판번호(FK)
,commentreply_text              nvarchar2(200)          -- 댓글내용
,registerdate              date default sysdate  not null                     -- 댓글작성일자
,fk_userid                 nvarchar2(20)           -- 아이디(FK)
,changestatus              number(1)        default 0

,constraint PK_tbl_fktcommentre_fmkcmreseq primary key(fleamarketcommentreplyseq)
,constraint FK_tbl_fktcommentre_fmketcmseq foreign key(fleamarketcommentseq) references tbl_fleamarketcomment(fleamarketcommentseq)
,constraint FK_tbl_fktcommentre_fk_userid foreign key(fk_userid) references tbl_member(userid)
);

-- Table TBL_FLEAMARKETCOMMENTREPLY이(가) 생성되었습니다.


create sequence seq_fleamarketcommentreplyseq 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_FLEAMARKETCOMMENTREPLYSEQ이(가) 생성되었습니다.

insert into tbl_fleamarketcommentreply(fleamarketcommentreplyseq, fleamarketcommentseq, commentreply_text, fk_userid)
values(seq_fleamarketcommentreplyseq.nextval, 10, '10번의 답글입니다', 'leess')
        
insert into tbl_fleamarketcommentreply(fleamarketcommentreplyseq, fleamarketcommentseq, commentreply_text, fk_userid)
values(seq_fleamarketcommentreplyseq.nextval, 15, '15번의 답글입니다', 'leejy')

insert into tbl_fleamarketcommentreply(fleamarketcommentreplyseq, fleamarketcommentseq, commentreply_text, fk_userid)
values(seq_fleamarketcommentreplyseq.nextval, 15, '15번의 답글입니다2', 'eomjh')

commit




select fleamarketcommentreplyseq, fk_userid, commentreply_text, changestatus
		     , to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
             , V.memberimg
from tbl_fleamarketcommentreply A join tbl_member V
ON A.fk_userid = V.userid
where A.fleamarketcommentseq = #{fleamarketcommentseq}
order by fleamarketcommentreplyseq desc




select clubseq, clubname, clubimg, fk_sportseq, fk_userid, clubtel, city, local, clubgym, clubtime, membercount, clubpay, clubstatus, clubscore, viewcount
from tbl_club
where clubseq = 3

update tbl_club set clubimg = 'real_madrid.png'
where clubseq = 17;

commit

select *
from tbl_matching

select *
from tbl_club

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(seq_matching.nextval, 1, 2, 3, 1, 2, 2, 1)

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(seq_matching.nextval, 2, 2, 3, 1, 2, 3, 1)

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(seq_matching.nextval, 9, 2, 3, 1, 2, 1, 0)

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(seq_matching.nextval, 10, 2, 3, 2, 1, 0, 2)

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(seq_matching.nextval, 13, 15, 3, 3, 3, 1, 1)

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(seq_matching.nextval, 14, 29, 3, 1, 2, 2, 1)

insert into tbl_matching(matchingseq, matchingregseq, clubseq1, clubseq2, result1, result2, score1, score2)
values(seq_matching.nextval, 15, 3, 9, 2, 1, 1, 3)



select *
from tbl_matchingreg
where sportseq = 1

select *
from tbl_matching

select *
from tbl_club
DROP SEQUENCE seq_matching;

create sequence seq_matching 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit

delete from tbl_gym



SELECT m.matchingseq, m.result1, m.result2, m.score1, m.score2, c1.clubname AS clubname1, c2.clubname AS clubname2, r.area, to_char(r.matchdate, 'YYYY-MM-DD') AS matchdate
FROM tbl_matching m
JOIN tbl_club c1 ON m.clubseq1 = c1.clubseq
JOIN tbl_club c2 ON m.clubseq2 = c2.clubseq
JOIN tbl_matchingreg r ON m.matchingregseq = r.matchingregseq
where m.clubseq2 = 3 or m.clubseq1 = 3
order by matchingseq asc;


select *
from tbl_gym

update tbl_gym set lng = '126.927552968846', lat='37.5805909247428'
where gymseq = 79

update tbl_gym set lng = '126.928156401761', lat='37.5128937581565'
where gymseq = 77

update tbl_gym set lng = '126.893803396338', lat='37.5333917967991'
where gymseq = 78

update tbl_gym set lng = '126.944090214952', lat='37.5637750959193'
where gymseq = 80

update tbl_gym set lng = '126.84571196058', lat='37.5592796685251'
where gymseq = 81

select lng, lat
from tbl_gym

select gymname, address, detailaddress, cost, orgfilename
from tbl_gym
where gymseq = 77



create table tbl_gymres
(gymresseq      NUMBER                       -- 댓글번호(PK)
,fk_gymseq      NUMBER          not nul      -- 중고마켓게시판번호(FK)
,gymresdate     date            not nul      -- 예약날짜
,gymrestime0     number default 0            -- 예약시간
,gymrestime1     number default 0            -- 예약시간
,gymrestime2     number default 0            -- 예약시간
,gymrestime3     number default 0            -- 예약시간
,gymrestime4     number default 0            -- 예약시간
,gymrestime5     number default 0            -- 예약시간
,gymrestime6     number default 0            -- 예약시간
,gymrestime7     number default 0            -- 예약시간
,gymrestime8     number default 0            -- 예약시간
,gymrestime9     number default 0            -- 예약시간
,gymrestime10     number default 0            -- 예약시간
,gymrestime11     number default 0            -- 예약시간
,gymrestime12     number default 0            -- 예약시간
,gymrestime13     number default 0            -- 예약시간
,gymrestime14     number default 0            -- 예약시간
,gymrestime15     number default 0            -- 예약시간
,gymrestime16     number default 0            -- 예약시간
,gymrestime17     number default 0            -- 예약시간
,gymrestime18     number default 0            -- 예약시간
,gymrestime19     number default 0            -- 예약시간
,gymrestime20     number default 0            -- 예약시간
,gymrestime21     number default 0            -- 예약시간
,gymrestime22     number default 0            -- 예약시간
,gymrestime23     number default 0            -- 예약시간

,constraint PK_tbl_gymres_gymresseq primary key(gymresseq)
,constraint FK_tbl_gymres_fk_gymseq foreign key(fk_gymseq) references tbl_gym(gymseq)
);

CREATE TABLE tbl_gymtime (
    fk_gymseq      NUMBER NOT NULL,          -- 체육관 번호(FK)
    gymrestime0    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime1    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime2    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime3    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime4    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime5    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime6    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime7    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime8    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime9    NUMBER DEFAULT 0,         -- 예약시간
    gymrestime10   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime11   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime12   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime13   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime14   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime15   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime16   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime17   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime18   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime19   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime20   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime21   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime22   NUMBER DEFAULT 0,         -- 예약시간
    gymrestime23   NUMBER DEFAULT 0,         -- 예약시간
    CONSTRAINT FK_tbl_gymres_fk_gymseq FOREIGN KEY (fk_gymseq) REFERENCES tbl_gym (gymseq)
);

CREATE TABLE tbl_gymdate (
    fk_gymseq      NUMBER NOT NULL,          -- 체육관 번호(FK)
    gymresdate     DATE NOT NULL,            -- 예약날짜
    
    CONSTRAINT FK_tbl_gymres_fk_gymseq FOREIGN KEY (fk_gymseq) REFERENCES tbl_gym (gymseq)
);

CREATE TABLE tbl_gymres (
    gymresseq NUMBER PRIMARY KEY,
    fk_gymseq NUMBER NOT NULL,                    -- 체육관 ID (외래 키)
    fk_userid nvarchar2(20),                           -- 사용자 ID (외래 키, 선택 사항)
    reservation_date DATE NOT NULL,           -- 예약 날짜
    time nvarchar2(20) NOT NULL,           -- 예약 시간대 ('HH24:MI' 형식)
    CONSTRAINT fk_gymseq FOREIGN KEY (fk_gymseq) REFERENCES tbl_gym(gymseq),
    constraint FK_tbl_gymres_fk_userid foreign key(fk_userid) references tbl_member(userid)
    
);

ALTER TABLE tbl_gymres
add (coinmoney nvarchar2(20));



commit

create sequence seq_gymresseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit

insert into tbl_gymres(gymresseq, fk_gymseq, fk_userid, reservation_date, time)
values(seq_gymresseq.nextval, 77, choijh, TO_DATE('2024-07-20', 'YYYY-MM-DD'), '00:00');

select *
from tbl_gymres
where fk_userid = 'choijh'-- and reservation_date = '24-07-25'
order by reservation_date asc;

where reservation_date = '24-07-25';

select cost
from tbl_gymres r
join tbl_gym g
on r.fk_gymseq = g.gymseq
where reservation_date = '24-07-25' and gymseq = 80;


SELECT
    reservation_date,
    MIN(time) || ' ~ ' || MAX(time) AS time_range
FROM
    tbl_gymres
GROUP BY
    reservation_date
ORDER BY
    reservation_date;
    
    




WITH time_data AS (
    SELECT
        gymresseq,
        fk_gymseq,
        fk_userid,
        reservation_date,
        TO_DATE(time, 'HH24:MI') AS reservation_time,
        LAG(TO_DATE(time, 'HH24:MI')) OVER (
            PARTITION BY fk_gymseq, fk_userid, reservation_date
            ORDER BY TO_DATE(time, 'HH24:MI')
        ) AS prev_time
    FROM
        tbl_gymres
    WHERE
        fk_userid = 'choijh'
),
grouped_data AS (
    SELECT
        gymresseq,
        fk_gymseq,
        fk_userid,
        reservation_date,
        reservation_time,
        prev_time,
        SUM(
            CASE
                WHEN reservation_time = prev_time + INTERVAL '60' MINUTE THEN 0
                ELSE 1
            END
        ) OVER (
            PARTITION BY fk_gymseq, fk_userid, reservation_date
            ORDER BY reservation_time
        ) AS grp
    FROM
        time_data
),
final_groups AS (
    SELECT
        fk_gymseq,
        fk_userid,
        reservation_date,
        MIN(reservation_time) AS start_time,
        MAX(reservation_time) AS end_time
    FROM
        grouped_data
    GROUP BY
        fk_gymseq,
        fk_userid,
        reservation_date,
        grp
)
SELECT
    fk_gymseq,
    fk_userid,
    reservation_date,
    TO_CHAR(start_time, 'HH24:MI') || ' ~ ' || TO_CHAR(end_time, 'HH24:MI') AS time_range
FROM
    final_groups
ORDER BY
    fk_gymseq, fk_userid, reservation_date, start_time;





WITH time_data AS (
		    SELECT
		        gymresseq,
		        fk_gymseq,
		        fk_userid,
		        coinmoney,
		        reservation_date,
		        TO_DATE(time, 'HH24:MI') AS reservation_time,
		        LAG(TO_DATE(time, 'HH24:MI')) OVER (
		            PARTITION BY fk_gymseq, fk_userid, reservation_date
		            ORDER BY TO_DATE(time, 'HH24:MI')
		        ) AS prev_time
		    FROM
		        tbl_gymres
		    WHERE
		        fk_userid = 'choijh'
		),
		grouped_data AS (
		    SELECT
		        gymresseq,
		        fk_gymseq,
		        coinmoney,
		        fk_userid,
		        reservation_date,
		        reservation_time,
		        prev_time,
		        SUM(
		            CASE
		                WHEN reservation_time = prev_time + INTERVAL '60' MINUTE THEN 0
		                ELSE 1
		            END
		        ) OVER (
		            PARTITION BY fk_gymseq, fk_userid, reservation_date
		            ORDER BY reservation_time
		        ) AS grp
		    FROM
		        time_data
		),
		final_groups AS (
		    SELECT
		        fk_gymseq,
		        fk_userid,
		        coinmoney,
		        reservation_date,
		        MIN(reservation_time) AS start_time,
		        MAX(reservation_time) AS end_time
		    FROM
		        grouped_data
		    GROUP BY
		        fk_gymseq,
		        fk_userid,
		        coinmoney,
		        reservation_date,
		        grp
		)
		SELECT
		    fk_gymseq,
		    fk_userid,
		    coinmoney,
		    reservation_date,
		    TO_CHAR(start_time, 'HH24:MI') || ' ~ ' || TO_CHAR((CAST(end_time AS TIMESTAMP) + INTERVAL '1' HOUR), 'HH24:MI') AS time_range
		FROM
		    final_groups
		ORDER BY
		     reservation_date, start_time;


select *
from tbl_gym


select count(time), g.gymname
from tbl_gymres r
join tbl_gym g
on r.fk_gymseq = g.gymseq
where time='16:00' and fk_gymseq = 77
group by g.gymname;


select g.gymname
from tbl_gymres r
join tbl_gym g
on r.fk_gymseq = g.gymseq
where r.fk_userid = 'leejy'

select *
from tbl_gymres
where fk_userid = 'leejy'

commit


WITH time_data AS (
    SELECT
        gymresseq,
        fk_gymseq,
        fk_userid,
        coinmoney,
        reservation_date,
        TO_DATE(time, 'HH24:MI') AS reservation_time,
        LAG(TO_DATE(time, 'HH24:MI')) OVER (
            PARTITION BY fk_gymseq, fk_userid, reservation_date
            ORDER BY TO_DATE(time, 'HH24:MI')
        ) AS prev_time
    FROM
        tbl_gymres
    WHERE
        fk_userid = 'choijh'
),
grouped_data AS (
    SELECT
        gymresseq,
        fk_gymseq,
        coinmoney,
        fk_userid,
        reservation_date,
        reservation_time,
        prev_time,
        SUM(
            CASE
                WHEN reservation_time = prev_time + INTERVAL '60' MINUTE THEN 0
                ELSE 1
            END
        ) OVER (
            PARTITION BY fk_gymseq, fk_userid, reservation_date
            ORDER BY reservation_time
        ) AS grp
    FROM
        time_data
),
final_groups AS (
    SELECT
        fk_gymseq,
        fk_userid,
        coinmoney,
        reservation_date,
        MIN(reservation_time) AS start_time,
        MAX(reservation_time) AS end_time,
        grp
    FROM
        grouped_data
    GROUP BY
        fk_gymseq,
        fk_userid,
        coinmoney,
        reservation_date,
        grp
)
SELECT
    fg.fk_gymseq,
    fg.fk_userid,
    fg.coinmoney,
    fg.reservation_date,
    TO_CHAR(fg.start_time, 'HH24:MI') || ' ~ ' || TO_CHAR((CAST(fg.end_time AS TIMESTAMP) + INTERVAL '1' HOUR), 'HH24:MI') AS time_range,
    g.gymname
FROM
    final_groups fg
JOIN
    tbl_gym g ON fg.fk_gymseq = g.gymseq
ORDER BY
    fg.reservation_date, fg.start_time;
    
    
    
    
    
    
SELECT *
FROM tbl_gymres
WHERE gymresseq IN (
    SELECT gymresseq
    FROM tbl_gymres
    WHERE fk_gymseq = 80
      AND fk_userid = 'choijh'
      AND reservation_date = TO_DATE('24/07/31', 'YY/MM/DD')
      AND TO_DATE(time, 'HH24:MI') BETWEEN TO_DATE('21:00', 'HH24:MI') AND TO_DATE('00:00', 'HH24:MI')
);    


select count(*)
from tbl_gymres
where fk_userid = 'choijh';




SELECT COUNT(*)
FROM (
    WITH time_data AS (
        SELECT
            gymresseq,
            fk_gymseq,
            fk_userid,
            coinmoney,
            reservation_date,
            TO_DATE(time, 'HH24:MI') AS reservation_time,
            LAG(TO_DATE(time, 'HH24:MI')) OVER (
                PARTITION BY fk_gymseq, fk_userid, reservation_date
                ORDER BY TO_DATE(time, 'HH24:MI')
            ) AS prev_time
        FROM
            tbl_gymres
        WHERE
            fk_userid = 'choijh'
    ),
    grouped_data AS (
        SELECT
            gymresseq,
            fk_gymseq,
            coinmoney,
            fk_userid,
            reservation_date,
            reservation_time,
            prev_time,
            SUM(
                CASE
                    WHEN reservation_time = prev_time + INTERVAL '60' MINUTE THEN 0
                    ELSE 1
                END
            ) OVER (
                PARTITION BY fk_gymseq, fk_userid, reservation_date
                ORDER BY reservation_time
            ) AS grp
        FROM
            time_data
    ),
    final_groups AS (
        SELECT
            fk_gymseq,
            fk_userid,
            coinmoney,
            reservation_date,
            MIN(reservation_time) AS start_time,
            MAX(reservation_time) AS end_time,
            grp
        FROM
            grouped_data
        GROUP BY
            fk_gymseq,
            fk_userid,
            coinmoney,
            reservation_date,
            grp
    )
    SELECT
        fg.fk_gymseq,
        fg.fk_userid,
        fg.coinmoney,
        fg.reservation_date,
        TO_CHAR(fg.start_time, 'HH24:MI') || ' ~ ' || TO_CHAR((CAST(fg.end_time AS TIMESTAMP) + INTERVAL '1' HOUR), 'HH24:MI') AS time_range,
        g.gymname
    FROM
        final_groups fg
    JOIN
        tbl_gym g ON fg.fk_gymseq = g.gymseq
) result_set; 






WITH time_data AS (
    SELECT
        gymresseq,
        fk_gymseq,
        fk_userid,
        coinmoney,
        reservation_date,
        TO_DATE(time, 'HH24:MI') AS reservation_time,
        LAG(TO_DATE(time, 'HH24:MI')) OVER (
            PARTITION BY fk_gymseq, fk_userid, reservation_date
            ORDER BY TO_DATE(time, 'HH24:MI')
        ) AS prev_time
    FROM
        tbl_gymres
    WHERE
        fk_userid = 'choijh'
),
grouped_data AS (
    SELECT
        gymresseq,
        fk_gymseq,
        coinmoney,
        fk_userid,
        reservation_date,
        reservation_time,
        prev_time,
        SUM(
            CASE
                WHEN reservation_time = prev_time + INTERVAL '60' MINUTE THEN 0
                ELSE 1
            END
        ) OVER (
            PARTITION BY fk_gymseq, fk_userid, reservation_date
            ORDER BY reservation_time
        ) AS grp
    FROM
        time_data
),
final_groups AS (
    SELECT
        fk_gymseq,
        fk_userid,
        coinmoney,
        reservation_date,
        MIN(reservation_time) AS start_time,
        MAX(reservation_time) AS end_time,
        grp
    FROM
        grouped_data
    GROUP BY
        fk_gymseq,
        fk_userid,
        coinmoney,
        reservation_date,
        grp
),
final_groups_with_rno AS (
    SELECT
        fg.fk_gymseq,
        fg.fk_userid,
        fg.coinmoney,
        fg.reservation_date,
        TO_CHAR(fg.start_time, 'HH24:MI') || ' ~ ' || TO_CHAR((CAST(fg.end_time AS TIMESTAMP) + INTERVAL '1' HOUR), 'HH24:MI') AS time_range,
        g.gymname,
        ROW_NUMBER() OVER (ORDER BY fg.reservation_date, fg.start_time) AS rno
    FROM
        final_groups fg
    JOIN
        tbl_gym g ON fg.fk_gymseq = g.gymseq
)
SELECT
    fk_gymseq,
    fk_userid,
    coinmoney,
    reservation_date,
    time_range,
    gymname
FROM
    final_groups_with_rno
WHERE rno BETWEEN 1 AND 6
ORDER BY
    reservation_date, time_range;
    
    
    select *
    from tbl_gym
    
    
select to_char(registerdate, 'YY-MM-DD HH24:MI') as registerdate
from tbl_fleamarket
where fleamarketseq = 50

select *
from tbl_fleamarket
where sportseq = 1


update tbl_fleamarket set viewcount = viewcount+1
		where fleamarketseq = 50