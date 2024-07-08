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

update tbl_fleamarket set commentCount = commentCount+1
where fleamarketseq = 1


insert into tbl_fleamarketcomment(fleamarketcommentseq, fleamarketseq, comment_text, registerdate, fk_userid)
values(seq_fleamarket.nextval, 1, 'ㅎㅇㅎㅇ', default, 'leess')


insert into tbl_fleamarketcomment(fleamarketcommentseq, fleamarketseq, comment_text, registerdate, fk_userid)
		values(seq_fleamarketcomment.nextval, 1, 'ㅎㅇㅎㅇ2', default, 'leess')
        
        commit

update tbl_fleamarket set commentcount = commentcount+1
where fleamarketseq = 1

update tbl_member set memberImg = '차은우.jpg'
where userid = 'chaew';


update tbl_fleamarketcomment set comment_text = '수정했습니다', registerdate = sysdate
where fleamarketcommentseq = 21

select *
from tbl_fleamarketcomment

select fleamarketcommentseq, fk_userid, comment_text
		     , to_char(registerdate, 'yyyy-mm-dd hh24:mi:ss') AS registerdate
             ,V.memberimg
from tbl_fleamarketcomment A join tbl_member V
ON A.fk_userid = V.userid
where A.fleamarketseq = 1
order by fleamarketcommentseq desc



ALTER TABLE tbl_club
MODIFY (clubscore DEFAULT 0);

ALTER TABLE tbl_club
MODIFY (clubstatus DEFAULT 1);

commit