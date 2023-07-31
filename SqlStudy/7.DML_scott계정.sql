-- DML
-- scott����

-- // 1. INSERT��

-- // ������ INSERT��

-- ��. �÷��� ����
INSERT INTO dept( deptno, dname, loc )
VALUES ( 50 ,'����','����');

-- �������� ���� �÷��� �ڵ����� null�� ����
INSERT INTO dept( deptno, dname )
VALUES ( 51 ,'����');

-- null�� ����� �������� - ''(���ڿ�) �Ǵ� null 
INSERT INTO dept( deptno, dname, loc  )
VALUES ( 52 ,'', NULL);

INSERT INTO dept(deptno, dname , loc )
VALUES ( 80 ,'�λ�', NULL );


-- ��. �÷��� ������ - �ݵ�� ��� ������ �����ؾ� ��
INSERT INTO dept
VALUES ( 60 ,'�λ�','���');

INSERT INTO dept
VALUES ( 60 ,'�λ�'); -- ����

commit;

SELECT * FROM dept;

-- /////////////////

-- // ������ INSERT��
-- �������� ���, CTAS

SELECT * FROM dept
WHERE 1=2;  -- ������ �����

-- ������ ����
CREATE TABLE mydept
AS
SELECT * FROM dept
WHERE 1=2;

-- �����ͱ��� ����
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

-- // ���� ���̺� ������ INSERT�� 

-- ��. ������ INSERT ALL
-- ���̺� ����
CREATE TABLE myemp_hire
AS
SELECT empno,ename,hiredate,sal
FROM emp
WHERE 1=2;  -- ������ ����

CREATE TABLE myemp_mgr
AS
SELECT empno,ename,mgr
FROM emp
WHERE 1=2;

select *
from myemp_hire;

select *
from myemp_mgr;

-- ������ ����
INSERT ALL
INTO myemp_hire VALUES ( empno,ename,hiredate,sal )
INTO myemp_mgr VALUES ( empno,ename,mgr )
SELECT empno,ename,hiredate,sal,mgr
FROM emp; -- 24�� �� ���Ե�

commit;

SELECT empno,ename,hiredate,sal,mgr
FROM emp; -- 12��


-- ��. ���� INSERT ALL ( + WHEN ���ǽ� THEN)
-- ���̺� ����
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

-- ���ǽĿ� �´� �����͸� ����
-- ���ǽ�1(=800)�� ���ǽ�2(<2500) ��� ���� �� : �� ���� ���̺� ��� �����(SMITH)
INSERT ALL
WHEN sal = 800 THEN
 INTO myemp_hire2 VALUES ( empno,ename,hiredate,sal )
WHEN sal < 2500 THEN
 INTO myemp_mgr2 VALUES ( empno,ename,mgr,sal )
SELECT empno,ename,hiredate,sal,mgr
FROM emp;


-- ��. INSERT FIRST ( + WHEN ���ǽ� THEN)
-- ���̺� ����
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

-- ���ǽĿ� �´� �����͸� ����
-- ���ǽ�1(=800)�� ���ǽ�2(<2500) ��� ���� �� : ù��° ���̺��� �����(myemp_hire3���� SMITH)
INSERT FIRST
WHEN sal = 800 THEN
 INTO myemp_hire3 VALUES ( empno,ename,hiredate,sal )
WHEN sal < 2500 THEN
 INTO myemp_mgr3 VALUES ( empno,ename,mgr,sal )
SELECT empno,ename,hiredate,sal,mgr
FROM emp;


-- /////////////////////////////////////////////
-- /////////////////////////////////////////////

-- 2. UPDATE��

SELECT * 
FROM MYDEPT;

UPDATE mydept
SET dname='����', loc='���' 
WHERE deptno = 50;

commit;

-- WHERE�� ������ ��� ���ڵ尡 ����� (��ġ ����)
UPDATE mydept
SET dname='����', loc='���';

rollback;  -- ����ϱ�

-- ���������� �̿��� UPDATE��
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

-- 3. DELETE��

DELETE FROM mydept
WHERE deptno = 50;
commit;

-- WHERE�� ������ ��� ���ڵ尡 ����� (��ġ ����)
DELETE FROM mydept;

rollback;  -- ����ϱ�

-- ���������� �̿��� DELETE��
DELETE 
FROM mydept
WHERE loc = (SELECT loc
             FROM dept
             WHERE deptno = 20);
commit;

-- �ѱ� byte Ȯ��
select *
from NLS_DATABASE_PARAMETERS
where parameter = 'NLS_CHARACTERSET'; -- AL32UTF8 (�ѱ�3byte)

