-- 9장. 뷰,시퀀스,시노님
-- scott계정

-- // 뷰 View

-- 1. 복잡한 SQL문을 단순화
-- 복잡한 SQL문
SELECT empno, ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

-- 뷰로 단순화
CREATE VIEW emp_view
AS
SELECT empno, ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

CREATE VIEW emp_view10 (no, name, dname, dno)  -- 별칭 일대일 
AS
SELECT empno, ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

-- 뷰 실행
SELECT * 
FROM EMP_VIEW;

SELECT * 
FROM EMP_VIEW10; -- 별칭으로 출력

-- 2. 테이블의 특정 컬럼 보호 (보안강화)
-- 민간함 정보인 월급(sal)을 제외하고 출력
CREATE VIEW emp_view2
AS
SELECT empno,ename,job,mgr,hiredate,comm,deptno
FROM emp; 

SELECT * 
FROM EMP_VIEW2;

-- // 뷰 수정 : CREATE OR REPLACE (ALTER문 없음)
CREATE OR REPLACE VIEW emp_view2
AS
SELECT empno,ename,job
FROM emp;


-- // WITH READ ONLY
-- CTAS 테이블 생성
CREATE TABLE copy_emp
AS
SELECT *
FROM emp;

SELECT * 
FROM copy_emp;

-- 뷰 생성
CREATE OR REPLACE VIEW copy_emp_view
AS
SELECT *
FROM copy_emp; -- base table

SELECT * 
FROM copy_emp_view;

-- DML : 뷰 삭제시 베이스테이블도 삭제됨 (뷰 생성시 group by, distinct 등 적용시 DML안됨)
DELETE FROM COPY_EMP_VIEW
WHERE deptno = 20;

-- DML 불가능하도록 읽기모드 뷰 생성
CREATE OR REPLACE VIEW copy_emp_view2
AS
SELECT *
FROM copy_emp
with READ ONLY; -- DML불가 제약조건 지정 

DELETE FROM COPY_EMP_VIEW2 -- 에러
WHERE deptno = 20; 

-- // 뷰를 셀렉트시 뷰가 가지고 있는 SQL문을 보여주기만 하는 것(TEXT), 뷰가 실제 데이터를 가진 것 아님
SELECT * 
FROM user_views;

-- // 뷰 삭제
DROP VIEW COPY_EMP_VIEW2;


-- ////////////////////////////////////////////////////////
-- // 시퀀스 sequence

-- base table 생성
create table copy_dept
as
select deptno as no, dname as name, loc as addr
from dept
where 1=2;

SELECT * FROM copy_dept;

-- 시퀀스 생성
CREATE SEQUENCE copy_dept_no_seq -- 관례: base table_컬럼명_시퀀스
 START WITH 10
 INCREMENT BY 10
 MAXVALUE 100
 MINVALUE 5
 CYCLE -- 다시 시작값은 MINVALUE (START WITH 아님), 일반적으로는 NOCYCLE
 NOCACHE;
 
-- 시퀀스에서 값을 가져오기 : 시퀀스명.nextval
-- 현재 생성된 값 확인 : 시퀀스명.currval

select copy_dept_no_seq.nextval
from dual; 
-- 10 -> 20 -> ... 100 -> 5 ... -> 95

CREATE SEQUENCE dept_deptno_seq2
 START WITH 100
 INCREMENT BY -10
 MAXVALUE 150
 MINVALUE 10
 CYCLE  -- 다시 시작값은 MAXVALUE
 NOCACHE;

select dept_deptno_seq2.nextval, dept_deptno_seq2.currval
from dual;

create SEQUENCE my_seq; -- 기본값으로 시퀀스 생성 (1부터 1씩 증가..)

-- // 메타정보 (START WITH 정보는 없음 => 시퀀스 수정시 수정 불가)
SELECT * FROM user_sequences;


-- // my_seq 시퀀스 이용해서 copy_dept 테이블의 no컬럼을 넘버링하기

SELECT * FROM copy_dept;  -- 데이터 없음

insert into copy_dept (no, name, addr) values (my_seq.nextval, 'aa', '서울');  -- 넘버를 시퀀스에서 가져옴
insert into copy_dept (no, name, addr) values (my_seq.nextval, 'bb', '서울');
insert into copy_dept (no, name, addr) values (my_seq.nextval, 'cc', '서울');

DROP SEQUENCE dept_deptno_seq2;


-- // 시노님 synonym : 관리자계정에서.