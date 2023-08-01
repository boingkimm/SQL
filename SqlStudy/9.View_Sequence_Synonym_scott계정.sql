-- 9��. ��,������,�ó��
-- scott����

-- // �� View

-- 1. ������ SQL���� �ܼ�ȭ
-- ������ SQL��
SELECT empno, ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

-- ��� �ܼ�ȭ
CREATE VIEW emp_view
AS
SELECT empno, ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

CREATE VIEW emp_view10 (no, name, dname, dno)  -- ��Ī �ϴ��� 
AS
SELECT empno, ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

-- �� ����
SELECT * 
FROM EMP_VIEW;

SELECT * 
FROM EMP_VIEW10; -- ��Ī���� ���

-- 2. ���̺��� Ư�� �÷� ��ȣ (���Ȱ�ȭ)
-- �ΰ��� ������ ����(sal)�� �����ϰ� ���
CREATE VIEW emp_view2
AS
SELECT empno,ename,job,mgr,hiredate,comm,deptno
FROM emp; 

SELECT * 
FROM EMP_VIEW2;

-- // �� ���� : CREATE OR REPLACE (ALTER�� ����)
CREATE OR REPLACE VIEW emp_view2
AS
SELECT empno,ename,job
FROM emp;


-- // WITH READ ONLY
-- CTAS ���̺� ����
CREATE TABLE copy_emp
AS
SELECT *
FROM emp;

SELECT * 
FROM copy_emp;

-- �� ����
CREATE OR REPLACE VIEW copy_emp_view
AS
SELECT *
FROM copy_emp; -- base table

SELECT * 
FROM copy_emp_view;

-- DML : �� ������ ���̽����̺� ������ (�� ������ group by, distinct �� ����� DML�ȵ�)
DELETE FROM COPY_EMP_VIEW
WHERE deptno = 20;

-- DML �Ұ����ϵ��� �б��� �� ����
CREATE OR REPLACE VIEW copy_emp_view2
AS
SELECT *
FROM copy_emp
with READ ONLY; -- DML�Ұ� �������� ���� 

DELETE FROM COPY_EMP_VIEW2 -- ����
WHERE deptno = 20; 

-- // �並 ����Ʈ�� �䰡 ������ �ִ� SQL���� �����ֱ⸸ �ϴ� ��(TEXT), �䰡 ���� �����͸� ���� �� �ƴ�
SELECT * 
FROM user_views;

-- // �� ����
DROP VIEW COPY_EMP_VIEW2;


-- ////////////////////////////////////////////////////////
-- // ������ sequence

-- base table ����
create table copy_dept
as
select deptno as no, dname as name, loc as addr
from dept
where 1=2;

SELECT * FROM copy_dept;

-- ������ ����
CREATE SEQUENCE copy_dept_no_seq -- ����: base table_�÷���_������
 START WITH 10
 INCREMENT BY 10
 MAXVALUE 100
 MINVALUE 5
 CYCLE -- �ٽ� ���۰��� MINVALUE (START WITH �ƴ�), �Ϲ������δ� NOCYCLE
 NOCACHE;
 
-- ���������� ���� �������� : ��������.nextval
-- ���� ������ �� Ȯ�� : ��������.currval

select copy_dept_no_seq.nextval
from dual; 
-- 10 -> 20 -> ... 100 -> 5 ... -> 95

CREATE SEQUENCE dept_deptno_seq2
 START WITH 100
 INCREMENT BY -10
 MAXVALUE 150
 MINVALUE 10
 CYCLE  -- �ٽ� ���۰��� MAXVALUE
 NOCACHE;

select dept_deptno_seq2.nextval, dept_deptno_seq2.currval
from dual;

create SEQUENCE my_seq; -- �⺻������ ������ ���� (1���� 1�� ����..)

-- // ��Ÿ���� (START WITH ������ ���� => ������ ������ ���� �Ұ�)
SELECT * FROM user_sequences;


-- // my_seq ������ �̿��ؼ� copy_dept ���̺��� no�÷��� �ѹ����ϱ�

SELECT * FROM copy_dept;  -- ������ ����

insert into copy_dept (no, name, addr) values (my_seq.nextval, 'aa', '����');  -- �ѹ��� ���������� ������
insert into copy_dept (no, name, addr) values (my_seq.nextval, 'bb', '����');
insert into copy_dept (no, name, addr) values (my_seq.nextval, 'cc', '����');

DROP SEQUENCE dept_deptno_seq2;


-- // �ó�� synonym : �����ڰ�������.