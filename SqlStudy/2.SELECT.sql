-- SELETE��

-- 1. ��� �÷� ���� (107��)
SELECT * FROM employees;

select *
from departments;

-- 2. Ư�� �÷� ����
SELECT employee_id, last_name, hire_date, salary
FROM employees;

-- 3. ���� ����
SELECT last_name, salary, salary * 12
FROM employees;

-- 4. ��Ī (alias)
SELECT last_name as �̸�, salary ����, salary * 12 as ����
FROM employees;

-- 4-1. ���鹮��, Ư�����ڴ� ""
SELECT last_name as "��� �̸�", salary "��� ����", salary * 12 as "�� ��" FROM employees;

-- 5. null
SELECT last_name �̸�, salary ����, commission_pct ������,
 salary* 12+commission_pct as ����
FROM employees;

-- 5-1. NVL�Լ� (�÷���, �ٲ� ��)
SELECT last_name �̸�, salary ����, commission_pct ������,
 salary * 12+NVL(commission_pct,0) as ����
FROM employees;

-- 6. ����: �÷� || �÷�
SELECT last_name || salary as "�̸� ����" FROM employees;

-- 6. ����: �÷� || '��'
SELECT last_name || ' ���' FROM employees;

SELECT last_name || '�� ������ ' || job_id || ' �Դϴ�' as "����� ����" 
FROM employees;

-- 7. �ߺ����� DISTINCT (�������� ����)
SELECT job_id
FROM employees;

SELECT DISTINCT job_id
FROM employees;

--//////////////////////////////////

-- WHERE��

-- 8. �񱳿�����
SELECT employee_id,last_name,job_id, salary
FROM employees
WHERE salary >= 10000;

SELECT employee_id,last_name,job_id, salary
FROM employees
WHERE last_name = 'King';

-- SQL�� �ĺ��ڴ� ��ҹ��� ���� ��������, ��(���ͷ�)�� ��ҹ��ڸ� �����Ѵ�.
SELECT employee_id,last_name,job_id, salary
FROM employees
WHERE last_name = 'KING';

-- ��¥�����͵� �񱳿��� ����
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE hire_date > '07/12/31';

-- 9. BETWEEN a AND b (a,b���Ե�)
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE salary BETWEEN 7000 AND 8000;

SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE hire_date BETWEEN '07/01/01' AND '08/12/31';

-- 10. IN ������
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE employee_id IN ( 100,200,300 );

SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE last_name IN ( 'King','Abel','Jones');

SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE hire_date IN ( '01/01/13','07/02/07');

-- 11. LIKE ������ + ���ϵ�ī�幮��(%, _)
SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE 'J%';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '%ai%';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '%in';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '_b%';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '_____d';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '%_%';

-- ESCAPE : %�� _�� ������ ���ڿ��� �˻� ��
SELECT employee_id,last_name,salary,job_id
FROM employees
WHERE job_id LIKE '%E___' ESCAPE 'E';

-- 12. �� ������ - AND
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 5000;

-- 12. �� ������ - OR
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = 'IT_PROG' OR salary >= 5000;

-- 12. �� ������ - NOT
SELECT last_name,job_id,salary
FROM employees
WHERE NOT salary < 20000;

SELECT last_name,job_id,salary
FROM employees
WHERE salary NOT IN (9000,8000,6000 );

SELECT last_name,job_id,salary
FROM employees
WHERE last_name NOT LIKE 'J%';

SELECT last_name,job_id,salary
FROM employees
WHERE salary NOT BETWEEN 2400 AND 20000;

SELECT last_name,job_id,salary
FROM employees
WHERE commission_pct IS NULL;

SELECT last_name,job_id,salary
FROM employees
WHERE manager_id IS NULL;  -- ���� 1��

SELECT last_name,job_id,salary
FROM employees
WHERE manager_id IS NOT NULL;  -- 106��

-- �� ������ ���� ����: AND�� OR���� �켱������ ����
SELECT last_name,job_id,salary,commission_pct
FROM employees
WHERE job_id ='AC_MGR' OR job_id='MK_REP'
AND commission_pct IS NULL
AND salary >=4000
AND salary <= 9000;

SELECT last_name,job_id,salary,commission_pct
FROM employees
WHERE ( job_id ='AC_MGR' OR job_id='MK_REP' ) 
AND commission_pct IS NULL
AND salary >=4000
AND salary <= 9000;

-- ////////////////////////////////////

-- ORDER BY�� : ����

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary DESC;

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary ASC;

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary;  -- �⺻�� ��������

SELECT employee_id,last_name,job_id,salary as "����" 
FROM employees
ORDER BY ���� DESC;  -- Alias ����

SELECT employee_id,last_name,job_id,salary as "����" 
FROM employees
ORDER BY 4 DESC;  --SELECT������ ������ �÷��� ������

-- ���ڵ����� ����
SELECT employee_id,last_name as �̸�,job_id,salary 
FROM employees
ORDER BY last_name ASC; -- A:65, B:66

SELECT employee_id,last_name as �̸�,job_id,salary 
FROM employees
ORDER BY �̸� ASC;

SELECT employee_id,last_name as �̸�,job_id,salary 
FROM employees
ORDER BY 2 ASC;

-- ��¥������ ����
SELECT employee_id,last_name,salary,hire_date as �Ի���
FROM employees
ORDER BY hire_date DESC;  -- �ֱ� ��¥�� ū ��

SELECT employee_id,last_name,salary,hire_date as �Ի���
FROM employees
ORDER BY �Ի��� DESC;

SELECT employee_id,last_name,salary,hire_date as �Ի���
FROM employees
ORDER BY 4 DESC;

-- ��������
SELECT employee_id,last_name,salary,hire_date
FROM employees
ORDER BY salary DESC, hire_date;

SELECT employee_id,last_name,salary,hire_date
FROM employees
ORDER BY salary DESC, hire_date DESC;

SELECT employee_id,last_name,salary,hire_date
FROM employees
ORDER BY 3 DESC, 4;

-- NULL���� ���� ū ������ ó��
SELECT employee_id,last_name,salary,hire_date, COMMISSION_PCT
FROM employees
order by COMMISSION_PCT;