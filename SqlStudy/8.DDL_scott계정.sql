-- DDL
-- ��������
-- scott����

-- // 1. ���̺� ���� CREATE

-- CTAS
/*
CREATE TABLE
AS
SUBQUERY;
*/

-- �Ϲ����� ���1 (���� ���X)
-- �������� ����. ��� �÷��� �ߺ� ����. null ����.
-- ���� �� �÷����� ������� ���� �÷��� �ڵ����� null �����
CREATE TABLE scott.employee
( empno NUMBER(4),
 ename VARCHAR2(20),
 hiredate DATE,
 sal NUMBER(7,2));
 
CREATE TABLE employee10  -- ��Ű���� ������ ������ ������ ������� (scott)
( empno NUMBER(4),
 ename VARCHAR2(20),
 hiredate DATE,
 sal NUMBER(7,2));
 
-- �Ϲ����� ���2 : DEFAULT �ɼ� (���� ���X)
-- ��������� ���� �������� �ʾƵ� �ڵ����� �⺻������ ����� (null���� ���� ����), �ߺ���

CREATE TABLE employee2
( empno NUMBER(4),
 ename VARCHAR2(20),
 hiredate DATE DEFAULT SYSDATE,
 sal NUMBER(7,2));
 
INSERT INTO employee2 ( empno,ename,sal)
VALUES ( 10, 'ȫ�浿',3000);  -- hiredate���� DEFAULT��(SYSDATE) �����

select *
from EMPLOYEE2;

-- ///////////////////////////////////
-- �Ϲ����� ���3 - �������� Constraints

-- ��. PRIMARY KEY ��������Ÿ�� - �÷�����
CREATE TABLE department
( deptno NUMBER(2) CONSTRAINT department_deptno_pk PRIMARY KEY,
 dname VARCHAR2(15),
 loc VARCHAR2(15) );

CREATE TABLE department10
( deptno NUMBER(2) PRIMARY KEY, -- �������Ǹ� �������� �ڵ����� ���� (SYS_C007065) - �������
 dname VARCHAR2(15),
 loc VARCHAR2(15) );
 
-- �������� Ȯ��
SELECT * 
FROM USER_CONSTRAINTS
where TABLE_NAME = 'DEPARTMENT10';

-- ��. PRIMARY KEY ��������Ÿ�� - ���̺���
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
 CONSTRAINT department3_deptno_pk PRIMARY KEY(deptno, loc) -- �����÷��� ���̺����� ����
);


-- ��. UNIQUE ��������Ÿ�� - �÷�����
CREATE TABLE department4
( deptno NUMBER(2) CONSTRAINT department4_deptno_pk PRIMARY KEY, -- UNIQUE, NOT NULL
 dname VARCHAR2(15) CONSTRAINT department4_dname_uk UNIQUE, -- UNIQUE, NULL���
 loc VARCHAR2(15) );
 
insert into department4 ( deptno, dname, loc ) values ( 1, 'aa', 'bb');
insert into department4 ( deptno, dname, loc ) values ( 2, null, 'bb');

-- ��. UNIQUE ��������Ÿ�� - ���̺���
CREATE TABLE department5
( deptno NUMBER(2) CONSTRAINT department5_deptno_pk PRIMARY KEY,  -- �÷�����
 dname VARCHAR2(15), 
 loc VARCHAR2(15),
 CONSTRAINT department5_dname_uk UNIQUE(dname)  -- ���̺���
);

CREATE TABLE department11
( deptno NUMBER(2),
 dname VARCHAR2(15), 
 loc VARCHAR2(15),
CONSTRAINT department11_deptno_pk PRIMARY KEY(deptno),
CONSTRAINT department11_dname_uk UNIQUE(dname)
);

-- ��. NOT NULL ��������Ÿ�� - �÷�����
CREATE TABLE department6
( deptno NUMBER(2) CONSTRAINT department6_deptno_pk PRIMARY KEY,
 dname VARCHAR2(15) CONSTRAINT department6_dname_uk UNIQUE,
 loc VARCHAR2(15) CONSTRAINT department6_loc_nn NOT NULL);

-- ��. NOT NULL ��������Ÿ�� - ���̺��� ���� �ȵ�
CREATE TABLE department12
( deptno NUMBER(2),
 dname VARCHAR2(15),
 loc VARCHAR2(15) CONSTRAINT department12_loc_nn NOT NULL,
 CONSTRAINT department12_deptno_pk PRIMARY KEY(deptno),
 CONSTRAINT department12_dname_uk UNIQUE(dname)
);

-- ��. CHECK ��������Ÿ�� - �÷�����
CREATE TABLE department7
( deptno NUMBER(2) ,
 dname VARCHAR2(15) CONSTRAINT department7_dname_ck CHECK( dname IN('����','�λ�')) ,
 loc VARCHAR2(15) 
);

insert into department7 ( deptno, dname, loc ) values ( 1, '����', 'bb');
insert into department7 ( deptno, dname, loc ) values ( 2, '�λ�', 'bb');
insert into department7 ( deptno, dname, loc ) values ( 3, '����', 'bb'); -- ����

-- ��. CHECK ��������Ÿ�� - ���̺���
CREATE TABLE department8
( deptno NUMBER(2) ,
 dname VARCHAR2(15),
 loc VARCHAR2(15),
CONSTRAINT department8_dname_ck CHECK( dname IN('����','�λ�')) 
);

-- ////////////////////////////////////////////
-- ��. FOREIGN KEY ��������Ÿ�� - �÷����� ***
-- master���̺� ����
CREATE TABLE m1
( no NUMBER(2) CONSTRAINT m1_no_pk PRIMARY KEY,  -- PK ����
  name VARCHAR2(10) );
  
-- ������ �ۼ�
INSERT INTO m1 (no,name) VALUES (10,'aa');
INSERT INTO m1 (no,name) VALUES (20,'bb');
INSERT INTO m1 (no,name) VALUES (30,'cc');
commit;

-- slave���̺� ����
CREATE TABLE s1
( num NUMBER(4) CONSTRAINT s1_num_pk PRIMARY KEY,  -- PK ����
  email VARCHAR2(20),
  -- FK ����(no NUMBER(2)) -> m1�� no�� ���� (�̸�, ũ��, Ÿ�� ��ġ�ϰ� ����)
  no NUMBER(2) CONSTRAINT s1_no_fk REFERENCES m1(no)
  );

insert into s1 (num, email, no) values (100, 'xxx', 10);  -- m1_no�� �ִ� �����͸� ����
insert into s1 (num, email, no) values (200, 'xxx2', 20);
insert into s1 (num, email, no) values (300, 'xxx3', 30);
insert into s1 (num, email, no) values (400, 'xxx4', null);

insert into s1 (num, email, no) values (500, 'xxx5', 40); -- ���� (m1�� 40 ����)



-- ��. FOREIGN KEY ��������Ÿ�� - ���̺��� ***
-- master���̺� ����
CREATE TABLE m2
( no NUMBER(2) CONSTRAINT m2_no_pk PRIMARY KEY,  -- PK ����
  name VARCHAR2(10) );
  
-- ������ �ۼ�
INSERT INTO m2 (no,name) VALUES (10,'aa');
INSERT INTO m2 (no,name) VALUES (20,'bb');
INSERT INTO m2 (no,name) VALUES (30,'cc');
commit;

SELECT * FROM m2;

-- slave���̺� ����
CREATE TABLE s2
( num NUMBER(4) CONSTRAINT s2_num_pk PRIMARY KEY,
  email VARCHAR2(20),
  no NUMBER(2),
-- FK �۾� : s1�� no�� fk�� -> m2�� no�� ����
  CONSTRAINT s2_no_fk FOREIGN KEY(no) REFERENCES m2(no)
);
  
insert into s2 (num, email, no) values (100, 'xxx', 10);  -- m1_no�� �ִ� �����͸� ����
insert into s2 (num, email, no) values (200, 'xxx2', 20);
insert into s2 (num, email, no) values (300, 'xxx3', 30);
insert into s2 (num, email, no) values (400, 'xxx4', null);

insert into s2 (num, email, no) values (500, 'xxx5', 40); -- ���� (m1�� 40 ����)


-- ///////////////////////////////////////////////

-- 1. FK�̽� : slave�� �����ϴ� master�� ���� ������ �� ����.
delete from m1
where no = 10; -- ����

-- // ON DELETE CASCADE

-- master���̺� ����
CREATE TABLE m3
( no NUMBER(2) CONSTRAINT m3_no_pk PRIMARY KEY,
  name VARCHAR2(10) );
  
-- ������ �ۼ�
INSERT INTO m3 (no,name) VALUES (10,'aa');
INSERT INTO m3 (no,name) VALUES (20,'bb');
INSERT INTO m3 (no,name) VALUES (30,'cc');

-- slave���̺� ����
CREATE TABLE s3
( num NUMBER(4) CONSTRAINT s3_num_pk PRIMARY KEY,
  email VARCHAR2(20),
  -- FK �۾� �� �ɼ� ����
  no NUMBER(2) CONSTRAINT s3_no_fk REFERENCES m3(no) ON DELETE CASCADE
  );

insert into s3 (num, email, no) values (100, 'xxx', 10);
insert into s3 (num, email, no) values (200, 'xxx2', 20);
insert into s3 (num, email, no) values (300, 'xxx3', 30);
insert into s3 (num, email, no) values (400, 'xxx4', null);
commit;

SELECT * FROM m3;
SELECT * FROM s3;

-- m3�� 10 ���� �� s3�� 10 ���ڵ� ���� ������
delete from m3
where no = 10;


-- // ON DELETE SET NULL

-- master���̺� ����
CREATE TABLE m4
( no NUMBER(2) CONSTRAINT m4_no_pk PRIMARY KEY,
  name VARCHAR2(10) );
  
-- ������ �ۼ�
INSERT INTO m4 (no,name) VALUES (10,'aa');
INSERT INTO m4 (no,name) VALUES (20,'bb');
INSERT INTO m4 (no,name) VALUES (30,'cc');

-- slave���̺� ����
CREATE TABLE s4
( num NUMBER(4) CONSTRAINT s4_num_pk PRIMARY KEY,
  email VARCHAR2(20),
  -- FK �۾� �� �ɼ� ����
  no NUMBER(2) CONSTRAINT s4_no_fk REFERENCES m4(no) ON DELETE SET NULL
  );

insert into s4 (num, email, no) values (100, 'xxx', 10);
insert into s4 (num, email, no) values (200, 'xxx2', 20);
insert into s4 (num, email, no) values (300, 'xxx3', 30);
insert into s4 (num, email, no) values (400, 'xxx4', null);
commit;

SELECT * FROM m4;
SELECT * FROM s4;

-- m4�� 10 ���� �� s4�� 10�� null�� �����
delete from m4
where no = 10;





-- ###########################################################

-- // 2. ���̺� ���� DROP

DROP TABLE mydept;
DROP TABLE mydept10;

-- ������ �ȵǴ� ���
-- m1�� �����ϴ� ��� s1�� FK���� ���� ���� �����ϰ� �� - �������� ����
-- �������ϴ� ���������̺��� �۾��� ��������

drop TABLE m1;

-- m1�� s1 �������� Ȯ��
select *
from USER_CONSTRAINTS
where TABLE_NAME = 'M1';

select *
from USER_CONSTRAINTS
where TABLE_NAME = 'S1';  -- 2�� (S1_NUM_PK, S1_NO_FK)

-- CASCADE CONSTRAINTS : s1�� FK���������� ����. m1�� drop��������
drop table m1 CASCADE CONSTRAINTS;  

select *
from USER_CONSTRAINTS
where TABLE_NAME = 'S1';  -- 1��(S1_NO_FK�� ������), �����ʹ� ��������





-- ###########################################################

-- // 3. ���̺� ���� ALTER


-- // �÷� �߰� ALTER TABLE ADD 
CREATE TABLE emp04
AS
SELECT * FROM emp;

ALTER TABLE emp04
ADD ( email VARCHAR2(10) , address VARCHAR2(20) );

-- // �÷� ���� ALTER TABLE MODIFY 
ALTER TABLE emp04
MODIFY ( email VARCHAR2(40) );

desc emp04;
SELECT * FROM emp04;

-- // �÷� ���� ALTER TABLE DROP
ALTER TABLE emp04
DROP ( email );

-- // �������� �߰� ALTER TABLE ADD / ALTER TABLE MODIFY (NOT NULL) ***
CREATE TABLE dept03
( deptno NUMBER(2),
 dname VARCHAR2(15),
 loc VARCHAR2(15)
); -- �������� ���� ���̺� ����

ALTER TABLE dept03
ADD CONSTRAINT dept03_deptno_pk PRIMARY KEY(deptno);

ALTER TABLE dept03
ADD CONSTRAINT dept03_loc_uk UNIQUE (loc);

-- NOT NULL �������� �߰� : null -> not null �����۾�
ALTER TABLE dept03
MODIFY ( dname VARCHAR2(15) CONSTRAINT dept03_dname_nn NOT NULL );

-- // ���������� �߰��� ���� Ȯ��
SELECT table_name,constraint_type, 
 constraint_name, r_constraint_name
FROM user_constraints
WHERE table_name IN ('DEPT03');


-- // �������� ���� ALTER TABLE DROP CONSTRAINT �������Ǹ� [CASCADE];
-- PK, UK�� ��������Ÿ������ ���� ����

-- PRIMARY KEY ����
ALTER TABLE dept03
DROP PRIMARY KEY;
-- DROP CONSTRAINT dept03_deptno_pk;

SELECT * 
FROM USER_CONSTRAINTS
where table_name = 'DEPT03';

-- UNIQUE ����
ALTER TABLE dept03
DROP UNIQUE(loc);
-- DROP CONSTRAINT dept03_loc_uk;

-- NOT NULL ���� (5���� �������� ����)
ALTER TABLE dept03
DROP CONSTRAINT dept03_dname_nn;

-- // CASCADE
SELECT * 
FROM USER_CONSTRAINTS
where table_name = 'M2';  -- master

SELECT * 
FROM USER_CONSTRAINTS
where table_name = 'S2';  -- slave

-- M2�� PK ����
--ALTER TABLE M2
--DROP PRIMARY KEY; -- ���� (S2�� ������)

ALTER TABLE M2
DROP PRIMARY KEY CASCADE; -- S2�� FK���� ���� ������
