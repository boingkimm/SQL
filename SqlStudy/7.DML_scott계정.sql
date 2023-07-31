-- DML
-- scott계정

-- // 1. INSERT문

-- // 단일행 INSERT문

-- 가. 컬럼명 지정
INSERT INTO dept( deptno, dname, loc )
VALUES ( 50 ,'개발','서울');

-- 지정하지 않은 컬럼에 자동으로 null값 저장
INSERT INTO dept( deptno, dname )
VALUES ( 51 ,'개발');

-- null값 명시적 지정가능 - ''(빈문자열) 또는 null 
INSERT INTO dept( deptno, dname, loc  )
VALUES ( 52 ,'', NULL);

INSERT INTO dept(deptno, dname , loc )
VALUES ( 80 ,'인사', NULL );


-- 나. 컬럼명 미지정 - 반드시 모든 데이터 설정해야 됨
INSERT INTO dept
VALUES ( 60 ,'인사','경기');

INSERT INTO dept
VALUES ( 60 ,'인사'); -- 에러

commit;

SELECT * FROM dept;

-- /////////////////

-- // 복수행 INSERT문
-- 서브쿼리 사용, CTAS

SELECT * FROM dept
WHERE 1=2;  -- 구조만 복사됨

-- 구조만 복사
CREATE TABLE mydept
AS
SELECT * FROM dept
WHERE 1=2;

-- 데이터까지 복사
CREATE TABLE mydept10
AS
SELECT * FROM dept;

-- mydept
SELECT *
FROM mydept;

INSERT INTO mydept
SELECT deptno,dname,loc
FROM dept;

commit;


-- //////////////////////////////

-- // 다중 테이블 다중행 INSERT문 

-- 가. 무조건 INSERT ALL
-- 테이블 생성
CREATE TABLE myemp_hire
AS
SELECT empno,ename,hiredate,sal
FROM emp
WHERE 1=2;  -- 구조만 복사

CREATE TABLE myemp_mgr
AS
SELECT empno,ename,mgr
FROM emp
WHERE 1=2;

select *
from myemp_hire;

select *
from myemp_mgr;

-- 데이터 저장
INSERT ALL
INTO myemp_hire VALUES ( empno,ename,hiredate,sal )
INTO myemp_mgr VALUES ( empno,ename,mgr )
SELECT empno,ename,hiredate,sal,mgr
FROM emp; -- 24개 행 삽입됨

commit;

SELECT empno,ename,hiredate,sal,mgr
FROM emp; -- 12개


-- 나. 조건 INSERT ALL ( + WHEN 조건식 THEN)
-- 테이블 생성
CREATE TABLE myemp_hire2
AS
SELECT empno,ename,hiredate,sal
FROM emp
WHERE 1=2;

CREATE TABLE myemp_mgr2
AS
SELECT empno,ename,mgr, sal
FROM emp
WHERE 1=2;

select *
from myemp_hire2;

select *
from myemp_mgr2;

-- 조건식에 맞는 데이터만 저장
-- 조건식1(=800)과 조건식2(<2500) 모두 만족 시 : 두 개의 테이블에 모두 저장됨(SMITH)
INSERT ALL
WHEN sal = 800 THEN
 INTO myemp_hire2 VALUES ( empno,ename,hiredate,sal )
WHEN sal < 2500 THEN
 INTO myemp_mgr2 VALUES ( empno,ename,mgr,sal )
SELECT empno,ename,hiredate,sal,mgr
FROM emp;


-- 다. INSERT FIRST ( + WHEN 조건식 THEN)
-- 테이블 생성
CREATE TABLE myemp_hire3
AS
SELECT empno,ename,hiredate,sal
FROM emp
WHERE 1=2;

CREATE TABLE myemp_mgr3
AS
SELECT empno,ename,mgr, sal
FROM emp
WHERE 1=2;

select *
from myemp_hire3;

select *
from myemp_mgr3;

-- 조건식에 맞는 데이터만 저장
-- 조건식1(=800)과 조건식2(<2500) 모두 만족 시 : 첫번째 테이블에만 저장됨(myemp_hire3에만 SMITH)
INSERT FIRST
WHEN sal = 800 THEN
 INTO myemp_hire3 VALUES ( empno,ename,hiredate,sal )
WHEN sal < 2500 THEN
 INTO myemp_mgr3 VALUES ( empno,ename,mgr,sal )
SELECT empno,ename,hiredate,sal,mgr
FROM emp;


-- /////////////////////////////////////////////
-- /////////////////////////////////////////////

-- 2. UPDATE문

SELECT * 
FROM MYDEPT;

UPDATE mydept
SET dname='영업', loc='경기' 
WHERE deptno = 50;

commit;

-- WHERE문 없으면 모든 레코드가 변경됨 (흔치 않음)
UPDATE mydept
SET dname='영업', loc='경기';

rollback;  -- 취소하기

-- 서브쿼리를 이용한 UPDATE문
UPDATE mydept
SET dname= ( SELECT dname
             FROM dept
             WHERE deptno = 10)
    ,loc= ( SELECT loc
            FROM dept
            WHERE deptno=20)
WHERE deptno = 60;

SELECT * 
FROM MYDEPT;

commit;


-- /////////////////////////////////////////////
-- /////////////////////////////////////////////

-- 3. DELETE문

DELETE FROM mydept
WHERE deptno = 50;
commit;

-- WHERE문 없으면 모든 레코드가 변경됨 (흔치 않음)
DELETE FROM mydept;

rollback;  -- 취소하기

-- 서브쿼리를 이용한 DELETE문
DELETE 
FROM mydept
WHERE loc = (SELECT loc
             FROM dept
             WHERE deptno = 20);
commit;

-- 한글 byte 확인
select *
from NLS_DATABASE_PARAMETERS
where parameter = 'NLS_CHARACTERSET'; -- AL32UTF8 (한글3byte)

