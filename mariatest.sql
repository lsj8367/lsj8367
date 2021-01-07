-- 테이블 생성
-- 형식) create table 테이블명(칼럼명 자료형.... 제약조건);
USE test;
CREATE TABLE test(NO INT PRIMARY KEY, NAME VARCHAR(10) NOT NULL,
tel VARCHAR(15), inwon INT(5), addr VARCHAR(100))CHARSET=UTF8;


DESCRIBE test;-- 테이블의 구조 확인


-- 자료 추가
-- insert into 테이블명(칼럼명...) values(입력자료....)

INSERT INTO test(NO, NAME, tel, inwon, addr) VALUES(1,'인사과','111-1111',5,'역삼동123');
INSERT INTO test VALUES(2,'영업사과','111-2222',8,'역삼동123');
SELECT * FROM test;

-- 자료 수정

-- update 테이블명 set 칼럼명 = 수정할 값,... where 조건

UPDATE test SET NAME = '자재과', inwon=12 WHERE NO=2;
SELECT * FROM test;

-- 자료 삭제
-- delete from 테이블명 where 조건
-- truncate table 테이블명
DELETE FROM test WHERE NO=2;
SELECT * FROM test;

-- 테이블 작성할 때
-- 무결성 제약 조건 : 외부에서 잘못 입력된 자료를 막고자 입력 제약 조건을 줄 수 있다.
-- 기본키(primary key, pk) 제약 조건 : 중복 자료 입력 방지. 해당칼럼 unique, null 허용 x, ascending sort
CREATE TABLE aa(bun INT(5) PRIMARY KEY, irum CHAR(10));
INSERT INTO aa VALUES(1,'aa');
INSERT INTO aa VALUES(2,'bb');
INSERT INTO aa VALUES(3,'aa');
INSERT INTO aa(bun) VALUES(4);
INSERT INTO aa VALUES(5,'aa');
INSERT INTO aa VALUES(8,'aa');
INSERT INTO aa VALUES(6,'aa');
SELECT * FROM aa;
DROP TABLE aa;


CREATE TABLE aa(bun INT(5), irum CHAR(10), CONSTRAINT aa_bun_pk PRIMARY KEY(bun));
INSERT INTO aa VALUES(1,'aa');
SELECT * FROM aa;
SHOW INDEX FROM aa;
DROP TABLE aa;

-- Check 제약조건 : 특정 칼럼값 검사
CREATE TABLE aa(bun INT, irum CHAR(10), nai int(2) CHECK(nai >= 20));
INSERT INTO aa VALUES(1,'kbs',23);
INSERT INTO aa VALUES(2,'kbs',13); -- err 나이조건 성립 x.
ALTER TABLE aa ADD CONSTRAINT ck_main CHECK(irum IN('kbs','mbc'));
INSERT INTO aa VALUES(3,'mbc',23);
INSERT INTO aa VALUES(4,'tvn',23); -- err constraint 조건 성립 x.
SELECT * FROM aa;
DROP TABLE aa;

-- unique 제약조건 : 특정 칼럼값 중복 방지
CREATE TABLE aa(bun INT, irum CHAR(10) UNIQUE);
INSERT INTO aa VALUES(1,'kbs');
INSERT INTO aa VALUES(2,'kbs'); -- err 유니크 조건이 걸려있어서 안됨.
SELECT * FROM aa;
DROP TABLE aa;

-- 외부 키(창조 키, foreign key, fk) : 다른 테이블의 칼럼값을 참조 (fk의 대상은 pk)
-- on delete cascade : 참조 대상 테이블의 행이 삭제되는 경우 참조되는 테이블의 종속행을 모두 삭제.
CREATE TABLE sawon(bun INT PRIMARY KEY, irum VARCHAR(10) NOT NULL, buser CHAR(10))CHARSET=UTF8;
INSERT INTO sawon VALUES(1,'한송이','인사과');
INSERT INTO sawon VALUES(2,'박치기','인사과');
INSERT INTO sawon VALUES(3,'한송이','영업과');
SELECT * FROM sawon;

CREATE TABLE gajok(CODE INT PRIMARY KEY, NAME VARCHAR(10), birth DATETIME, sawon_bun INT,
FOREIGN KEY(sawon_bun) REFERENCES sawon (bun))CHARSET=utf8;

INSERT INTO gajok VALUES(100, '가나다',NOW(),1);
INSERT INTO gajok VALUES(110, '이기자','2000-01-11',2);
INSERT INTO gajok VALUES(120, '마바사',NOW(),5); -- error 사번이 5번이 없어서
INSERT INTO gajok VALUES(120, '김치국',NOW(),1);
DELETE FROM gajok WHERE CODE=120;
SELECT * FROM gajok;

DROP TABLE sawon WHERE bun=1; -- err 1번 가족자료가 있어서
DROP TABLE sawon WHERE bun=3; -- 3번을 참조하는 가족은 없어서 지울수있음.

DROP TABLE gajok; -- 사원이 남아있으면 가족은 지울수 없다.
DROP TABLE sawon;

-- default : 특정 칼럼에 초기값 부여, null 입력을  방지하는 효과
CREATE TABLE aa (bun INT, irum CHAR(10), juso VARCHAR(50));
INSERT INTO aa VALUES(1, NULL, NULL);
INSERT INTO aa(bun) VALUES(2);
DESC aa;
ALTER TABLE aa ALTER COLUMN juso SET DEFAULT 'seoul';
INSERT INTO aa(bun) VALUES(3);
INSERT INTO aa VALUES(4, NULL, NULL);
SELECT * FROM aa;
DROP TABLE aa;

CREATE TABLE aa (bun INT AUTO_INCREMENT PRIMARY KEY,
irum CHAR(10), juso VARCHAR(50) DEFAULT '역삼동')CHARSET=UTF8;

DESC aa;
INSERT INTO aa(bun, irum) VALUES(1, '한국인');
INSERT INTO aa(irum) VALUES('한사람');
INSERT INTO aa(irum, juso) VALUES('두사람', '서초동');
INSERT INTO aa VALUES(10,'홍길동', '신사동');
INSERT INTO aa(irum) VALUES('홍두깨');
SELECT * FROM aa;

-- 문제
CREATE TABLE 교수(교수코드 INT PRIMARY KEY,교수명 CHAR(10),연구실번호 INT CHECK(연구실번호>=100 AND 연구실번호<=500))CHARSET=UTF8;
INSERT INTO 교수 VALUES (1, '가나다', 201);
INSERT INTO 교수 VALUES (2, '아무개', 205);
INSERT INTO 교수 VALUES (3, '홍길동', 305);
INSERT INTO 교수 VALUES (4, '갑을병', 500);
SELECT * FROM 교수;
DROP TABLE 교수;

CREATE TABLE 과목(과목코드 INT AUTO_INCREMENT PRIMARY KEY, 과목명 CHAR(10) UNIQUE, 교재명 CHAR(10),
담당교수 INT, FOREIGN KEY(담당교수) REFERENCES 교수(교수코드))CHARSET=UTF8;
INSERT INTO 과목 VALUES (1, '자바', '자바책', 1);
INSERT INTO 과목 VALUES (2, '자', '자바책', 2);
INSERT INTO 과목 VALUES (3, '바', '자바책', 3);
INSERT INTO 과목 VALUES (4, '자바으', '자바책', 4);
INSERT INTO 과목 VALUES (5, '자바이', '자바책', 5);
SELECT * FROM 과목;
DROP TABLE 과목;

CREATE TABLE 학생 (학번 INT PRIMARY KEY, 학생명 CHAR(10),
수강과목 INT, FOREIGN KEY(수강과목) REFERENCES 과목(과목코드), 학년 INT)CHARSET=UTF8;
INSERT INTO 학생  VALUES (102, '성성', 2, 2);
SELECT * FROM 학생;
DROP TABLE 학생;

-- index(색인) : 검색속도를 향상시키기 위해 검색이 빈번한 칼럼에 색인 부여
-- pk 칼럼은 자동으로 색인이 부여된다.
-- index를 사용해야 하는 경우 : 레코드 수가 많을때, join이 자주 등장할 때, null이 많이 포함된 칼럼 검색
-- index를 자제해야 하는 경우 : 입력,수정,삭제가 빈번한 테이블
-- inner join null아예 안나오고, outer는 null이 보임
EXPLAIN SELECT * FROM aa;
SHOW INDEX FROM aa;
-- 만들 때
CREATE INDEX ind_irum ON aa(irum); -- 인덱스 생성자
ALTER TABLE aa ADD INDEX ind_juso(juso); -- 인덱스를 이렇게 생성하는것도 가능하다.

-- 지울 때
ALTER TABLE aa DROP INDEX ind_juso; -- 이렇게 드롭을하여 지울수도 있다.
DROP INDEX ind_irum ON aa; -- 삭제할수 있음.
SHOW INDEX FROM aa;
DESC aa;

-- 2초동안 지우고 깨움
SELECT NOW(), SLEEP(2), NOW(); -- 2초동안 기다렸다가 출력 now가 구문안에 있다면 몇번나오든 값이 최종값 하나로만 나온다.
SELECT SYSDATE(), SLEEP(2), SYSDATE(); -- 2초를 흘려보내고 다시 출력 처음했을때의 시간과 2초를 흘려보낸 시간이 다르게 나온다.
DROP TABLE abc;
CREATE TABLE abc(num INT PRIMARY KEY, author CHAR(10), title VARCHAR(50) NOT NULL, bwrite DATETIME)CHARSET=utf8;
INSERT INTO abc VALUES(1,'홍길동','연습',NOW());
INSERT INTO abc VALUES(2,'고길동','연습',SYSDATE());
SELECT * FROM abc;

-- 테이블 관련 create table... alter table ... drop table...      alter table 옛이름 rename 새이름
SELECT * FROM aa;
ALTER TABLE aa RENAME kbs;
SELECT * FROM kbs;
ALTER TABLE kbs RENAME aa;

-- 칼럼 추가
ALTER TABLE aa ADD(job_id INT(6));
SELECT * FROM aa;

-- 칼럼명 변경
ALTER TABLE aa CHANGE job_id job_num INT;
SELECT * FROM aa;

-- 칼럼 type 변경
ALTER TABLE aa MODIFY job_num VARCHAR(5);
SELECT * FROM aa;

--칼럼 삭제
ALTER TABLE aa DROP COLUMN job_num;
SELECT * FROM aa;
DROP TABLE aa;
DROP TABLE abc;
DROP TABLE test;
--------------------------------------------------------------
-- select 본격 연습.

create table sangdata(
code int primary key,
sang varchar(20),
su int,
dan int) charset=utf8;

insert into sangdata values(1,'장갑',3,10000);
insert into sangdata values(2,'벙어리장갑',2,12000);
insert into sangdata values(3,'가죽장갑',10,50000);
insert into sangdata values(4,'가죽점퍼',5,650000);
SELECT * FROM sangdata;

create table buser(
buser_no int(4)  primary key, 
buser_name varchar(10) not null,
buser_loc varchar(10),
buser_tel varchar(15)) charset=utf8;

insert into buser values(10,'총무부','서울','02-100-1111');
insert into buser values(20,'영업부','서울','02-100-2222');
insert into buser values(30,'전산부','서울','02-100-3333');
insert into buser values(40,'관리부','인천','032-200-4444');

SELECT * FROM buser;

create table jikwon(
jikwon_no  int(4) primary key,
jikwon_name varchar(10) not null,
buser_num int(4) not null,
jikwon_jik  varchar(10) default '사원', 
jikwon_pay int,
jikwon_ibsail date,
jikwon_gen  varchar(4),
jikwon_rating char(3),
CONSTRAINT ck_jikwon_gen check(jikwon_gen='남' or jikwon_gen='여')) charset=utf8;

insert into jikwon values(1,'홍길동',10,'이사',9900,'2008-09-01','남','a');
insert into jikwon values(2,'한송이',20,'부장',8800,'2010-01-03','여','b');
insert into jikwon values(3,'이순신',20,'과장',7900,'2010-03-03','남','b');
insert into jikwon values(4,'이미라',30,'대리',4500,'2014-01-04','여','b');
insert into jikwon values(5,'이순라',20,'사원',3000,'2017-08-05','여','b');
insert into jikwon values(6,'김이화',20,'사원',2950,'2019-08-05','여','c');
insert into jikwon values(7,'김부만',40,'부장',8600,'2009-01-05','남','a');
insert into jikwon values(8,'김기만',20,'과장',7800,'2011-01-03','남','a');
insert into jikwon values(9,'채송화',30,'대리',5000,'2013-03-02','여','a');
insert into jikwon values(10,'박치기',10,'사원',3700,'2016-11-02','남','a');
insert into jikwon values(11,'김부해',30,'사원',3900,'2016-03-06','남','a');
insert into jikwon values(12,'박별나',40,'과장',7200,'2011-03-05','여','b');
insert into jikwon values(13,'박명화',10,'대리',4900,'2013-05-11','남','a');
insert into jikwon values(14,'박궁화',40,'사원',3400,'2016-01-15','여','b');
insert into jikwon values(15,'채미리',20,'사원',4000,'2016-11-03','여','a');
insert into jikwon values(16,'이유가',20,'사원',3000,'2016-02-01','여','c');
insert into jikwon values(17,'한국인',10,'부장',8000,'2006-01-13','남','c');
insert into jikwon values(18,'이순기',30,'과장',7800,'2011-11-03','남','a');
insert into jikwon values(19,'이유라',30,'대리',5500,'2014-03-04','여','a');
insert into jikwon values(20,'김유라',20,'사원',2900,'2019-12-05','여','b');
insert into jikwon values(21,'장비',20,'사원',2950,'2019-08-05','남','b');
insert into jikwon values(22,'김기욱',40,'대리',5850,'2013-02-05','남','a');
insert into jikwon values(23,'김기만',30,'과장',6600,'2015-01-09','남','a');
insert into jikwon values(24,'유비',20,'대리',4500,'2014-03-02','남','b');
insert into jikwon values(25,'박혁기',10,'사원',3800,'2016-11-02','남','a');
insert into jikwon values(26,'김나라',10,'사원',3500,'2016-06-06','남','b');
insert into jikwon values(27,'박하나',20,'과장',5900,'2012-06-05','여','c');
insert into jikwon values(28,'박명화',20,'대리',5200,'2013-06-01','여','a');
insert into jikwon values(29,'박가희',10,'사원',4100,'2016-08-05','여','a');
insert into jikwon values(30,'최미숙',30,'사원',4000,'2015-08-03','여','b');

create table gogek(
gogek_no  int(4) primary key,
gogek_name  varchar(10) not null,
gogek_tel  varchar(20),
gogek_jumin char(14),
gogek_damsano  int(4),
CONSTRAINT FK_gogek_damsano foreign key(gogek_damsano) references jikwon(jikwon_no)) charset=utf8;

insert into gogek values(1,'이나라','02-535-2580','850612-1156789',5);
insert into gogek values(2,'김혜순','02-375-6946','700101-1054225',3);
insert into gogek values(3,'최부자','02-692-8926','890305-1065773',3);
insert into gogek values(4,'김해자','032-393-6277','770412-2028677',13);
insert into gogek values(5,'차일호','02-294-2946','790509-1062677',2);
insert into gogek values(6,'박상운','032-631-1204','790623-1023566',6);
insert into gogek values(7,'이분','02-546-2372','880323-2558021',2);
insert into gogek values(8,'신영래','031-948-0283','790908-1063765',5);
insert into gogek values(9,'장도리','02-496-1204','870206-2063245',4);
insert into gogek values(10,'강나루','032-341-2867','780301-1070425',12);
insert into gogek values(11,'이영희','02-195-1764','810103-2070245',3);
insert into gogek values(12,'이소리','02-296-1066','810609-2046266',9);
insert into gogek values(13,'배용중','02-691-7692','820920-1052677',1);
insert into gogek values(14,'김현주','031-167-1884','800128-2062665',11);
insert into gogek values(15,'송운하','02-887-9344','830301-2013345',2);

SELECT * FROM sangdata;
SELECT * FROM buser;
SELECT * FROM jikwon;
SELECT * FROM gogek;

-- select [distinct] 테이블명.칼럼명[ as 별명].... [into 테이블명 ] from 테이블명.....
-- where 조건 ...order by 기준키[asc,desc]...
SELECT * FROM jikwon; -- jikwon으로부터 가지고 있는 모든 칼럼 출력
SELECT jikwon_no, jikwon_name, jikwon_pay FROM jikwon;
SELECT jikwon_name, jikwon_no, jikwon_pay FROM jikwon;
SELECT jikwon_name AS 사번, jikwon_no 직원명, jikwon_pay AS 연봉 FROM jikwon; -- as는 별명을 주는것. 제목을 바꾸는것. 동시에 바로 출력.
SELECT 10,'안녕',12 / 3 AS result FROM DUAL; -- dual은 가상의 테이블 물리적으로 존재하지는 않는다.
-- as 뒤에 오는것은 임의의 칼럼 이름이다.
SELECT jikwon_name AS 이름, jikwon_pay * 0.02 AS 세금 FROM jikwon; -- select 는 데이터 서버에서 램으로 읽어온다.

-- 정렬 : order by 칼럼명 [ ascending (오름) / descending (내림)] 차순
SELECT * FROM jikwon ORDER BY jikwon_pay ASC; -- jikwon_pay의 오름차순으로 데이터를 정렬
SELECT * FROM jikwon ORDER BY jikwon_jik ASC, jikwon_pay DESC; -- jikwon_jik 1차로 가나다 오름차순 정렬 후 pay로 2차 내림차순 정렬
SELECT * FROM jikwon ORDER BY jikwon_jik, jikwon_pay DESC; -- asc는 생략이 가능하다.
SELECT jikwon_no, jikwon_name, jikwon_pay / 100 * 100 AS pay FROM jikwon ORDER BY pay;

SELECT DISTINCT jikwon_jik FROM jikwon; -- 직원 직급의 종류, 중복을 없앤다.
SELECT DISTINCT jikwon_jik, jikwon_name FROM jikwon; -- X

-- 연산자 사용 : 우선순위 () > 산술 > 관계 > 비교 > is null, like, in > between, not > and > or
-- 비교연산 : =, !=, >, <, >=, <=, <>
-- 논리 연산 : and, or, not , between
SELECT * FROM jikwon WHERE jikwon_jik = '대리'; -- 날짜나 문자는 꼭 ''를 줘야한다.
SELECT * FROM jikwon WHERE jikwon_no = 3;
SELECT * FROM jikwon WHERE jikwon_no <= 3;
SELECT * FROM jikwon WHERE jikwon_no <> 3; -- 3번만 빼고 다 출력.
SELECT * FROM jikwon WHERE jikwon_no != 3; --3번만 빼고
SELECT * FROM jikwon WHERE jikwon_no = '3'; -- 숫자는 ''를 안줘도 무방하다.
SELECT * FROM jikwon WHERE jikwon_ibsail = '2010-03-03';
SELECT * FROM jikwon WHERE jikwon_ibsail = '10-03-03';

SELECT * FROM jikwon WHERE jikwon_no=3 OR jikwon_no=10;
SELECT * FROM jikwon WHERE jikwon_no=3 and jikwon_no=10; -- X 동시만족은 할수없음.
SELECT * FROM jikwon WHERE jikwon_jik = '사원' AND jikwon_gen = '남' AND jikwon_pay <= 4000; -- 각기 다른탭의 조건들을 동시만족하는것을 연산하여야한다.
SELECT * FROM jikwon WHERE jikwon_jik = '사원' AND (jikwon_gen = '여' or jikwon_ibsail >= '2017-1-1'); -- 괄호가 다시 우선순위

SELECT * FROM jikwon WHERE jikwon_no >= 5 AND jikwon_no <= 10; -- 밑의 구문과 같은 의미
SELECT * FROM jikwon WHERE jikwon_no BETWEEN 5 AND 10;
SELECT * FROM jikwon WHERE jikwon_no BETWEEN 5 AND 10;
SELECT * FROM jikwon WHERE jikwon_ibsail BETWEEN '2015-1-1' AND '2016-12-31';

SELECT * FROM jikwon WHERE jikwon_no < 5 OR jikwon_no > 20; -- 5미만 + 20초과인 사람들의 모임 긍정적 형태의 조건이 속도 증진
SELECT * FROM jikwon WHERE jikwon_no not BETWEEN 5 AND 20; -- 위와 같은 모임
SELECT * FROM jikwon WHERE jikwon_no BETWEEN 5 AND 20; -- 5이상 20이하의 사람들의 모임

SELECT * FROM jikwon WHERE jikwon_pay >= 3000 + 2000 + 5000 - 2000; -- 연산 후 >= 수행

SELECT * FROM jikwon WHERE jikwon_name = '홍길동';
SELECT * FROM jikwon WHERE jikwon_name >= '최'; -- 사전에서의 ㅊ 이후의 순서만 출력
SELECT ASCII('a'), ASCII('A'), ASCII('가'), ASCII('나') FROM DUAL; -- 아스키 코드
SELECT * FROM jikwon WHERE jikwon_name BETWEEN '김' AND '이'; -- 김씨에서 이씨 사이

-- in 조건 연산
SELECT * FROM jikwon WHERE jikwon_jik = '대리' OR jikwon_jik = '과장' OR jikwon_jik = '부장';
SELECT * FROM jikwon WHERE jikwon_jik IN('대리','과장','부장'); -- jikwon_jik 안의 대리,과장,부장을 출력
SELECT * FROM jikwon WHERE buser_num IN(10,30);

-- like 조건 연산 : %(0개 이상의 문자열), _(한 문자)
SELECT * FROM jikwon WHERE jikwon_name LIKE '이%'; -- jikwon_name중 '이' 로시작되고 뒤에 아무거나 포함된것 출력
SELECT * FROM jikwon WHERE jikwon_name LIKE '%라';
SELECT * FROM jikwon WHERE jikwon_name LIKE '%순%'; -- 아무데나 순이라는 글자가 존재하면 출력
SELECT * FROM jikwon WHERE jikwon_name LIKE '이%라'; -- 첫글자 이 끝글자 라인 jikwon_name 모든것을 출력 글자제한 X
SELECT * FROM jikwon WHERE jikwon_name LIKE '이_라'; -- 첫글자 '이' 두번째글자 '아무거나' 세번째글자 '라' _갯수만큼의 글자수를 필요함.
SELECT * FROM jikwon WHERE jikwon_name LIKE '__'; -- 이름이 2자인 사람들만 출력
SELECT * FROM jikwon WHERE jikwon_name LIKE '이순%' OR jikwon_name LIKE '이미%';

SELECT * FROM jikwon WHERE jikwon_pay LIKE '3%'; -- pay 앞자리 3이상만 출력

UPDATE jikwon SET jikwon_jik = NULL WHERE jikwon_no=5; -- null값을 5행인 애한테 준다.
SELECT * FROM jikwon WHERE jikwon_jik = NULL; -- null인자료 이렇게 부르면 안된다.
SELECT * FROM jikwon WHERE jikwon_jik IS NuLL; -- null인 자료를 출력하는 법

SELECT * FROM jikwon LIMIT 5; -- 출력 범위 제한
SELECT * FROM jikwon WHERE jikwon_jik = '사원' LIMIT 3;
SELECT * FROM jikwon WHERE jikwon_jik = '사원' LIMIT 2, 5; -- jikwon_jik 순서 두번째 다음에서부터 5개 출력

SELECT jikwon_no AS 직원번호, jikwon_name AS 직원명, jikwon_jik 직급, jikwon_pay 연봉,
jikwon_pay /12 AS 보너스, jikwon_ibsail AS 입사일 FROM jikwon;
WHERE jikwon_jik IN('과장','사원') AND
((jikwon_pay >= 4000 AND jikwon_ibsail BETWEEN '2015-1-1' AND '2019-12-31') OR
(jikwon_name LIKE '이%' AND jikwon_ibsail BETWEEN '2015-1-1' AND '2019-12-31'))
ORDER BY jikwon_jik, jikwon_pay DESC;


-- 내장 함수
-- 단일행 함수
-- 문자 함수
SELECT LOWER('HellO'), UPPER('HellO') FROM DUAL; -- 대소문자 함수
SELECT CONCAT('hello','world') FROM DUAL; -- 문자열끼리 합쳐줌
SELECT SUBSTR('hello world', 3) FROM DUAL; -- 세번째 글자부터 출력
SELECT SUBSTR('hello world', 3, 3) FROM DUAL; -- 세번째 글자부터 세글자만 출력
SELECT SUBSTR('hello world', -3, 3) FROM DUAL; -- 맨 끝부터 세글자
SELECT LENGTH('hello world') FROM DUAL; -- ''안의 문자열 총길이
SELECT INSTR('hello world', 'e') FROM DUAL; -- e는 몇번째에있는가
SELECT LPAD('Hello', 10, '*') FROM DUAL; -- 열자리중에 선언해준 hello를 제외한 나머지는 *로 채운다. 왼쪽부터
SELECT RPAD('Hello', 10, '*') FROM DUAL; -- 위와 같지만  오른쪽부터 *로 채움.
SELECT TRIM(' aabb bbaa '); -- 문자열앞뒤의 공백을 잘라준다.
SELECT LTRIM(' aabb bbaa '); -- 왼쪽만 지움
SELECT TRIM(' aabb bbaa '); -- 오른쪽만 지움
SELECT REPLACE('010.111.1234', '.','-'); -- ''안의 문자열의 .을 -로 바꿔준다.


-- 문) jikwon 테이블에서 이름에 '이'가 포함된 직원이 있다면 '이'부터 두 글자 출력
-- 예) 이순신 : 이순		김이배 : 이배		를 출력하라.

SELECT * FROM jikwon WHERE jikwon_name LIKE '%이%';

SELECT jikwon_name, SUBSTR(jikwon_name , INSTR(jikwon_name, '이'), 2) FROM jikwon WHERE jikwon_name LIKE '이%' OR jikwon_name LIKE '%이_';
-- 또는 where jikwon_name like '%이%';  문제가 애매함.

-- 숫자 함수
SELECT ROUND(45.678, 2), ROUND(45.678), ROUND(45.678,0), ROUND(45.678, -1); --  round( xx, 2) --> 소수점 둘째자리까지 표현
-- round(xx.xx) --> 소수점 첫째자리에서 반올림 만약 (xx.xx, 0) 이면 반올림 후 소수점 또는 0 버리는것.
SELECT jikwon_name, jikwon_pay, round(jikwon_pay * 0.025, 0) AS tex FROM jikwon WHERE jikwon_no <= 5;

SELECT TRUNCATE(45.678, 0),  TRUNCATE(45.678, 1), TRUNCATE(45.678, -1);
-- truncate(xx.xxx, 0,1,-1) 0은 45만 남겨둠 1은 첫째자리까지 출력후 버림, 십의자리에서 밑은  다 버린다.
SELECT MOD(15, 2), 15 % 2, 15 MOD 2; -- 나머지를 구하는 함수, 연산자, 오버라이딩 가능 셋다 같은 의미

SELECT GREATEST(15, 4, 6, 8), LEAST(15, 4, 6, 8), POW(2,3), SQRT(8); -- pow 는 (2,3) 이면 2의 3제곱
-- greatest 는 최고값, least 는 최소값, pow 는 x의 y제곱, sqrt는 루트값

-- 날짜함수
SELECT CURDATE(), CURDATE() + 0, NOW(), NOW() + 0, SYSDATE(), SYSDATE() + 0;
-- curdate는 db서버의 현재 날짜, +0을 해버리면 -구분없이 00000000이렇게 출력된다.
-- now는 최종값만, sysdate는 처음 최종 둘다 출력 가능하다.

SELECT ADDDATE('2020-07-29', 10), ADDDATE('2020-07-29', -10), ADDDATE('2020-07-29', -1000);  -- 내부적으로 윤년체크도 가능하며 날짜 정한것에 , 후 뒤에는 +- 일수
SELECT SUBDATE('2020-07-29', 10) a, SUBDATE('2020-07-29', -10) b, SUBDATE('2020-07-29', -1000) AS c; -- 양수가 빼주는것, 음수가 더해주는것

SELECT NOW(), DATE_ADD(NOW(),INTERVAL 5 MINUTE); -- interval은 1분 더해줌
SELECT NOW(), DATE_ADD(NOW(),INTERVAL 5 DAY);
SELECT NOW(), DATE_ADD(NOW(),INTERVAL 5 MONTH);
SELECT NOW(), DATE_SUB(NOW(),INTERVAL 5 YEAR); -- add의 반대는 sub여서 빼준다.

SELECT DATEDIFF(NOW(), '2017-03-01'); -- 일수차이를 구함
SELECT TIMEDIFF('23:23:59', '12:11:10'); -- 시간차이를 시 : 분 : 초
SELECT TIMESTAMPDIFF(QUARTER,'2020-07-29', '2020-12-29'), TIMESTAMPDIFF(HOUR,'2020-07-29', '2020-08-12'); 
-- 분기의 차이 quarter, hour 시간의 차이보여줌

SELECT SYSDATE(), LAST_DAY(SYSDATE()), DAYOFYEAR(SYSDATE()); -- 현재시간, 이달의 마지막날, 올해의 며칠 + 1?

-- 형변환
SELECT DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(NOW(),'%Y-%m-%d'), DATE_FORMAT(NOW(),'%Y년%m월%d일'); -- 년 : 월 : 일
select DATE_FORMAT(NOW(),'%H:%i:%s'); -- 시:분:초

SELECT DATE_FORMAT(NOW(),'%d'), DATE_FORMAT(NOW(),'%j'), DATE_FORMAT(NOW(),'%a'), DATE_FORMAT(NOW(),'%w');
-- 이달의 며칠, 365일중 며칠, 무슨요일, 요일이 몇번째인지 숫자로 표현 0이 sunday

SELECT jikwon_name, DATE_FORMAT(jikwon_ibsail, '%W') FROM jikwon WHERE jikwon_jik = '부장';
-- 부장직급의 이름, 입사일 기준 무슨요일 입사?

SELECT CAST(1234.567 AS INTEGER) AS aa, CAST(1234.567 AS CHAR(7)) AS bb, CONVERT(1234.567, INTEGER) AS cc;
-- integer로 숫자화		char로 문자화 . 도 센다  7자리 표현 convert는 cast ( xxx.xxx as integer)와 똑같은 기능을 가졌음.
SELECT CAST('2020/07/29' AS DATE), CAST('2020$07$29' AS DATE), CAST('2020-07-29' AS DATE);
-- 숫자안에 어떤 /나 $ 가 들어가도 as date로 묶는다면 문자형식이었던 숫자 문자열을 날짜형식으로 바뀐다.
SELECT STR_TO_DATE('2020-07-29', '%Y-%m-%d'); -- 문자열을 %Y%m%d를 통해 날짜로 형변환을 함.

SELECT FORMAT(1234.567, 2), FORMAT(1234.567, 0), ROUND(1234.567, -2); -- xxx.xxx, +1이면 반올림 후 소수점 첫째자리까지 문자로 추출
-- format 0이면 정수부분을 반올림한 상태로 문자로 추출 round는 -1 이면 소수점 첫째자리 반올림 후 정수로 바꿈
-- ...

-- rank (), dense_rank() : 순위를 결정하는 함수
SELECT jikwon_no, jikwon_name, jikwon_pay, rank() over(ORDER BY jikwon_pay) AS rank, -- rank는 공동 순위 있으면 ex 공동 2등 두명 다음 4 더해줘서 출력
dense_rank() over(ORDER BY jikwon_pay) AS drank FROM jikwon; -- ascending sort 			drank는 공동순위 ex)공동 2등 두명  있어도 다음 3 순위를 찍음

SELECT jikwon_no, jikwon_name, jikwon_pay, rank() over(ORDER BY jikwon_pay desc) AS rank, -- rank는 공동 순위 있으면 그만큼 더해줘서 출력
dense_rank() over(ORDER BY jikwon_pay desc) AS drank FROM jikwon; -- decending sort


UPDATE jikwon SET jikwon_pay = NULL WHERE jikwon_no = 5;
SELECT * FROM jikwon WHERE jikwon_no <= 8;

-- NVL(val1, val2) : val1이 null이면 val2를 적용시킨다
SELECT jikwon_name, nvl(jikwon_jik, '임시직'), nvl(jikwon_pay,0) FROM jikwon WHERE jikwon_no <= 6;

-- NVL2(val1, val2, val3) : val1이 null인지 평가, null이면 val3 , 아니면 val2
SELECT jikwon_name, nvl2(jikwon_jik, '정규직','임시직'), nvl2(jikwon_pay, jikwon_pay + 1000, 0) FROM jikwon WHERE jikwon_no <= 6;

-- nullif(val1,val2) : 두 개의 값이 일치하면 null을, 일치하지 않으면 val1 을 치환한다.
SELECT NULLIF(LENGTH('abcd'),LENGTH('123'));
SELECT NULLIF(LENGTH('abc'),LENGTH('123'));
SELECT jikwon_name, jikwon_jik, NULLIF(jikwon_jik,'대리') FROM jikwon;

-- 조건 표현식
-- 형식 1)
SELECT
case 10 / 5 -- 10 나누기 5
when 5 then '안녕' -- 몫이 5라면 '안녕'출력
when 2 then '반가워' -- 몫이 2라면 반가워
ELSE '잘가' -- 둘다 아니면 잘가
END AS 결과 -- 제목을 결과
FROM DUAL;

SELECT jikwon_name, case jikwon_pay when 3000 then '어라 삼천이네' when 4500 then '와우 4500'
ELSE '그 외 연봉' END AS result FROM jikwon;

-- 자바형식
-- "SELECT jikwon_name, case jikwon_pay when 3000 then '어라 삼천이네' when 4500 then '와우 4500'
--  ELSE '그 외 연봉' END AS result FROM jikwon" 이렇게 문자열로 들어와진다.

SELECT jikwon_name, jikwon_pay, jikwon_jik,
case jikwon_jik
when '이사' then jikwon_pay * 0.05
when '부장' then jikwon_pay * 0.04
when '과장' then jikwon_pay * 0.03
ELSE jikwon_pay * 0.05 END AS donation, jikwon_gen FROM jikwon;

-- 형식 2)
SELECT jikwon_name,
case
when jikwon_gen='남' then 'M'
when jikwon_gen='여' then 'F'
END AS gender
FROM jikwon;

SELECT jikwon_name, jikwon_pay,
case
when jikwon_pay >= 7000 then '양호'
when jikwon_pay >= 5000 then '보통'
ELSE '저조' END AS result
FROM jikwon;

-- if 조건 표현식
SELECT jikwon_name, jikwon_pay, jikwon_jik, if(TRUNCATE(jikwon_pay / 1000, 0) >= 5, 'good', 'normal') AS result FROM jikwon;
-- truncate 1000으로 pay를 나누었을때 몫이 5 이상이면 good, 이하면 normal출력 하여라




-- 문제1) 5년 이상 근무하면 '감사합니다', 그 외는 '열심히' 라고 표현 ( 2010 년 이후 직원만 참여 )
--        특별수당(pay를 기준) : 5년 이상 5%, 나머지 3% (정수로 표시:반올림)
-- 출력 형태 ==>   직원명   근무년수      표현           특별수당
--   					홍길동     11       감사합니다         150

SELECT jikwon_name, date_format(jikwon_ibsail, '%Y') <= 10 AS '근무년수' FROM jikwon; 

SELECT jikwon_name AS 직원명,(date_format(NOW(),'%Y') - (date_format(jikwon_ibsail, '%Y'))) AS '근무년수',
case
when (date_format(NOW(),'%Y') - (date_format(jikwon_ibsail, '%Y'))) >= 5 then '감사합니다'
ELSE '열심히' END AS '표현',
case
when (date_format(NOW(),'%Y') - (date_format(jikwon_ibsail, '%Y'))) >= 5 then ROUND(jikwon_pay * 0.05)
ELSE ROUND((jikwon_pay * 0.03), -1) END AS '특별수당'
FROM jikwon WHERE date_format(jikwon_ibsail, '%Y') >= 2010;

-- 문제2) 입사 후 8년 이상이면 왕고참, 5년 이상이면 고참, 3년 이상이면 보통, 나머지는 일반으로 표현
-- 출력==>  직원명    직급    입사년월일    구분      부서
-- 			홍길동    부장    2009.1.5      왕고참    총무부

SELECT * FROM jikwon;
SELECT * FROM buser;

SELECT jikwon_name AS 직원명, jikwon_jik AS 직급, jikwon_ibsail AS 입사년월일,
case
when (DATE_FORMAT(NOW(),'%Y') - (date_format(jikwon_ibsail, '%Y'))) >= 8 then '왕고참'
when (DATE_FORMAT(NOW(),'%Y') - (date_format(jikwon_ibsail, '%Y'))) >= 5 then '고참'
when (DATE_FORMAT(NOW(),'%Y') - (date_format(jikwon_ibsail, '%Y'))) >= 3 then '보통'
ELSE '일반' END AS '구분',
case
when buser_num = 10 then '총무부'
when buser_num = 20 then '영업부'
when buser_num = 30 then '전산부'
ELSE '관리부' END AS '부서' FROM jikwon;

-- 문제3) 각 부서번호별로 실적에 따라 급여를 다르게 인상하려 한다. 
-- pay를 기준으로 10번은 10%, 30번은 20% 인상하고 나머지 부서는 동결한다.
-- 8년 이상 장기근속을 O,X로 표시
-- 금액은 정수만 출력(반올림)
-- 출력==>   사번    직원명   부서    연봉    인상연봉    장기근속
-- 			 1     홍길동    10     ****      ****          O        <-- 아니면 X 표시

select jikwon_no AS 사번, jikwon_name AS 직원명, buser_num AS 부서, jikwon_pay AS 연봉,
case
when buser_num = 10 then ROUND((jikwon_pay + (jikwon_pay * 0.1)))
when buser_num = 30 then ROUND((jikwon_pay + (jikwon_pay * 0.2)))
ELSE jikwon_pay END AS '인상연봉',
case
when (DATE_FORMAT(NOW(),'%Y') - (date_format(jikwon_ibsail, '%Y'))) >= 8 then 'O'
ELSE 'X' END AS '장기근속' FROM jikwon;

-- 복수행 함수 (집계함수) - 전체 자료를 그룹별로 구분하여 계산결과를 반환 null값을 제외함
SELECT SUM(jikwon_pay) AS 합, AVG(jikwon_pay) AS 평균 FROM jikwon; -- sum 합 avg 평균
SELECT MAX(jikwon_pay) AS 최대값, MIN(jikwon_pay), STDDEV(jikwon_pay), VAR_SAMP(jikwon_pay) AS 최소값 FROM jikwon; -- stddev 표준편차 var_samp 분산

SELECT * FROM jikwon;
SELECT AVG(jikwon_pay), AVG(nvl(jikwon_pay,0)) FROM jikwon; -- nvl( pay값 null이면 0출력)
SELECT sum(jikwon_pay) / 29, SUM(jikwon_pay) / 30 FROM jikwon; -- 홀수로 나눠주면 NULL인 자료는 제외하고 나눈다.
SELECT COUNT(*), COUNT(jikwon_no), COUNT(jikwon_jik), COUNT(jikwon_pay) FROM jikwon; -- count로 다 세도 *는 null에 관계없이 개수 출력 그외에는 null값을 뺌
SELECT COUNT(*) FROM jikwon WHERE jikwon_jik = '과장'; -- 직급중 과장의 총 인원수

-- 10번 부서의 인원수는?
SELECT COUNT(*) AS 인원수 FROM jikwon WHERE buser_num = 10;

-- 2010년 이후에 입사한 여직원 ?
SELECT COUNT(*) AS 인원 FROM jikwon WHERE jikwon_ibsail >= '2010-01-01' AND jikwon_gen = '여';
-- 2010년 이후에 입사한 남직원 ?
SELECT COUNT(*) AS 인원 FROM jikwon WHERE jikwon_ibsail > '2010-01-01' AND jikwon_gen = '남';

-- 2015년 이후 입사한 여직원 급여의 합, 급여평균, 인원수
SELECT SUM(jikwon_pay) AS 급여합, AVG(jikwon_pay) AS 급여평균, COUNT(*) AS 인원수
FROM jikwon WHERE jikwon_ibsail >= '2015-01-01' AND jikwon_gen = '여';

-- 그룹함수 : group by - 소계 출력
-- select 그룹칼럼명, 계산함수... from 테이블명 where 조건 group by 그룹칼럼명 having 출력결과조건
-- 그룹칼럼에 order by 불가. 단 출력결과는 order by 가능하다.

-- 성별 급여의 평균, 인원수를 출력
SELECT jikwon_gen, AVG(jikwon_pay), COUNT(*) FROM jikwon GROUP BY jikwon_gen;

-- 부서별 급여합
SELECT buser_num, SUM(jikwon_pay) FROM jikwon GROUP BY buser_num;

-- 부서별 급여합 : 급여합이 35,000 이상만...
SELECT buser_num, SUM(jikwon_pay) FROM jikwon GROUP BY buser_num HAVING SUM(jikwon_pay) >= 35000; -- 결과에 대한 조건
SELECT buser_num, SUM(jikwon_pay) AS tot FROM jikwon GROUP BY buser_num HAVING tot >= 35000; -- 위와 같음

-- 부서별 급여합 : 여자
SELECT buser_num, SUM(jikwon_pay) FROM jikwon where jikwon_gen = '여' GROUP BY buser_num;

-- 부서별 급여합 : 급여합이 15,000 이상인 여자
SELECT buser_num, SUM(jikwon_pay) FROM jikwon where jikwon_gen = '여'
GROUP BY buser_num HAVING SUM(jikwon_pay) >= 15000;

-- 주의
SELECT buser_num, SUM(jikwon_pay) FROM jikwon ORDER BY buser_num GROUP BY buser_num; -- X order by가 이미 group by에 포함되어있음.
SELECT buser_num, SUM(jikwon_pay) FROM jikwon GROUP BY buser_num ORDER BY SUM(jikwon_pay) DESC; -- group by 결과에 대한 order by 는 가능한데 역으로는 불가.

SELECT * FROM jikwon;

-- 문1) 직급별 급여의 평균 (NULL인 직급 제외)
SELECT jikwon_jik, AVG(jikwon_pay) FROM jikwon WHERE jikwon_jik IS NOT NULL GROUP BY jikwon_jik; -- null을 제외 --> is not null

-- 문2) 부장,과장에 대해 직급별 급여의 총합 in('부장','과장')도 가능하다.
SELECT jikwon_jik, SUM(jikwon_pay) FROM jikwon WHERE jikwon_jik = '부장' OR jikwon_jik = '과장' GROUP BY jikwon_jik;

-- 문3) 2010년 이전에 입사한 자료 중 년도별 직원수 출력
SELECT DATE_FORMAT(jikwon_ibsail, '%Y') AS 입사년도, COUNT(*) AS 직원수 FROM jikwon WHERE jikwon_ibsail < '2010-01-01' GROUP BY DATE_FORMAT(jikwon_ibsail, '%Y');

-- 문4) 직급별 성별 인원수, 급여합 출력 (NULL인 직급은 임시직으로 표현)
SELECT nvl(jikwon_jik,'임시직') AS 직급, jikwon_gen AS 성별, COUNT(*) AS 인원수, SUM(jikwon_pay) as 급여합 FROM jikwon GROUP BY jikwon_jik, jikwon_gen ORDER BY jikwon_jik;

-- 문5) 부서번호 10,20에 대한 부서별 급여 합 출력
-- SELECT buser_num AS 부서번호, SUM(jikwon_pay) as 급여합 FROM jikwon GROUP BY buser_num HAVING buser_num = 10 OR buser_num = 20;
SELECT buser_num, SUM(jikwon_pay) FROM jikwon where buser_num IN(10,20) GROUP BY buser_num;

-- 문6) 급여의 총합이 7000 이상인 직급 출력(NULL인 직급은 임시직으로 표현)
SELECT nvl(jikwon_jik,'임시직') AS 직급, SUM(jikwon_pay) AS 급여합 FROM jikwon GROUP BY jikwon_jik HAVING sum(jikwon_pay) >= 7000;

-- 문7) 직급별 인원수, 급여합계를 구하되 인원수가 3명 이상인 직급만 출력
--        (NULL인 직급은 임시직으로 표현)
SELECT nvl(jikwon_jik, '임시직'), COUNT(*) AS 인원수, SUM(jikwon_pay) FROM jikwon GROUP BY jikwon_jik HAVING 인원수 >= 3;


-- join : 한개 이상의 테이블에서 원하는 행(레코드)과 열(칼럼)을 선택적으로 읽기
-- 공통 칼럼이 있는 경우에 가능

-- cross join
SELECT jikwon_name, buser_name FROM jikwon,buser; -- 한번씩 전부 매칭하는것.
SELECT jikwon_name, buser_name FROM jikwon cross join buser;

-- equi join
SELECT jikwon_name, buser_name FROM jikwon, buser WHERE buser_num = buser_no;
SELECT jikwon_name, buser_name FROM jikwon INNER JOIN buser ON buser_num = buser_no;

-- non-equi join
CREATE TABLE paygrade(grade INT PRIMARY KEY, lpay INT, hpay INT);
INSERT INTO paygrade VALUES(1, 0, 1999);
INSERT INTO paygrade VALUES(2, 2000, 2999);
INSERT INTO paygrade VALUES(3, 3000, 3999);
INSERT INTO paygrade VALUES(4, 4000, 4999);
INSERT INTO paygrade VALUES(5, 5000, 9999);
SELECT * FROM paygrade;

SELECT jikwon_name, jikwon_pay, grade FROM jikwon j, paygrade p WHERE j.jikwon_pay >= p.lpay AND j.jikwon_pay <= p.hpay;

SELECT jikwon.jikwon_no, jikwon.jikwon_name FROM jikwon WHERE jikwon_no=1; -- 테이블에 대한 별명을 적어줘도 되고 칼럼명이 같을경우  어느테이블 안의 칼럼인지 알아야할때
DESC jikwon;
ALTER TABLE jikwon MODIFY buser_num INT(4) NULL; -- 데이터 구조를 바꿈. not null 조건을 가지고 null 허용으로 다시 바꿔줌
UPDATE jikwon SET buser_num = NULL WHERE jikwon_no = 5;
SELECT * FROM jikwon;

INSERT INTO buser(buser_no,buser_name) VALUES(50, '비서실');
SELECT * FROM buser;


-- inner join
-- 방법1)
SELECT a.jikwon_no, a.jikwon_name, b.buser_name FROM jikwon a, buser b WHERE a.buser_num = b.buser_no; -- 테이블 이름 선언해도 됨.
SELECT jikwon.jikwon_no, jikwon_name, buser_name FROM jikwon , buser WHERE a.buser_num = b.buser_no; -- 테이블 이름을 직접 넣어줘도 됨.

-- 방법2)
SELECT jikwon.jikwon_no, jikwon_name, buser_name FROM jikwon INNER JOIN buser ON buser_num = buser_no;
SELECT jikwon.jikwon_no, jikwon_name, buser_name FROM jikwon JOIN buser ON buser_num = buser_no;


-- outer join left 앞쪽이 기준
-- 방법
SELECT jikwon_no, jikwon_name, buser_name FROM jikwon LEFT OUTER JOIN buser ON buser_num = buser_no; -- 기준 왼쪽 직원쪽은 다출력

SELECT jikwon_no, jikwon_name, buser_name FROM jikwon RIGHT OUTER JOIN buser ON buser_num = buser_no; -- 기준 오른쪽 부서테이블은 다출력
SELECT * FROM jikwon RIGHT OUTER JOIN buser ON buser_num = buser_no;
-- 부서 내 근무자 목록표 (부서가 없는 근무자는 제외)
SELECT buser_name, jikwon_name, jikwon_jik, buser_tel FROM jikwon INNER JOIN buser ON jikwon.buser_num = buser.buser_no
ORDER BY buser_name ASC; -- order by 는 정렬이다.


-- 관리 고객이 있는 직원만 출력
SELECT * FROM gogek;

SELECT jikwon_no, jikwon_name, gogek_name, gogek_tel FROM jikwon INNER JOIN gogek ON jikwon_no = gogek_damsano
ORDER BY jikwon_name;

-- 관리고객에 상관없이 모든 직원 출력 (관리 고객이 없는 직원들은 null로 나온다)
SELECT jikwon_no, jikwon_name, gogek_name, gogek_tel FROM jikwon LEFT OUTER JOIN gogek ON jikwon_no = gogek_damsano;

-- 부서별 직원의 급여합, 급여평균, 인원수(부서가 없는 직원은 '계약직')
SELECT nvl(buser_name,'계약직') AS 부서, SUM(jikwon_pay) AS 급여합, AVG(jikwon_pay) AS 급여평균, COUNT(*) AS 인원수
FROM jikwon LEFT OUTER JOIN buser ON buser_no = buser_num GROUP BY buser_name;

-- 문1) 직급이 '사원' 인 직원이 관리하는 고객자료 출력
-- 출력 ==>  사번   직원명   직급      고객명    고객전화    고객성별
--           3     한국인   사원       우주인    123-4567       남
SELECT * FROM gogek;
SELECT * FROM jikwon;
SELECT jikwon_no AS 사번, jikwon_name AS 직원명, jikwon_jik  AS 직급, gogek_name AS 고객명, gogek_tel AS 고객전화,
case SUBSTR(gogek_jumin,8,1) when 1 then '남' when 2 then '여' END AS '고객성별'
FROM jikwon INNER JOIN gogek ON jikwon_no = gogek_damsano AND jikwon_jik = '사원';

-- 문2) 직원별 고객 확보 수  -- GROUP BY 사용
--    - 모든 직원 참여
SELECT jikwon_no AS 직원번호, jikwon_name AS 직원명, COUNT(gogek_no) AS 고객인원  FROM jikwon LEFT OUTER JOIN gogek ON  jikwon_no = gogek_damsano GROUP BY jikwon_no
ORDER BY jikwon_no;

-- 문3) 고객이 담당직원의 자료를 보고 싶을 때 즉, 고객명을 입력하면,  담당직원 자료 출력
--        :    ~ WHERE GOGEK_NAME='강나루'
-- 출력 ==>    직원명       직급
--            한국인       사원
SELECT jikwon_name AS 직원명, nvl(jikwon_jik,'계약직') as 직책 FROM jikwon INNER JOIN gogek ON jikwon_no = gogek_damsano WHERE gogek_name = '최부자';
 
-- 문4) 직원명을 입력하면 관리고객 자료 출력
--       : ~ WHERE JIKWON_NAME='한국인'
-- 출력 ==> 고객명   고객전화          주민번호           나이
--         강나루   123-4567   	 700512-1234567  	      38

SELECT gogek_name, gogek_tel, gogek_jumin,(DATE_FORMAT(NOW(), '%Y') - (substr(lpad(gogek_jumin, 16, 19),1,4))) +1 AS 나이
FROM gogek INNER JOIN jikwon ON gogek_damsano = jikwon_no AND jikwon_name = '이순신';

SELECT gogek_name, gogek_tel, gogek_jumin,
case
when substr(gogek_jumin,8,1) = 1 then (DATE_FORMAT(NOW(), '%Y') - (substr(lpad(gogek_jumin, 16, 19),1,4))) + 1
when substr(gogek_jumin,8,1) = 2 then (DATE_FORMAT(NOW(), '%Y') - (substr(lpad(gogek_jumin, 16, 19),1,4))) + 1
when substr(gogek_jumin,8,1) = 3 then (DATE_FORMAT(NOW(), '%Y') - (substr(lpad(gogek_jumin, 16, 20),1,4))) + 1
when substr(gogek_jumin,8,1) = 4 then (DATE_FORMAT(NOW(), '%Y') - (substr(lpad(gogek_jumin, 16, 20),1,4))) + 1
END AS 나이
FROM gogek INNER JOIN jikwon ON gogek_damsano = jikwon_no AND jikwon_name = '이순신';

-- 세개 이상의 테이블 조인 세개가 동시에 X, 두개를 합치고 다음 한개 .... 이런식으로 합친다.
SELECT jikwon_name, buser_name, gogek_name FROM jikwon,buser,gogek
WHERE buser_num = buser_no AND jikwon_no = gogek_damsano; -- 직원의 부서와 담당고객 이름출력


SELECT jikwon_name, buser_name, gogek_name
FROM jikwon
INNER JOIN buser ON buser_num = buser_no
INNER JOIN gogek ON jikwon_no = gogek_damsano;
SELECT * FROM buser;
SELECT * FROM gogek;
SELECT * FROM jikwon;
--  문1) 총무부에서 관리하는 고객수 출력 (고객 30살 이상만 작업에 참여)
-- SELECT buser_name ,COUNT(gogek_no) AS '고객수' FROM jikwon, gogek, buser WHERE gogek_damsano = jikwon_no AND buser_num = buser_no AND buser_no = 10
-- AND (YEAR(NOW()) - substr(gogek_jumin,1,2)+1900)+1 >= 30;
 
SELECT buser_name ,COUNT(gogek_no) AS '고객수' FROM jikwon
INNER JOIN buser ON buser_num = buser_no
INNER JOIN gogek ON jikwon_no = gogek_damsano
WHERE (YEAR(NOW()) - DATE_FORMAT(substr(gogek_jumin,1,6), '%Y')) >= 30
AND buser_name = '총무부' GROUP BY buser_name;

-- 문2) 부서명별 고객 인원수 (부서가 없으면 "무소속")
SELECT nvl(buser_name,'무소속') AS 부서, COUNT(gogek_no) AS 고객인원수 FROM jikwon
LEFT OUTER JOIN buser ON buser_num = buser_no -- null값도 출력하기 위해서
INNER JOIN gogek ON gogek_damsano = jikwon_no GROUP BY buser_name; -- inner를 써도되는건 foreign key가 되어있어서

-- SELECT nvl(buser_name,'무소속') '부서', COUNT(gogek_no) AS 고객인원수 FROM jikwon, buser, gogek
-- WHERE gogek_damsano = jikwon_no AND buser_num = buser_no GROUP BY buser_name;

-- 문3) 고객이 담당직원의 자료를 보고 싶을 때 즉, 고객명을 입력하면  담당직원 자료 출력  
--        :    ~ WHERE GOGEK_NAME='강나루'
-- 출력 ==>  직원명    직급   부서명  부서전화    성별
SELECT jikwon_name AS 직원명, jikwon_jik as 직급, buser_name AS 부서명, buser_tel AS 전화번호, jikwon_gen AS 성별  FROM jikwon
INNER JOIN buser ON buser_num = buser_no
INNER JOIN gogek on gogek_damsano = jikwon_no
WHERE gogek_name = '최부자';

-- 문4) 부서와 직원명을 입력하면 관리고객 자료 출력
--       ~ WHERE BUSER_NAME='영업부' AND JIKWON_NAME='이순신'
-- 출력 ==>  고객명    고객전화      성별
--           강나루   123-4567       남
SELECT gogek_name AS 고객명, gogek_tel AS 고객전화,
case
when SUBSTR(gogek_jumin,8,1) = 1 then '남'
when SUBSTR(gogek_jumin,8,1) = 2 then '여'
END AS 성별 FROM gogek
INNER JOIN jikwon ON gogek_damsano = jikwon_no
INNER JOIN  buser ON buser_num = buser_no
WHERE jikwon_name = '이순신' AND buser_name = '영업부';

-- union : 구조가 일치하는 두 개 이상의 테이블 자료 합쳐서 보기. 원래의 테이블은 유지.
CREATE TABLE pum1(bun INT, pummok VARCHAR(20))CHARSET=UTF8;
INSERT INTO pum1 VALUES(1, '귤'); -- '1'은 괜찮은데  일 <- 이렇게 주면 안된다.
INSERT INTO pum1 VALUES(2, '바나나');
INSERT INTO pum1 VALUES(3, '한라봉');
SELECT * FROM pum1;

CREATE TABLE pum2(num INT, sangpum VARCHAR(20))CHARSET=UTF8;
INSERT INTO pum2 VALUES(10, '수박');
INSERT INTO pum2 VALUES(20, '토마토');
INSERT INTO pum2 VALUES(30, '딸기');
INSERT INTO pum2 VALUES(40, '참외');
SELECT * FROM pum2;

SELECT bun AS 번호, pummok AS 품목 FROM pum1
UNION
SELECT num, sangpum FROM pum2;

-- merge : 기존에 존재하는 행이 있다면 갱신하고, 존재하지 않는다면 insert 된다.
CREATE TABLE jik2 AS SELECT * FROM jikwon WHERE jikwon_jik = '대리'; -- pk는 복사되지 않는다.
DROP TABLE jik2;
CREATE TABLE jik2 AS SELECT jikwon_no, jikwon_name, jikwon_pay FROM jikwon WHERE jikwon_no <= 5;
SELECT * FROM jik2; -- 칼럼의 일부갖고 물리적으로 만들어주는 행위
DESC jik2;
ALTER TABLE jik2 ADD CONSTRAINT pk_no PRIMARY KEY(jikwon_no); -- pk key 만들어줌
DESC jik2;

SELECT * FROM jik2;

-- merge 진행
INSERT INTO jik2 VALUES(7,'신기해',7777) ON DUPLICATE KEY UPDATE jikwon_name = '공기밥'; -- value( 첫숫자) 없으면 전자 있으면 후자
SELECT * FROM jik2;
INSERT INTO jik2 VALUES(1,'신기해',7777) ON DUPLICATE KEY UPDATE jikwon_name = '주먹밥'; -- values(1 이 있으므로 1번에 주먹밥으로 바꿔준다.
SELECT * FROM jik2;

-- Database transactions
-- 단위별 데이터 처리를 말한다. 한 사용자에 의해 복수 SQL구문을 이용한 가장 작은 단위의 논리적인 작업
-- 클라이언트로 읽혀진 자료에 변화가 생기면 commit 이나 rollback에 의해 원본 DB에 영향을 줄수 있다.
-- mariaDB는 오토 commit이라 insert,update,delete만해도 메인Master DB가 바뀜
-- commit : 클라이언트에서 저장되지 않은 모든 자료를 원본 데이터베이스에 저장하고 작업 단위를 종료함.
-- rollback : 클라이언트에서 저장되지 않은 모든 자료의 변경사항을 취소하고 작업 단위를 종료함.

SHOW VARIABLES LIKE 'autocommit%'; -- autocommit 상태확인.
SET autocommit = FALSE; -- autocommit 해제
SET autocommit = TRUE;  -- autocommit  설정

CREATE TABLE jiktab AS SELECT * FROM jikwon WHERE jikwon_no <= 10; -- 직원번호 10까지 출력

SELECT * FROM jiktab;

-- commit, rollback test 1

SET autocommit = FALSE;
DELETE FROM jiktab WHERE jikwon_no = 3; -- 3번을 지워도 마스터 데이터에는 남아있음. 트랜잭션의 시작. 작업단위 시작 insert,update,delete만 연관이있음.
SELECT * FROM jiktab; -- select는 상관이 없음 commit에
ROLLBACK; -- 작업단위 끝 선언.
SELECT * FROM jiktab;

DELETE FROM jiktab WHERE jikwon_no = 3; -- 3번을 지워도 마스터 데이터에는 남아있음. 트랜잭션의 시작. 작업단위 시작 insert,update,delete만 연관이있음.
SELECT * FROM jiktab; -- select는 상관이 없음 commit에
COMMIT; -- 작업단위 끝 선언. 확정을 짓기 때문에 마스터DB도 지워진다.
SELECT * FROM jiktab; -- 마스터데이터도 지워짐.

SHOW VARIABLES LIKE 'autocommit%';
-- commit, rollback test 2 -savepoint
SELECT * FROM jiktab;
UPDATE jiktab SET jikwon_name = 'a1' WHERE jikwon_no=5;
SELECT * FROM jiktab;
SAVEPOINT a;
UPDATE jiktab SET jikwon_name = 'b1' WHERE jikwon_no=6;
ROLLBACK TO SAVEPOINT a; -- savepoint 때문에 866줄에서 864번줄까지 취소
UPDATE jiktab SET jikwon_name = 'c1' WHERE jikwon_no=7;
COMMIT;
SELECT * FROM jiktab;

-- deadLocks : 두 개 이상의 트랜잭션이 서로의 진행을 막고 충돌하는 현상
SELECT * FROM jiktab;
UPDATE jiktab SET jikwon_jik = '사원' WHERE jikwon_no = 2; -- 트랜잭션이 끝나지 않아서 마스터DB에도 빠져나오지 못하고 에러중.
SELECT * FROM jiktab;
ROLLBACK;
SELECT * FROM jiktab;

SET autocommit = TRUE; -- 원래값인 자동으로 전환

-- subquery : query  내에 query를 기술
SELECT * FROM jikwon;
-- 박치기 직원과 직급이 같은 직원들 출력
SELECT jikwon_jik FROM jikwon WHERE jikwon_name = '박치기';
SELECT * FROM jikwon WHERE jikwon_jik = '사원';
SELECT * FROM jikwon WHERE jikwon_jik = (SELECT jikwon_jik FROM jikwon WHERE jikwon_name = '박치기'); -- subquery 사용법 괄호안에 한 문장을 넣어준다

-- 직급이 대리 중 가장 먼저 입사한 직원은?
SELECT * FROM jikwon WHERE jikwon_ibsail = (SELECT MIN(jikwon_ibsail)  FROM jikwon WHERE jikwon_jik = '대리');
-- 위의 문장은 단순하게 입사일이 '2013-02-05' 인 사람 달라는거와 같다. 문제와 맞지않음.
SELECT * FROM jikwon WHERE jikwon_jik = '대리' AND jikwon_ibsail = (SELECT MIN(jikwon_ibsail)  FROM jikwon WHERE jikwon_jik = '대리');
-- 이것이 조건이 맞는 것.

SELECT * FROM buser;
-- 인천에 근무하는 직원 출력
SELECT * FROM jikwon WHERE buser_num = SELECT buser_no FROM buser WHERE buser_loc = '인천'; -- In대신 = 써도 상관 없다. 괄호안의 조건이 복수개면 =은 쓸수없다.
SELECT * FROM jikwon WHERE buser_num IN(SELECT buser_no FROM buser WHERE buser_loc = '인천');

-- 인천 이외의 지역 근무하는 직원
SELECT * FROM jikwon WHERE buser_num IN(SELECT buser_no FROM buser WHERE not buser_loc = '인천'); -- 인천을 제외한 세가지 출력


-- 담당 직원이 최부자와 같은 고객 출력 (최부자를 관리하는 직원의 다른 고객)
SELECT * FROM gogek WHERE gogek_damsano IN(SELECT gogek_damsano FROM gogek WHERE gogek_name = '최부자');

-- 고객중 차일호와 나이가 같은 자료 출력
SELECT * FROM gogek WHERE SUBSTR(gogek_jumin, 1,2) = (SELECT SUBSTR(gogek_jumin, 1,2) FROM gogek WHERE gogek_name = '차일호');


-- 문1)\ 2010년 이후에 입사한 남자 중 급여를 가장 많이 받는 직원은?
SELECT * FROM jikwon;
SELECT * FROM jikwon WHERE jikwon_ibsail >= '2010-01-01' AND jikwon_gen = '남' AND 
jikwon_pay IN(SELECT max(jikwon_pay) FROM jikwon WHERE jikwon_ibsail >= '2010-01-01' AND jikwon_gen = '남');

-- 문2)  평균급여보다 급여를 많이 받는 직원은?
SELECT * FROM jikwon WHERE jikwon_pay > (SELECT avg(jikwon_pay) FROM jikwon);
 

-- 문3) '이미라' 직원의 입사 이후에 입사한 직원은?
SELECT * FROM jikwon WHERE jikwon_ibsail > (SELECT jikwon_ibsail FROM jikwon WHERE jikwon_name = '이미라');


-- 문4) 2010 ~ 2015년 사이에 입사한 총무부(10),영업부(20),전산부(30) 직원 중 급여가 가장 적은 사람은?
-- (직급이 NULL인 자료는 작업에서 제외)
SELECT * FROM jikwon WHERE jikwon_jik IS NOT NULL AND buser_num IN(10,20,30) and jikwon_ibsail BETWEEN '2010-01-01' and '2015-12-31' AND
jikwon_pay = (SELECT min(jikwon_pay) FROM jikwon WHERE buser_num IN(10,20,30) AND jikwon_ibsail BETWEEN '2010-01-01' and '2015-12-31');


-- 문5) 한송이, 이순신과 직급이 같은 사람은 누구인가?
SELECT * FROM jikwon WHERE jikwon_jik IN(SELECT jikwon_jik FROM jikwon WHERE jikwon_name = '한송이' OR jikwon_name = '이순신');
 
-- 문6) 과장 중에서 최대급여, 최소급여를 받는 사람은?
SELECT * FROM jikwon WHERE jikwon_jik = '과장' AND
jikwon_pay In(SELECT min(jikwon_pay) FROM jikwon WHERE jikwon_jik = '과장') OR
jikwon_pay In(SELECT max(jikwon_pay) FROM jikwon WHERE jikwon_jik = '과장');

-- 문7) 10번 부서의 최소급여보다 많은 사람은?
SELECT * FROM jikwon WHERE jikwon_pay > (SELECT MIN(jikwon_pay) FROM jikwon WHERE buser_num = '10');

-- 문8) 30번 부서의 평균급여보다 급여가 많은 '대리' 는 몇명인가?
SELECT COUNT(jikwon_no) AS 대리수  FROM jikwon WHERE jikwon_jik = '대리' AND jikwon_pay > (SELECT AVG(jikwon_pay) FROM jikwon WHERE buser_num = 30);
 

-- 문9) 고객을 확보하고 있는 직원들의 이름, 직급, 부서명을 입사일 별로 출력하라.
SELECT * FROM gogek;
SELECT jikwon_name AS 이름, jikwon_jik AS 직급, buser_name AS 부서명, jikwon_ibsail AS 입사일 FROM jikwon
LEFT OUTER JOIN buser ON buser_num = buser_no
WHERE jikwon_no IN(SELECT DISTINCT gogek_damsano FROM gogek) -- 중복을 배제함
ORDER BY jikwon_ibsail;

-- 문10) 이순신과 같은 부서에 근무하는 직원과 해당 직원이 관리하는 고객 출력
-- (고객은 나이가 30 이하면 '청년', 50 이하면 '중년', 그 외는 '노년'으로 표시하고, 고객 연장자 부터 출력)
-- 출력 ==>  직원명    부서명     부서전화     직급      고객명    고객전화    고객구분
--           한송이    총무부     123-1111    사원      백송이    333-3333    청년
SELECT jikwon_jik AS 직원명 , buser_name AS 부서명, buser_tel AS 부서전화, jikwon_jik  AS 직급 , gogek_name AS 고객명, gogek_tel AS 고객전화,
case
when (YEAR(NOW()) - (SUBSTR(gogek_jumin,1,2)+1900) +1) <= 30 then '청년'
when (YEAR(NOW()) - (SUBSTR(gogek_jumin,1,2)+1900) +1) <= 50 then '중년'
ELSE '노년' END AS '고객구분' FROM gogek
INNER JOIN jikwon ON jikwon_no = gogek_damsano
INNER JOIN buser ON buser_no = buser_num
WHERE buser_num IN(SELECT buser_num FROM jikwon WHERE jikwon_name = '이순신');
-- FROM gogek,buser,jikwon WHERE buser_num = buser_no AND gogek_damsano = jikwon_no AND buser_num IN(SELECT buser_num FROM jikwon WHERE jikwon_name = '이순신');

-- any, all 연산자 : null인 자료는 제외하고 작업함
-- <ANY : subquery의 반환값 중 최대값 보다 작은 ~ 
-- >ANY : subquery의 반환값 중 최소값 보다 큰 ~ 
-- <ALL : subquery의 반환값 중 최소값 보다 작은 ~ 
-- >ALL : subquery의 반환값 중 최대값 보다 큰 ~ 
	

-- 대리의 최대값 보다 작은 연봉을 받는 직원은?
SELECT jikwon_no, jikwon_name, jikwon_pay FROM jikwon WHERE jikwon_pay <ANY (SELECT jikwon_pay FROM jikwon WHERE jikwon_jik = '대리');

-- 30번 부서의 초고 급여자 보다 급여를 많이 받는 직원은?
SELECT jikwon_no, jikwon_name, jikwon_pay FROM jikwon
WHERE jikwon_pay <ALL (SELECT jikwon_pay FROM jikwon WHERE buser_num=30);

-- 30번 부서의 최저 급여자 보다 급여를 많이 받는 직원은?
SELECT jikwon_no, jikwon_name, jikwon_pay FROM jikwon
WHERE jikwon_pay >ANY (SELECT jikwon_pay FROM jikwon WHERE buser_num=30);

-- 총무부 직원들이 관리하는 고객 출력
-- subquery
SELECT gogek_no, gogek_name, gogek_tel FROM gogek
WHERE gogek_damsano IN(SELECT jikwon_no FROM jikwon
WHERE buser_num =(SELECT buser_no FROM buser WHERE buser_name = '총무부'));

-- join
SELECT gogek_no, gogek_name, gogek_tel FROM gogek
INNER JOIN jikwon ON jikwon_no = gogek_damsano
INNER JOIN buser ON buser_num = buser_no
WHERE buser_name = '총무부';

-- from 절에 subquery
-- 전체 평균 연봉과 최대 연봉 사이의 연봉을 받는 직원은?
SELECT jikwon_no, jikwon_name, jikwon_pay
FROM jikwon a, (SELECT AVG(jikwon_pay) AS avgs, MAX(jikwon_pay) AS maxs FROM jikwon) b
WHERE a.jikwon_pay BETWEEN b.avgs AND b.maxs;

-- 각 부서별로 최고 연봉을 받는 직원 출력
SELECT a.jikwon_no, a.jikwon_name, a.jikwon_pay, a.buser_num FROM jikwon a, -- 보고싶은 칼럼 추출 a로 묶음
(SELECT buser_num, MAX(jikwon_pay) maxpay FROM jikwon GROUP BY buser_num) b -- 각 부서별 최고 연봉자 from 안의 subquery로 b묶음
WHERE a.buser_num = b.buser_num AND a.jikwon_pay = b.maxpay;

-- group by의 having 절에 subquery
-- 부서별 평균 연봉 중 30번 부서의 연봉보다 큰 자료 출력
SELECT buser_num, AVG(jikwon_pay) FROM jikwon WHERE buser_num IS NOT NULL -- null값 제거
GROUP BY buser_num
HAVING AVG(jikwon_pay) > (SELECT AVG(jikwon_pay) FROM jikwon WHERE buser_num=30);

-- exists 연산자
-- 직원이 있는 부서 출력
SELECT buser_name, buser_loc FROM buser AS bu
WHERE EXISTS (SELECT 'imsi' FROM jikwon WHERE buser_num = bu.buser_no);

-- 직원이 없는 부서 출력
SELECT buser_name, buser_loc FROM buser AS bu
WHERE not EXISTS (SELECT 'imsi' FROM jikwon WHERE buser_num = bu.buser_no);

-- 상관 서브 쿼리 : 안쪽 쿼리 에서 바깥쪽에서 쿼리를 참조하고, 다시 안쪽의 결과를 바깥쪽 쿼리에서 참조한다.
-- 각 부서의 최대 연봉자는?
SELECT * FROM jikwon a
WHERE a.jikwon_pay = (SELECT MAX(b.jikwon_pay) FROM jikwon b WHERE a.buser_num = b.buser_num);
-- 바깥쪽																			- 안쪽쿼리에서 바깥 참조

-- 급여 순위 3위이내 자료 출력(내림차순)
SELECT a.jikwon_name, a.jikwon_pay FROM jikwon a 
WHERE 3 > (SELECT COUNT(*) FROM jikwon b WHERE b.jikwon_pay > a.jikwon_pay)
AND buser_num IS NOT NULL
ORDER BY jikwon_pay DESC;

-- create table, insert : subquery
CREATE TABLE sa1 AS SELECT * FROM jikwon; -- jikwon과 같은 테이블 생성
DESC sa1;
SELECT * FROM sa1;

DROP TABLE sa2;
CREATE TABLE sa2 AS SELECT * FROM jikwon WHERE 1=0; -- 구조만 만들고 싶을때 1=0;
DESC sa2;
INSERT INTO sa2 SELECT * FROM jikwon WHERE jikwon_jik = '과장';
INSERT INTO sa2 (jikwon_no, jikwon_name, buser_num, jikwon_jik) (SELECT jikwon_no, jikwon_name, buser_num,jikwon_jik FROM jikwon
WHERE jikwon_jik = '부장'); -- jikwon_jik을 받는부분에 넣어주지않아서 부장직이 안나오고 사원만 출력된다.

SELECT * FROM sa2; -- 칼럼만 가진 sa2출력

-- update, delete : subquery에도 가능
-- update
SELECT * FROM sa1;
UPDATE sa1 SET jikwon_jik=(SELECT jikwon_jik FROM jikwon WHERE jikwon_name='이순신') WHERE jikwon_no =2;

-- delete
DELETE FROM sa1 WHERE jikwon_no IN(SELECT DISTINCT gogek_damsano FROM gogek); -- 고객 담당사원 차례대로 나열후 jikwon_no 에서 삭제해준다.
SELECT * FROM sa1;

-- view 파일 : 물리적인 테이블을 근거로 select 문을 파일로 저장하여 가상의 테이블로 사용
-- 형식 : create [or replace] view 뷰파일명 as select문
-- drop view 뷰파일명
CREATE OR REPLACE VIEW v_1 AS -- or replace 하면 이미 생성되도 다시 생성하기때문에 오류메세지 출력을 안함.
SELECT jikwon_no, jikwon_name, jikwon_pay FROM jikwon WHERE jikwon_ibsail < '2010-12-31';

SELECT * FROM v_1; -- 물리적 테이블이 아닌 논리적 테이블이다. 메모리를 극히 적게 가져가며 select문만 기억한다. 보안을 강화, 자료의 독립성이 확보가능하다.
DESC v_1;

SELECT SUM(jikwon_pay) FROM v_1;

CREATE OR REPLACE VIEW v_2 AS
SELECT * FROM jikwon WHERE jikwon_name LIKE '김%'; -- like뒤에는 조건맞추는 애들만 출력
SELECT * FROM v_2;

ALTER TABLE jikwon RENAME kbs; -- 테이블 이름을 바꾸면 v_1 v_2는 기능을 잃는다.
SELECT * FROM v_1;
SELECT * FROM v_2;
ALTER TABLE kbs RENAME jikwon;
SELECT * FROM v_1;
SELECT * FROM v_2;

CREATE OR REPLACE VIEW v_3 AS SELECT * FROM jikwon ORDER BY jikwon_pay DESC; -- 연봉내림차순으로 v_3 생성
SELECT * FROM v_3;

CREATE OR REPLACE VIEW v_4 AS SELECT jikwon_no, jikwon_name, jikwon_pay * 10000 FROM jikwon;
SELECT * FROM v_4;
-- UPDATE v_4 SET ypay = 500 WHERE jikwon_no = 1; -- 계산칼럼 업데이트 불가하다. 계산으로 만들어지는 칼럼이기 때문에 불가.
UPDATE v_4 SET jikwon_name = '홍두깨' WHERE jikwon_no = 1; -- 이건 가능함 논리적 테이블이기 때문에 물리적 테이블의 jikwon으로 가서 jikwon_name을  바꾼다.
SELECT * FROM v_4;

SELECT * FROM jikwon;
SELECT * FROM v_4;
CREATE OR REPLACE VIEW v_5 AS SELECT * FROM v_4 WHERE jikwon_no <= 5; -- 뷰로 뷰를 생성 가능함.
SELECT * FROM v_5;

-- DELETE FROM v_5 WHERE jikwon_no = 4; -- 4번직원이 관리하는 고객이 있으면 foreign key로 묶여있기 때문에 지울수 없다.

CREATE OR REPLACE VIEW v_6 AS SELECT jikwon_no, jikwon_name, jikwon_pay, buser_num, jikwon_jik FROM jikwon
WHERE jikwon_jik = '사원';
SELECT * FROM v_6;
INSERT INTO v_6(jikwon_no, jikwon_name, jikwon_pay, buser_num, jikwon_jik) VALUES(50, '사오정', 1234, 10, '사원');
SELECT * FROM v_6;

INSERT INTO v_6(jikwon_no, jikwon_name, jikwon_pay, buser_num, jikwon_jik) VALUES(51, '사거리', 1234, 20, '과장');
SELECT * FROM v_6; -- v_6 뷰 만드는 조건에서 사원만 보기로해서 과장은 출력 안됨 하지만, jikwon테이블에는 insert가 되어있다.
-- not null 조건이 들어가면 뷰에 전부 끼워넣어야 한다.
UPDATE v_6 SET jikwon_name = '신선한' WHERE jikwon_no =6;
DELETE FROM v_6 WHERE jikwon_no=15; -- 직원테이블의 15번을 지움
SELECT * FROM jikwon;
DELETE FROM jikwon WHERE jikwon_no >= 50;


-- 문1) 사번   이름    부서  	직급  근무년수  	고객확보
--        1   홍길동  영업부 	사원     6    	 O   or  X
-- 조건 : 직급이 없으면 임시직, 전산부 자료는 제외
-- 위의 결과를 위한 뷰파일 v_exam1을 작성
SELECT * FROM jikwon;
SELECT * FROM buser;
CREATE OR REPLACE VIEW v_exam1 AS SELECT DISTINCT jikwon_no AS 사번, jikwon_name AS 이름, buser_name AS 부서, nvl(jikwon_jik,'임시직') AS 직급,
((YEAR(NOW()) - DATE_FORMAT(jikwon_ibsail,'%Y')) + 1) AS 근무년수,
case
when gogek_damsano = jikwon_no then 'O'
ELSE 'X' end as 고객확보 FROM jikwon
INNER JOIN buser ON buser_num = buser_no AND buser_num IN(10,20,40,50)
LEFT OUTER join gogek ON gogek_damsano = jikwon_no
ORDER BY jikwon_no;
-- WHERE jikwon_no IN(SELECT DISTINCT gogek_damsano FROM gogek);

SELECT * FROM v_exam1;

-- 문2) 부서명   인원수
--       영업부     7
-- 조건 : 직원수가 가장 많은 부서 출력
-- 위의 결과를 위한 뷰파일 v_exam2을 작성
CREATE OR REPLACE VIEW v_exam2 AS SELECT buser_name AS 부서명, COUNT(*) AS 인원수 FROM jikwon
INNER JOIN buser ON buser_num = buser_no GROUP BY buser_num ORDER BY 인원수 DESC LIMIT 1;

SELECT * FROM v_exam2;

-- 문3) 가장 많은 직원이 입사한 요일에 입사한 직원 출력
--    직원명   요일     부서명   부서전화
--    한국인  수요일   전산부   222-2222
-- 위의 결과를 위한 뷰파일 v_exam3을 작성
SELECT * FROM v_exam3;

SELECT MAX(DAYOFWEEK(jikwon_ibsail)) FROM jikwon;

SELECT DAYOFWEEK(jikwon_ibsail) FROM jikwon;
SELECT DATE_FORMAT(jikwon_ibsail, '%a'), DAYOFWEEK(jikwon_ibsail), DAYNAME(jikwon_ibsail) FROM jikwon;

CREATE OR REPLACE VIEW v_exam3 AS SELECT jikwon_name AS 직원명, DATE_FORMAT(jikwon_ibsail, '%a') AS 요일,
buser_name AS 부서명, buser_tel AS 부서전화 FROM jikwon
LEFT OUTER JOIN buser ON buser_num = buser_no WHERE DAYOFWEEK(jikwon_ibsail) IN(SELECT MAX(DAYOFWEEK(jikwon_ibsail)) FROM jikwon);

SELECT * FROM v_exam3;

CREATE OR REPLACE VIEW v_exam3 AS SELECT jikwon_name AS 직원명,
case
when DAYOFWEEK(jikwon_ibsail) = '1' then '일'
when DAYOFWEEK(jikwon_ibsail) = '2' then '월'
when DAYOFWEEK(jikwon_ibsail) = '3' then '화'
when DAYOFWEEK(jikwon_ibsail) = '4' then '수'
when DAYOFWEEK(jikwon_ibsail) = '5' then '목'
when DAYOFWEEK(jikwon_ibsail) = '6' then '금'
when DAYOFWEEK(jikwon_ibsail) = '7' then '토'
END AS 요일, buser_name AS 부서명, buser_tel AS 부서전화 FROM jikwon
LEFT OUTER JOIN buser on buser_num = buser_no WHERE DAYOFWEEK(jikwon_ibsail) = (SELECT MAX(DAYOFWEEK(jikwon_ibsail)) from jikwon
GROUP BY DAYOFWEEK(jikwon_ibsail)
ORDER BY COUNT(*)DESC
LIMIT 1);

SELECT * FROM v_exam3;

-- 계정(사용자) 생성 및 권한, 보안
CREATE DATABASE mydb;
USE mydb;
CREATE TABLE abctab(NO INT PRIMARY KEY, NAME VARCHAR(10));
INSERT INTO abctab VALUES(1,'aa');
INSERT INTO abctab VALUES(2,'bb');
SELECT * FROM abctab;

USE mysql; -- mydb에서 mysql로 넘어감
CREATE USER 'testuser1'@'localhost' identified BY '1234'; -- LOCAL 계정 생성 
CREATE USER 'testuser2'@'%' identified BY '1234'; -- remote 원격 계정 생성 

SHOW GRANTS FOR 'testuser1'@'localhost'; -- cmd창에서 들어갈때는 mysql -u testuser1 -h127.0.0.1 -p mydb에 관한 접근 허용 x
SHOW GRANTS FOR 'testuser2'@'%';

SELECT user FROM user;
SELECT HOST,user,PASSWORD FROM user;

GRANT ALL PRIVILEGES ON mydb.* TO 'testuser1'@'localhost'; -- mydb에 접근하여 모든작업 하는걸 수락. root가 절대적 계정
GRANT SELECT, INSERT ON mydb.* TO 'testuser1'@'localhost'; -- mydb에서 select,insert만 가능
GRANT SELECT, INSERT ON mydb.abctab TO 'testuser1'@'localhost'; -- mydb의 abctab table에서만 select,insert가 가능
FLUSH PRIVILEGES; -- 계정생성후 마무리

GRANT ALL PRIVILEGES ON mydb.* TO 'testuser2'@'%'; -- '도구' 탭의 사용자관리자에서도 생성이 가능하다.
FLUSH PRIVILEGES;

ALTER user 'testuser1'@'localhost' IDENTIFIED BY '4321'; -- 계정의 비밀번호를 변경

DROP USER 'testuser1'@'localhost'; -- 계정 삭제

-- stored procedure : SQL 프로그래밍
-- ex 1)
delimiter //
CREATE OR REPLACE PROCEDURE sp_1(a INT, b INT)
BEGIN
DECLARE X, y INT DEFAULT 0;
SET X = 10;
SELECT X,Y;
SELECT a + b;
END
//
delimiter ; -- 띄어쓰기 해야됨

CALL sp_1(1,3);
SHOW PROCEDURE STATUS; -- procedure 목록
SHOW CREATE PROCEDURE sp_1; -- sp_1 procedure의 내용
DROP PROCEDURE sp_1;



-- ex 2)
delimiter //
CREATE OR REPLACE PROCEDURE sp_2()
BEGIN
SELECT * FROM jikwon WHERE jikwon_no <= 3;
SELECT * FROM buser;
END
//
delimiter ;

CALL sp_2;



-- ex 3)
delimiter //
CREATE OR REPLACE PROCEDURE sp_3(ar1 INT, ar2 INT)
BEGIN
SELECT * FROM jikwon WHERE jikwon_no = ar1;
SELECT * FROM jikwon WHERE jikwon_no = ar2;
END
//
delimiter ;

CALL sp_3(2,8);



-- ex 4 : if
delimiter $$
CREATE OR REPLACE PROCEDURE sp_4(IN jik VARCHAR(10) CHARSET UTF8, num INT)
BEGIN
SELECT jik;
SELECT * FROM jikwon WHERE jikwon_jik=jik;
IF(num = 10) then -- if블럭 시작은 IF부터
	SELECT * FROM jikwon WHERE buser_num = 10;
ELSEIF(num = 20) then
	SELECT * FROM jikwon WHERE buser_num = 20;
ELSE
	SELECT * FROM jikwon WHERE buser_num IN(30,40);
END IF; -- if블럭 끝
END
$$
delimiter ;

CALL sp_4('대리',20);


-- ex 5
delimiter $$
CREATE OR REPLACE PROCEDURE sp_5()
BEGIN
	DECLARE x INT;
	DECLARE str VARCHAR(200);
	SET X = 1;
	SET str = '';
	-- WHILE -- while의 시작점
	
	WHILE X <= 5 DO
		SET str = CONCAT(str, X, ',');
		SET X = X + 1;
	END WHILE;
	-- while블럭 끝
	SELECT str;
END
$$
delimiter ;

CALL sp_5();



-- ex 6 : repeat --> 조건식을 다 넣어준 후에 until을 쓰고 언제까지 하는지 정해준다.
delimiter $$
CREATE OR REPLACE PROCEDURE sp_6()
BEGIN
	DECLARE x INT;
	DECLARE str VARCHAR(200);
	SET X = 1;
	SET str = '';
	
	REPEAT
		SET str = CONCAT(str, X, ',');
		SET X = X + 1;
	UNTIL X > 5	
	END repeat;
	
	SELECT str;
END
$$
delimiter ;

CALL sp_6();

-- 사용자 정의 함수 작성
-- ex1 : 전체직원의 연봉 평균 반환 함수
delimiter //
CREATE OR REPLACE FUNCTION fu_1() RETURNS DOUBLE
BEGIN
	DECLARE r DOUBLE;
	SELECT AVG(jikwon_pay) INTO r FROM jikwon;
	RETURN r;
END
//
delimiter ;

SELECT fu_1() AS 평균 FROM DUAL;


-- ex2 : 각 직원 연봉의 10% 반환하는 함수
delimiter //
CREATE OR REPLACE FUNCTION fu_2(NO INT) RETURNS INT
BEGIN
	DECLARE pay INT;
	SET pay = 0; -- 초기치
	SELECT jikwon_pay * 0.1 INTO pay FROM jikwon WHERE jikwon_no = NO;
	RETURN pay;
END
//
delimiter ;

SELECT fu_2(12) FROM DUAL;


-- ex3 : 각 직원 부서명 반환 함수
delimiter //
CREATE OR REPLACE FUNCTION fu_3(NO INT) RETURNS VARCHAR(10) CHARSET UTF8
BEGIN
	DECLARE bname VARCHAR(10) CHARSET UTF8 ;
	SELECT buser_name INTO bname FROM buser
	WHERE buser_no =(SELECT buser_num FROM jikwon WHERE jikwon_no=NO);
	RETURN bname;
END
//
delimiter ;

SELECT fu_3(7) FROM DUAL;



-- ex4 : 부서번호 입력 시 부서명 반환 함수
delimiter //
CREATE OR REPLACE FUNCTION fu_4(NO INT) RETURNS VARCHAR(10) CHARSET UTF8
BEGIN
	DECLARE bname VARCHAR(10) CHARSET UTF8 ;
	SELECT buser_name INTO bname FROM buser
	WHERE buser_no = NO;
	RETURN bname;
END
//
delimiter ;

SELECT fu_4(10) FROM DUAL;

SELECT jikwon_no, jikwon_name, buser_num, fu_4(buser_num) AS buser_name FROM jikwon;


