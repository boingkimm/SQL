-- �������� �˻� (PK, FK ã��)
SELECT *
FROM USER_CONSTRAINTS;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEES';

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPARTMENTS';

-- // ����Ŭ ���� : WHERE��

-- // inner����, equi ���� (106��, 1�� ����)
SELECT last_name,department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employees.last_name,departments.department_name  -- ������ �÷� - ���̺�� ��������
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- ���� �÷� ���� ��ȣ�� ���� : ���̺��.�÷���
-- SELECT last_name,department_name, department_id
SELECT last_name, department_name, employees.department_id
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- ���̺� ��Ī(alias)
-- ���̺� ��Ī�� �������� ��쿡�� �ݵ�� ��Ī�� ����Ͽ� �÷��� ����. ���̺�� ���Ұ�
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

-- �˻� ���� �߰� : WHERE��
SELECT emp.last_name,salary,department_name 
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id  -- ��������
AND last_name='Whalen'; -- �˻�����

-- ���� ���� ��� ��� ����
-- �μ����� 2005�� ������ �Ի��� �������� �ο���
SELECT d.department_name �μ���, COUNT(e.employee_id) �ο���
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND TO_CHAR( hire_date , 'YYYY') <= 2005
GROUP BY d.department_name
ORDER BY 2;

-- // non-equi ���� ( employees, job_grades )
SELECT last_name, salary, grade_level
FROM employees e, job_grades g
WHERE e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- n�� ���̺� ���� = n-1�� ��������
SELECT last_name, salary, department_name, grade_level
FROM employees e, departments d, job_grades g
WHERE e.department_id = d.department_id
AND e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- // self ���� : ��Ī���� �������̺� ����

-- ���� ������̺�
select employee_id, last_name, manager_id
from EMPLOYEES e;

-- ���� ���������̺�
select employee_id, last_name
from EMPLOYEES m;

select employee_id, last_name
from EMPLOYEES m2;

-- self ����
SELECT e.last_name �����, m.last_name �����ڸ� 
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

-- �����, �����ڸ�, �������� �����ڸ�(m2)
SELECT e.last_name �����, m.last_name �����ڸ�, m2.last_name "�������� �����ڸ�"
FROM employees e, employees m, employees m2
WHERE e.manager_id = m.employee_id
and  m.manager_id = m2.employee_id;

-- /////////////////////////////////
-- // outer ���� : (+)
-- NULL�� ���� ������ �� ����
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id(+);  -- �μ� ���� ����� ���

SELECT e.last_name �����, m.last_name �����ڸ� 
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+);  -- ������ ���� ����� ���

SELECT e.last_name �����,
       m.last_name �����ڸ�, mm.last_name "�������� �����ڸ�" 
FROM employees e, employees m , employees mm
WHERE e.manager_id = m.employee_id(+) 
AND m.manager_id = mm.employee_id(+);

-- // cartesian product
-- ���� �ȳ�. (emp 107 * dept 27 = 2889)
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept;


-- ////////////////////////////////////////

-- ANSI ���� : FROM��

-- // natural ����
SELECT last_name, department_name, department_id
FROM employees NATURAL JOIN departments;   -- pair�� ���� (32��)

-- **�ڵ����� �����÷� ���� - ��������� ���̺���̳� ��Ī ����ϸ� ���� �߻�
-- �����÷��� ���̺��, ��Ī ��� �Ұ�
SELECT last_name, department_name, e.department_id  -- ����
FROM employees e NATURAL JOIN departments d; -- �����÷� �� ��Ī ��� ����

SELECT last_name, department_name, department_id
FROM employees e NATURAL JOIN departments d -- ��������
WHERE department_id=90; -- �˻�����

-- // USING(�÷�) �� (=equi ����)
SELECT last_name,department_name, department_id
FROM employees e JOIN departments d USING(department_id);

-- INNER ����
-- �����÷��� ���̺��, ��Ī ��� �Ұ�
SELECT last_name,department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id);

SELECT last_name,department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id) -- ��������
WHERE department_id=90;  -- �˻�����

-- // ON ��
-- �����÷��� ��Ī ��� �ʼ� (=����Ŭ����)
SELECT last_name,department_name, e.department_id
FROM employees e JOIN departments d ON e.department_id = d.department_id;

SELECT last_name,department_name, e.department_id
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id;
     
SELECT last_name,department_name, e.department_id
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id  -- ��������
WHERE e.department_id=90;  -- �˻�����

-- �ε����
-- ����Ŭ ����
SELECT last_name, salary, grade_level
FROM employees e, job_grades g
WHERE e.salary BETWEEN g.lowest_sal AND g.highest_sal;
-- ANSI
SELECT last_name, salary, grade_level
FROM employees e INNER JOIN job_grades g
ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- // self ����
-- ����Ŭ ����
SELECT e.last_name �����, m.last_name �����ڸ� 
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;
-- ANSI
SELECT e.last_name �����, m.last_name �����ڸ� 
FROM employees e JOIN employees m
ON e.manager_id = m.employee_id;

-- // 3�� ���̺�
SELECT e.last_name �����, d.department_name �μ���, g.grade_level ���
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
                 INNER JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

SELECT e.last_name �����, d.department_name �μ���, g.grade_level ���
FROM employees e INNER JOIN departments d USING(department_id)
                 INNER JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- // cross ���� (=cartesian product)
SELECT last_name, department_name, e.department_id
FROM employees e cross JOIN departments d;


-- // outer ���� - left | right | full

-- ���� 1�� : department_id���� null ���� Grant���
SELECT last_name,department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id);

-- ������ ���� �ִ� ���̺��� ����Ŵ
-- (department_id �ִ� employees e ���̺��� ����Ŵ : LEFT ���� �� ����)
SELECT last_name,department_name, department_id
FROM employees e LEFT OUTER JOIN departments d USING(department_id);

SELECT last_name,department_name, e.department_id
FROM employees e LEFT OUTER JOIN departments d ON d.department_id = e.department_id ;
