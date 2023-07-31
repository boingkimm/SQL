-- // �׷� �Լ�

-- SUM
SELECT SUM(DISTINCT salary),SUM(ALL salary), SUM(salary)
FROM employees;

-- AVG
SELECT SUM(salary), AVG(salary), AVG(DISTINCT salary)
FROM employees;

-- MAX, MIN
SELECT MAX(salary), MIN(salary)
FROM employees;

SELECT MIN( hire_date ), MAX( hire_date)
FROM employees;

-- �÷����� *�� ���� ��
SELECT COUNT(last_name), COUNT(commission_pct), COUNT(*) 
FROM employees;


-- ����� �׷���

-- �μ��� �ִ� salary��, ��հ�, �μ��� �ο���
select department_id, max(salary), avg(salary), count(*)
from employees
group by department_id
order by 1;

-- // �׷��� ������ ��
-- 1. �׷��ε��� ���� �÷��� SELECT���� �� �� ���� ***
SELECT department_id, SUM(salary)  -- ����
FROM employees;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;  -- group by�� ������ �� �� ����

-- 2. WHERE ������ �׷��Լ��� ����� �� ����
SELECT department_id, SUM(salary)
FROM employees
WHERE SUM(salary) > 3000   -- ����
GROUP BY department_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 30000;

-- 3. GROUP BY ������ �÷� ��Ī �� �������� ����� �� ����
SELECT department_id, SUM(salary)
FROM employees
GROUP BY 1  -- ����
HAVING SUM(salary) > 30000;