-- DDL
-- 제약조건
-- scott계정

-- // 1. 테이블 생성 CREATE

-- CTAS
/*
CREATE TABLE
AS
SUBQUERY;
*/

-- 일반적인 방법1 (실제 사용X)
-- 제약조건 없음. 모든 컬럼에 중복 가능. null 가능.
-- 저장 시 컬럼명을 명시하지 않은 컬럼은 자동으로 null 저장됨
CREATE TABLE scott.employee
( empno NUMBER(4),
 ename VARCHAR2(20),
 hiredate DATE,
 sal NUMBER(7,2));
 
CREATE TABLE employee10  -- 스키마명 없으면 접속한 계정에 만들어짐 (scott)
( empno NUMBER(4),
 ename VARCHAR2(20),
 hiredate DATE,
 sal NUMBER(7,2));
 
-- 일반적인 방법2 : DEFAULT 옵션 (실제 사용X)
-- 명시적으로 값을 저장하지 않아도 자동으로 기본값으로 저장됨 (null저장 방지 가능), 중복값

CREATE TABLE employee2
( empno NUMBER(4),
 ename VARCHAR2(20),
 hiredate DATE DEFAULT SYSDATE,
 sal NUMBER(7,2));
 
INSERT INTO employee2 ( empno,ename,sal)
VALUES ( 10, '홍길동',3000);  -- hiredate에는 DEFAULT값(SYSDATE) 저장됨

select *
from EMPLOYEE2;

-- ///////////////////////////////////
-- 일반적인 방법3 - 제약조건 Constraints

-- 가. PRIMARY KEY 제약조건타입 - 컬럼레벨
CREATE TABLE department
( deptno NUMBER(2) CONSTRAINT department_deptno_pk PRIMARY KEY,
 dname VARCHAR2(15),
 loc VARCHAR2(15) );

CREATE TABLE department10
( deptno NUMBER(2) PRIMARY KEY, -- 제약조건명 미지정시 자동으로 생성 (SYS_C007065) - 권장안함
 dname VARCHAR2(15),
 loc VARCHAR2(15) );
 
-- 제약조건 확인
SELECT * 
FROM USER_CONSTRAINTS
where TABLE_NAME = 'DEPARTMENT10';

-- 가. PRIMARY KEY 제약조건타입 - 테이블레벨
CREATE TABLE department2
( deptno NUMBER(2), 
 dname VARCHAR2(15),
 loc VARCHAR2(15) ,
 CONSTRAINT department2_deptno_pk PRIMARY KEY(deptno)
);

CREATE TABLE department3
( deptno NUMBER(2), 
 dname VARCHAR2(15),
 loc VARCHAR2(15) ,
 CONSTRAINT department3_deptno_pk PRIMARY KEY(deptno, loc) -- 복합컬럼은 테이블레벨만 가능
);


-- 나. UNIQUE 제약조건타입 - 컬럼레벨
CREATE TABLE department4
( deptno NUMBER(2) CONSTRAINT department4_deptno_pk PRIMARY KEY, -- UNIQUE, NOT NULL
 dname VARCHAR2(15) CONSTRAINT department4_dname_uk UNIQUE, -- UNIQUE, NULL허용
 loc VARCHAR2(15) );
 
insert into department4 ( deptno, dname, loc ) values ( 1, 'aa', 'bb');
insert into department4 ( deptno, dname, loc ) values ( 2, null, 'bb');

-- 나. UNIQUE 제약조건타입 - 테이블레벨
CREATE TABLE department5
( deptno NUMBER(2) CONSTRAINT department5_deptno_pk PRIMARY KEY,  -- 컬럼레벨
 dname VARCHAR2(15), 
 loc VARCHAR2(15),
 CONSTRAINT department5_dname_uk UNIQUE(dname)  -- 테이블레벨
);

CREATE TABLE department11
( deptno NUMBER(2),
 dname VARCHAR2(15), 
 loc VARCHAR2(15),
CONSTRAINT department11_deptno_pk PRIMARY KEY(deptno),
CONSTRAINT department11_dname_uk UNIQUE(dname)
);

-- 다. NOT NULL 제약조건타입 - 컬럼레벨
CREATE TABLE department6
( deptno NUMBER(2) CONSTRAINT department6_deptno_pk PRIMARY KEY,
 dname VARCHAR2(15) CONSTRAINT department6_dname_uk UNIQUE,
 loc VARCHAR2(15) CONSTRAINT department6_loc_nn NOT NULL);

-- 다. NOT NULL 제약조건타입 - 테이블레벨 지원 안됨
CREATE TABLE department12
( deptno NUMBER(2),
 dname VARCHAR2(15),
 loc VARCHAR2(15) CONSTRAINT department12_loc_nn NOT NULL,
 CONSTRAINT department12_deptno_pk PRIMARY KEY(deptno),
 CONSTRAINT department12_dname_uk UNIQUE(dname)
);

-- 라. CHECK 제약조건타입 - 컬럼레벨
CREATE TABLE department7
( deptno NUMBER(2) ,
 dname VARCHAR2(15) CONSTRAINT department7_dname_ck CHECK( dname IN('개발','인사')) ,
 loc VARCHAR2(15) 
);

insert into department7 ( deptno, dname, loc ) values ( 1, '개발', 'bb');
insert into department7 ( deptno, dname, loc ) values ( 2, '인사', 'bb');
insert into department7 ( deptno, dname, loc ) values ( 3, '관리', 'bb'); -- 에러

-- 라. CHECK 제약조건타입 - 테이블레벨
CREATE TABLE department8
( deptno NUMBER(2) ,
 dname VARCHAR2(15),
 loc VARCHAR2(15),
CONSTRAINT department8_dname_ck CHECK( dname IN('개발','인사')) 
);

-- ////////////////////////////////////////////
-- 마. FOREIGN KEY 제약조건타입 - 컬럼레벨 ***
-- master테이블 생성
CREATE TABLE m1
( no NUMBER(2) CONSTRAINT m1_no_pk PRIMARY KEY,  -- PK 생성
  name VARCHAR2(10) );
  
-- 데이터 작성
INSERT INTO m1 (no,name) VALUES (10,'aa');
INSERT INTO m1 (no,name) VALUES (20,'bb');
INSERT INTO m1 (no,name) VALUES (30,'cc');
commit;

-- slave테이블 생성
CREATE TABLE s1
( num NUMBER(4) CONSTRAINT s1_num_pk PRIMARY KEY,  -- PK 생성
  email VARCHAR2(20),
  -- FK 생성(no NUMBER(2)) -> m1의 no에 접근 (이름, 크기, 타입 일치하게 생성)
  no NUMBER(2) CONSTRAINT s1_no_fk REFERENCES m1(no)
  );

insert into s1 (num, email, no) values (100, 'xxx', 10);  -- m1_no에 있는 데이터만 가능
insert into s1 (num, email, no) values (200, 'xxx2', 20);
insert into s1 (num, email, no) values (300, 'xxx3', 30);
insert into s1 (num, email, no) values (400, 'xxx4', null);

insert into s1 (num, email, no) values (500, 'xxx5', 40); -- 에러 (m1에 40 없음)



-- 마. FOREIGN KEY 제약조건타입 - 테이블레벨 ***
-- master테이블 생성
CREATE TABLE m2
( no NUMBER(2) CONSTRAINT m2_no_pk PRIMARY KEY,  -- PK 생성
  name VARCHAR2(10) );
  
-- 데이터 작성
INSERT INTO m2 (no,name) VALUES (10,'aa');
INSERT INTO m2 (no,name) VALUES (20,'bb');
INSERT INTO m2 (no,name) VALUES (30,'cc');
commit;

SELECT * FROM m2;

-- slave테이블 생성
CREATE TABLE s2
( num NUMBER(4) CONSTRAINT s2_num_pk PRIMARY KEY,
  email VARCHAR2(20),
  no NUMBER(2),
-- FK 작업 : s1의 no가 fk임 -> m2의 no를 참조
  CONSTRAINT s2_no_fk FOREIGN KEY(no) REFERENCES m2(no)
);
  
insert into s2 (num, email, no) values (100, 'xxx', 10);  -- m1_no에 있는 데이터만 가능
insert into s2 (num, email, no) values (200, 'xxx2', 20);
insert into s2 (num, email, no) values (300, 'xxx3', 30);
insert into s2 (num, email, no) values (400, 'xxx4', null);

insert into s2 (num, email, no) values (500, 'xxx5', 40); -- 에러 (m1에 40 없음)


-- ///////////////////////////////////////////////

-- 1. FK이슈 : slave가 참조하는 master의 값을 삭제할 수 없다.
delete from m1
where no = 10; -- 에러

-- // ON DELETE CASCADE

-- master테이블 생성
CREATE TABLE m3
( no NUMBER(2) CONSTRAINT m3_no_pk PRIMARY KEY,
  name VARCHAR2(10) );
  
-- 데이터 작성
INSERT INTO m3 (no,name) VALUES (10,'aa');
INSERT INTO m3 (no,name) VALUES (20,'bb');
INSERT INTO m3 (no,name) VALUES (30,'cc');

-- slave테이블 생성
CREATE TABLE s3
( num NUMBER(4) CONSTRAINT s3_num_pk PRIMARY KEY,
  email VARCHAR2(20),
  -- FK 작업 시 옵션 지정
  no NUMBER(2) CONSTRAINT s3_no_fk REFERENCES m3(no) ON DELETE CASCADE
  );

insert into s3 (num, email, no) values (100, 'xxx', 10);
insert into s3 (num, email, no) values (200, 'xxx2', 20);
insert into s3 (num, email, no) values (300, 'xxx3', 30);
insert into s3 (num, email, no) values (400, 'xxx4', null);
commit;

SELECT * FROM m3;
SELECT * FROM s3;

-- m3의 10 삭제 시 s3의 10 레코드 같이 삭제됨
delete from m3
where no = 10;


-- // ON DELETE SET NULL

-- master테이블 생성
CREATE TABLE m4
( no NUMBER(2) CONSTRAINT m4_no_pk PRIMARY KEY,
  name VARCHAR2(10) );
  
-- 데이터 작성
INSERT INTO m4 (no,name) VALUES (10,'aa');
INSERT INTO m4 (no,name) VALUES (20,'bb');
INSERT INTO m4 (no,name) VALUES (30,'cc');

-- slave테이블 생성
CREATE TABLE s4
( num NUMBER(4) CONSTRAINT s4_num_pk PRIMARY KEY,
  email VARCHAR2(20),
  -- FK 작업 시 옵션 지정
  no NUMBER(2) CONSTRAINT s4_no_fk REFERENCES m4(no) ON DELETE SET NULL
  );

insert into s4 (num, email, no) values (100, 'xxx', 10);
insert into s4 (num, email, no) values (200, 'xxx2', 20);
insert into s4 (num, email, no) values (300, 'xxx3', 30);
insert into s4 (num, email, no) values (400, 'xxx4', null);
commit;

SELECT * FROM m4;
SELECT * FROM s4;

-- m4의 10 삭제 시 s4의 10이 null로 변경됨
delete from m4
where no = 10;





-- ###########################################################

-- // 2. 테이블 삭제 DROP

DROP TABLE mydept;
DROP TABLE mydept10;

-- 삭제가 안되는 경우
-- m1을 삭제하는 경우 s1의 FK값이 없는 값을 참조하게 됨 - 제약조건 위반
-- 참조당하는 마스터테이블은 작업에 제한있음

drop TABLE m1;

-- m1과 s1 제약조건 확인
select *
from USER_CONSTRAINTS
where TABLE_NAME = 'M1';

select *
from USER_CONSTRAINTS
where TABLE_NAME = 'S1';  -- 2개 (S1_NUM_PK, S1_NO_FK)

-- CASCADE CONSTRAINTS : s1의 FK제약조건을 삭제. m1이 drop가능해짐
drop table m1 CASCADE CONSTRAINTS;  

select *
from USER_CONSTRAINTS
where TABLE_NAME = 'S1';  -- 1개(S1_NO_FK가 삭제됨), 데이터는 남아있음





-- ###########################################################

-- // 3. 테이블 변경 ALTER


-- // 컬럼 추가 ALTER TABLE ADD 
CREATE TABLE emp04
AS
SELECT * FROM emp;

ALTER TABLE emp04
ADD ( email VARCHAR2(10) , address VARCHAR2(20) );

-- // 컬럼 변경 ALTER TABLE MODIFY 
ALTER TABLE emp04
MODIFY ( email VARCHAR2(40) );

desc emp04;
SELECT * FROM emp04;

-- // 컬럼 삭제 ALTER TABLE DROP
ALTER TABLE emp04
DROP ( email );

-- // 제약조건 추가 ALTER TABLE ADD / ALTER TABLE MODIFY (NOT NULL) ***
CREATE TABLE dept03
( deptno NUMBER(2),
 dname VARCHAR2(15),
 loc VARCHAR2(15)
); -- 제약조건 없는 테이블 생성

ALTER TABLE dept03
ADD CONSTRAINT dept03_deptno_pk PRIMARY KEY(deptno);

ALTER TABLE dept03
ADD CONSTRAINT dept03_loc_uk UNIQUE (loc);

-- NOT NULL 제약조건 추가 : null -> not null 변경작업
ALTER TABLE dept03
MODIFY ( dname VARCHAR2(15) CONSTRAINT dept03_dname_nn NOT NULL );

-- // 제약조건이 추가된 것을 확인
SELECT table_name,constraint_type, 
 constraint_name, r_constraint_name
FROM user_constraints
WHERE table_name IN ('DEPT03');


-- // 제약조건 삭제 ALTER TABLE DROP CONSTRAINT 제약조건명 [CASCADE];
-- PK, UK만 제약조건타입으로 삭제 가능

-- PRIMARY KEY 삭제
ALTER TABLE dept03
DROP PRIMARY KEY;
-- DROP CONSTRAINT dept03_deptno_pk;

SELECT * 
FROM USER_CONSTRAINTS
where table_name = 'DEPT03';

-- UNIQUE 삭제
ALTER TABLE dept03
DROP UNIQUE(loc);
-- DROP CONSTRAINT dept03_loc_uk;

-- NOT NULL 삭제 (5가지 제약조건 전부)
ALTER TABLE dept03
DROP CONSTRAINT dept03_dname_nn;

-- // CASCADE
SELECT * 
FROM USER_CONSTRAINTS
where table_name = 'M2';  -- master

SELECT * 
FROM USER_CONSTRAINTS
where table_name = 'S2';  -- slave

-- M2의 PK 삭제
--ALTER TABLE M2
--DROP PRIMARY KEY; -- 에러 (S2가 참조중)

ALTER TABLE M2
DROP PRIMARY KEY CASCADE; -- S2의 FK까지 같이 삭제됨
