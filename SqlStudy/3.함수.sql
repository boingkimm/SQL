SELECT 25487*895632
FROM dual;

SELECT SYSDATE
FROM DUAL;

-- �Լ�

-- 1-1. ������ �Լ� - �����Լ�

-- INITCAP : ù ���ڸ� �빮��
SELECT INITCAP('ORACLE SQL')
FROM dual;

SELECT email, INITCAP(email)
FROM employees;

-- UPPER : ��� �빮��
SELECT last_name, UPPER(last_name)
FROM employees;

SELECT last_name, salary
FROM employees
WHERE UPPER(last_name)='KING';  -- �˻� ��

-- LOWER : ��� �ҹ���
SELECT last_name, LOWER(last_name)
FROM employees;

-- CONCAT : ���ڿ� ����
SELECT CONCAT( last_name, salary)  -- �Լ�
FROM employees;

SELECT last_name || salary   -- ������
FROM employees;

-- LENGTH : ���ڿ� ����
SELECT last_name, LENGTH(last_name)
FROM employees;

-- INSTR : Ư�� ������ ��ġ
SELECT INSTR('MILLER' , 'L', 1 , 2 ), INSTR('MILLER' , 'X', 1 , 2 )
FROM dual;

SELECT INSTR('MILLER' , 'L', 5 , 2 ), INSTR('MILLER' , 'X', 1 , 2 )
FROM dual;

-- SUBSTR : �κп� ����
SELECT SUBSTR('900303-1234567' , 8 , 1 ) 
FROM dual;

SELECT SUBSTR('900303-1234567' , 8 ) 
FROM dual;

SELECT SUBSTR('900303-1234567' , -8 ) -- �ڿ��� 8��°���� ����
FROM dual;

-- REPLACE : ġȯ
SELECT REPLACE('JACK and JUE' , 'J' , 'BL' ) 
FROM dual;

-- LPAD : ������ ���� �� ���� ä���
SELECT LPAD('MILLER' , 10 , '*' ) 
FROM dual;

-- RPAD : ���� ���� �� ������ ä���
SELECT RPAD('MILLER' , 10 , '*' ) 
FROM dual;

SELECT RPAD(SUBSTR('900303-1234567',1,8),14,'*' ) �ֹι�ȣ
FROM dual;

-- LTRIM : ���ʺ��� Ư������ ����
SELECT LTRIM('MILLER', 'M')
FROM dual;

-- ���ʺ��� �����ϴٰ� ��ġ���� �ʴ� ���� ������ �ߴ�, �߰��� M�� �������� ����
SELECT LTRIM('MMMILLMMER', 'M')
FROM dual;

-- �������� ������ ���鹮�ڸ� ���� - ���� ���鸸 ������
SELECT LTRIM('   MILLER   '), LENGTH(LTRIM('   MILLER   '))
FROM dual;

-- RTRIM : �����ʺ��� Ư������ ����
SELECT RTRIM('MILLER', 'R')
FROM dual;

SELECT RTRIM('MRRRILLERRR', 'R')
FROM dual;

SELECT RTRIM('   MILLER   '), LENGTH(RTRIM('   MILLER   '))
FROM dual;

-- TRIM : Ư�� ���� ���� - ����, ����, ������
SELECT TRIM( BOTH '0' FROM '0001234567000' ) 
FROM dual;

SELECT TRIM( '0' FROM '0001234567000' ) -- BOTH���� ����
FROM dual;

SELECT TRIM( LEADING '0' FROM '0001234567000' ) 
FROM dual;

SELECT TRIM( TRAILING '0' FROM '0001234567000' ) 
FROM dual;

SELECT TRIM( '0' FROM '0001230004567000' ) -- �߰��� ���� ���� �ȵ�
FROM dual;

--/////////////////////////////////////////////

-- 1-2. ������ �Լ� - ��ġ�Լ�

-- ROUND : �ݿø�
SELECT ROUND( 456.789, 2 ) 
FROM dual;

SELECT ROUND( 456.789, -1 ) -- ������ ������
FROM dual;

SELECT ROUND( 456.789 ) 
FROM dual;

-- TRUNC : ������ �ڸ� �� ���Ͽ��� ����
SELECT TRUNC( 456.789, 2 ) 
FROM dual;

SELECT TRUNC( 456.789, -1 ) -- �����ڸ����� ����
FROM dual;

SELECT TRUNC( 456.789 ) 
FROM dual;

-- MOD : ������ ���� �� �������� ��ȯ (%������ ��� ����)
SELECT MOD( 10 , 3 ) , MOD( 10 , 0 ) -- 0���� ������ �� ��ü�� �״�� ��ȯ
FROM dual;

-- CEIL : �־��� �Ǽ����� ũ�ų� ���� �ּ������� ��ȯ
SELECT CEIL(10.6), CEIL(-10.6) 
FROM dual;

-- FLOOR : �־��� �Ǽ����� �۰ų� ���� �ִ������� ��ȯ
SELECT FLOOR(10.6), FLOOR(-10.6) 
FROM dual;

-- SIGN : ������ ���� ����� 1, ������ -1, 0�̸� 0 ��ȯ
SELECT SIGN( 100 ) , SIGN(-20) , SIGN(0) 
FROM dual;

SELECT employee_id,last_name,salary 
FROM employees
WHERE SIGN(salary-15000)=1;  --������ 15000 ���� ū ����� ���

--/////////////////////////////////////////////
