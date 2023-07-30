-- 1-3. ������ �Լ� - ��¥�Լ�

-- �⺻ ���� Ȯ��
select *
from NLS_SESSION_PARAMETERS;

-- ���̺� ����
create table exam
( a date, b date);

insert into exam (a, b)
values ( to_date('15/01/01','RR/MM/DD'), to_date('15/01/01','YY/MM/DD'));

-- ��¥�� ���ڷ� ��ȯ
select to_char(a,'RRRR'), to_char(b,'YYYY')
from exam;

-- �ý����� ������ 1995�⵵ ���� ��

insert into exam (a, b)
values ( to_date('15/01/01','RR/MM/DD'), to_date('15/01/01','YY/MM/DD'));

select to_char(a,'RRRR'), to_char(b,'YYYY')
from exam;

--////////////////////////////////////

-- SYSDATE : �ý����� ���� ��¥ ��ȯ
SELECT SYSDATE
FROM dual;

SELECT systimestamp
FROM dual;

-- ���� ����
SELECT SYSDATE ����, SYSDATE+1 ����, SYSDATE-1 ����
FROM dual;

-- ������� �ٹ��ϼ�
SELECT last_name, hire_date, TRUNC((sysdate-hire_date)/365) "��" FROM employees
ORDER BY 3 desc;

SELECT last_name, hire_date, TRUNC((sysdate-hire_date)/365) "��" FROM employees
ORDER BY TRUNC((sysdate-hire_date)/365) desc;

-- MONTHS_BETWEEN : ��¥ ������ ���� �� ��ȯ
SELECT last_name, hire_date, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) "�ٹ� ����" FROM employees
ORDER BY 3 desc;

-- ADD_MONTHS : Ư�� ���� �� ���ϱ� �� ����
SELECT sysdate ����, ADD_MONTHS(sysdate,1) ������,
 ADD_MONTHS(sysdate,-1) ������
FROM dual;

-- NEXT_DAY : ������ ��¥���ؿ� ���ƿ��� ���� ����� ���Ͽ� �ش��ϴ� ��¥ ��ȯ
SELECT sysdate, NEXT_DAY(sysdate, '��'),NEXT_DAY(sysdate, '�����'), NEXT_DAY(sysdate, 7)
FROM dual;

-- LAST_DAY : ������ ��¥�� ���� ������ ��¥ ��ȯ
SELECT sysdate, LAST_DAY(sysdate), LAST_DAY(add_months(sysdate,1))
FROM dual;

-- ROUND : �⵵ �Ǵ� ���� �ݿø�
SELECT last_name, hire_date, 
 ROUND(hire_date,'YEAR'),
 ROUND(hire_date,'MONTH')
FROM employees;

-- TRUNC : �⵵ �Ǵ� ���� ����
SELECT last_name, hire_date, 
 TRUNC(hire_date,'YEAR'),
 TRUNC(hire_date,'MONTH')
FROM employees;

-- ////////////////////////////////////////////
-- 1-4. ������ �Լ� - ��ȯ�Լ�

-- ���� <--> ���ڿ� <--> ��¥ 

-- �ڵ� ����ȯ 
SELECT last_name, salary
FROM employees
WHERE salary = '17000';  -- salary:number, ���ڰ� ���ڷ�

SELECT last_name, salary
FROM employees
WHERE HIRE_DATE = '03/06/17'; -- ���ڰ� ��¥�� �ڵ� ����ȯ

-- ����� ����ȯ
-- // ��¥ --> ����
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD,(AM) MON DY DAY HH24:MI:SS')
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') -- �ֵ���ǥ�� �ȿ�
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY,MM-DD')
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'HH:MI:SS')
FROM dual;

-- ��¥���� Ư�� �⵵, ��, �ϸ� ����
-- TO_CHAR 
select sysdate, to_char(sysdate, 'YYYY'), to_char(sysdate, 'MM')
from dual;

-- EXTRACT
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE),
                EXTRACT(MONTH FROM SYSDATE),
                EXTRACT(DAY FROM SYSDATE),
                EXTRACT(HOUR FROM SYSTIMESTAMP),
                EXTRACT(MINUTE FROM SYSTIMESTAMP),
                EXTRACT(SECOND FROM SYSTIMESTAMP)
from dual;

SELECT last_name,hire_date, salary
FROM employees
WHERE TO_CHAR(hire_date, 'MM')='09';

SELECT last_name,hire_date, salary
FROM employees
WHERE EXTRACT(month from hire_date)='09';

-- // ���� --> ����
SELECT last_name, salary, 
 TO_CHAR(salary, '$999,999') �޷�,
 TO_CHAR(salary, 'L999,999') ��ȭ
FROM employees;

SELECT TO_CHAR(65478687, 'L999,999')  -- ####��µ�, �ڸ��� �������� �ʰ� ����
FROM dual;

-- // ���� --> ���� : TO_NUMBER
SELECT TO_NUMBER('123') + 100 
FROM dual;

SELECT TO_NUMBER('123,456', '999,999') + 100 
FROM dual;

SELECT TO_NUMBER('$123,456', '$999,999') + 100 
FROM dual;

-- // ���� --> ��¥ : TO_DATE

-- ���� ����
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD HH24:MI:SS';

SELECT TO_DATE( '20170802181030' , 'YYYYMMDDHH24MISS' )
FROM dual;

SELECT TO_DATE( '2020��11��24��' , 'YYYY"��"MM"��"DD"��"' ) -- ��¥�� �������� ���� -> ��¥�� ����
FROM dual;

-- ���� ��¥���� 2017/01/01�� �� ���
SELECT SYSDATE, SYSDATE-TO_DATE( '20170801' , 'YYYYMMDD' )
FROM dual;

-- ���� DB�� ��¥ �����Ѵٸ�?
-- ��. 20170802 (����)
-- ��. 2017��08��02�� => ����1: ����ũ�Ⱑ �� �ʿ�. ����2: ��½� ���˺����� ��������. ����3: Locale(����ȭ)


-- ///////////////////////////////////////
-- 1-5. ������ �Լ� - �����Լ�

-- DECODE : ������ �ݵ�� ��ġ�ؾ� �Ǵ� ���. ���� ������(=)�� ���ؼ��� ���

-- ����(salary)�� ���� ���ʽ��� ���� ����
SELECT last_name,salary, DECODE(salary,24000,salary*0.3,
                                       17000, salary*0.2,
                                       salary) as ���ʽ�
FROM employees
ORDER BY 2 desc;

-- �Ի�⵵�� ������� �ο���. ��ġ�ϸ� 1, ��ġ���� ������ 0�� ��ȯ �޾Ƽ� SUM �Լ��� ����
SELECT COUNT(*) "���ο���",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2001, 1, 0)) "2001",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2002, 1, 0)) "2002",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2003, 1, 0)) "2003",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2004, 1, 0)) "2004",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2005, 1, 0)) "2005",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2006, 1, 0)) "2006",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2007, 1, 0)) "2007",
 SUM(DECODE(TO_CHAR(hire_date, 'YYYY'), 2008, 1, 0)) "2008"
FROM employees;

-- ////////////////////////////////////////////////////////////
-- // DECODE �ǽ� ����

CREATE TABLE T_HOLHISTORY
(
SEQ_NU 		 NUMBER  NOT NULL,	-- ��� ����
YEAR_VC	 	 VARCHAR2(4) NOT NULL,	-- �⵵
EMPNO_VC 	 VARCHAR2(4) NOT NULL,	-- �����ȣ
STDATE_VC 	 VARCHAR2(4) NOT NULL,	--�ް�������
SMA_VC 	 	 VARCHAR2(1) NOT NULL,	--�ް� ���� ���� ����
EDDATE_VC 	 VARCHAR2(4) NOT NULL,	--�ް� ������
EMA_VC 		 VARCHAR2(1) NOT NULL,	--�ް� ���� ���� ����
REASON_VC	 VARCHAR2(100) ,		--�ް� ����
STATE_VC 	 VARCHAR2(2) NOT NULL,	--���� ���� (0 -> �㰡 , 10 -> ��� , 20 ->�Ұ�)	
AEMPNO_VC 	 VARCHAR2(4) NOT NULL,	--�㰡�� ���
REFUSE_VC 	 VARCHAR2(100) ,		-- ���㰡 ����
INDATE_VC 	 VARCHAR2(8)		-- �Է³�¥
);

-- ����� ����
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (128,2004,'1024','0610',1,'0612',2,'�׳�',10,1001,'',20040528);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (129,2004,'2018','0612',1,'0615',2,'����',0,2001,'',20040607);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (130,2004,'3020','0527',2,'0528',1,'�׳�',20,3001,'�׳�',20040520);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (131,2004,'2022','0713',1,'0713',2,'����',0,2001,'',20040712);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (132,2004,'1011','0830',1,'0830',2,'�������� ����',0,1001,'',20040801);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (133,2004,'1002','0515',1,'0515',2,'�㰡 �����ָ� �� ����',0,1001,'',20040311);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (134,2004,'2027','0811',1,'0811',2,'����',0,2001,'',20040808);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (135,2004,'1024','0915',2,'0915',2,'�������ߵ�',0,1001,'',20040808);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (136,2004,'1024','0913',1,'0913',1,'�׳�',0,1001,'',20040808);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (137,2004,'3017','0924',1,'0924',2,'����;',20,3001,'���� ���� �ʹ١�', 20040808);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (138,2004,'4021','0905',1,'0909',2,'�ް�',0,4001,'',20040808);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (139,2004,'5003','0905',2,'0905',1,'��ĥ������',0,5001,'',20040808);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (140,2004,'6028','0904',2,'0905',1,'�ް�',0,6001,'',20040811);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (141,2004,'6002','0901',1,'0903',2,'����;��',0,6001,'',20040824);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (142,2004,'2018','0823',1,'0827',2,'�ް�',10,2001,'',20040817);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (143,2004,'1002','0824',1,'0827',2,'�ް�',0,1001,'',20040620);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (144,2004,'1019','0824',1,'0828',2,'����;',10,1001,'��ٷ��ٹ�',20040723);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (145,2004,'5003','0815',1,'0820',2,'�ް�',0,5001,'',20040726);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (146,2004,'4007','0728',1,'0801',2,'ȯ���� ��.. ������ �ް� �������',0,4001,'',20040729);
INSERT INTO T_HOLHISTORY (SEQ_NU,YEAR_VC ,EMPNO_VC ,STDATE_VC,SMA_VC ,EDDATE_VC,EMA_VC ,REASON_VC,STATE_VC ,AEMPNO_VC,REFUSE_VC,INDATE_VC) VALUES (147,2004,'6014','0920',1,'0925',2,'�ް�',0,6001,'',20040830);
COMMIT;

-- ����
-- 1.  ������ �����ȣ�� ���� �ް� �����ϰ� �ް� �������� �����ֵ�,
-- ���������� �Ӽ��� SMA_VC�� EMA_VC�� �̿��Ͽ� 1�� ���� ����, 2�� ���� ���ķ� ����Ͻÿ�.
select EMPNO_VC as ���, 
       STDATE_VC as �ް�������,
       DECODE(SMA_VC,1,'����', '����') as ��������, 
       EDDATE_VC as �ް�������, 
       DECODE(EMA_VC,1,'����', 2, '����') as ��������_1
from T_HOLHISTORY;

-- ����
-- 2. �����ȣ�� �ް���û ���¸� ǥ���ϵ� 
-- ����( STATE_VC)�� ������� �ڵ尡 0�� ��� �㰡 , 10�� ��� ��� , 20�� ��� ���㰡�� ǥ���Ͻÿ�.
select EMPNO_VC as ���, 
       STDATE_VC as �ް�������,
       DECODE(STATE_VC, 0, '�㰡', 10, '���', 20, '���㰡') as ����
from T_HOLHISTORY;

-- ////////////////////////////////////////////////

-- CASE : ANSI SQL. ������ ��ġ�ϴ� ���. END Ű����� ����.
-- �����
SELECT last_name,salary,
       CASE salary WHEN 24000 THEN salary*0.3
                   WHEN 17000 THEN salary*0.2
                   ELSE salary 
       END ���ʽ�
FROM employees
ORDER BY 2 desc;

-- �ε��
SELECT last_name,salary,
       CASE WHEN salary >=20000 THEN 1000
            WHEN salary >=15000 THEN 2000
            WHEN salary >=10000 THEN 3000
            ELSE 4000 
       END ���ʽ�
FROM employees
ORDER BY 2 desc;

-- BETWEEN a AND b
SELECT last_name,salary,
       CASE WHEN salary BETWEEN 20000 AND 25000 THEN '��'
            WHEN salary BETWEEN 10000 AND 20001 THEN '��'
            ELSE '��'
       END ��� 
FROM employees
ORDER BY 2 desc;

-- IN
SELECT last_name,salary,
       CASE WHEN salary IN ( 24000, 17000 , 14000) THEN '��'
            WHEN salary IN ( 13500, 13000) THEN '��'
            ELSE '��'
       END ��� 
FROM employees
ORDER BY 2 desc;
