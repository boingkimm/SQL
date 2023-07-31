-- // ��������
-- ��� ���� �� �� ����. �ַ� WHERE��

-- // ������ ������

SELECT salary
FROM employees
WHERE last_name='Whalen'; -- 4400
-- +
SELECT last_name,salary
FROM employees
WHERE salary >= 4400;
-- =
SELECT last_name,salary  -- main query
FROM employees
WHERE salary >= ( SELECT salary  -- sub query
                  FROM employees
                  WHERE last_name='Whalen' );
                  
-- ������� ��� ���޺��� �� ���� ������ �޴� ����� ��ȸ
select avg(salary)
from employees;  -- 6461.83

select *
from employees
where salary >= ( select avg(salary)
                  from employees );
                  
-- �μ���ȣ�� 100�� ����� �߿��� �ִ� ������ �޴� ����� ������ ������ �޴� ����� ��ȸ
select *
from employees
where salary = (select max(salary)
                from employees
                where department_id = 100);
                
-- ��� ���̺��� 100�� �μ��� �ִ� ���޺��� ���� ��� �μ� (HAVING��)
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > (SELECT MAX(salary)
                      FROM employees
                      WHERE department_id=100 );


-- // ������ ������

-- // IN ������
SELECT salary
FROM employees
WHERE last_name IN ('Whalen','Fay'); -- ��ȯ���� ������
 
SELECT last_name, salary
FROM employees
WHERE salary IN ( SELECT salary
                  FROM employees
                  WHERE last_name IN ('Whalen','Fay') );
                  
-- // ALL ������
-- > ALL : �ִ밪���� ū �����͸� ��ȸ
-- �ִ� ���޺��� ���� ������ �޴� �����
SELECT last_name, department_id, salary
FROM employees
WHERE salary > ALL (SELECT salary  -- ������
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
SELECT last_name, department_id, salary
FROM employees
WHERE salary > (SELECT MAX(salary)   -- ������
                FROM employees
                WHERE job_id = 'IT_PROG');

-- < ALL : �ּҰ����� ���� �����͸� ��ȸ
-- �ּ� ���޺��� ���� ������ �޴� �����
SELECT last_name, department_id, salary  -- ������
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');

SELECT last_name, department_id, salary
FROM employees
WHERE salary < (SELECT MAX(salary)   -- ������
                FROM employees
                WHERE job_id = 'IT_PROG');
                
-- // ANY ������
-- >ANY : �ּҰ����� ū �����͸� ��ȸ
-- �ּ� ���޺��� ���� ����
SELECT last_name, department_id, salary
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
SELECT last_name, department_id, salary
FROM employees
WHERE salary > (SELECT MIN(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');

-- <ANY : �ִ밪���� ���� �����͸� ��ȸ
-- �ִ� ���޺��� ���� ����
SELECT last_name, department_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
SELECT last_name, department_id, salary
FROM employees
WHERE salary < (SELECT MAX(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');
                
-- // EXISTS ������
-- ���������� �������� ���� ���ο� ���� ���������� ���࿩�� ����
SELECT last_name, department_id, salary
FROM employees
WHERE EXISTS ( SELECT employee_id
               FROM employees
               WHERE commission_pct IS NOT NULL );
               
SELECT last_name, department_id, salary
FROM employees
WHERE EXISTS ( SELECT employee_id
               FROM employees
               WHERE salary < -100 ); -- ���������� ����� �ϳ��� ����
               
-- // ���� �÷� ��������
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN ( SELECT department_id, MAX(salary)
                              FROM employees
                              GROUP BY department_id )
ORDER BY 2;

-- // �ζ��� ��( in-line view )
SELECT e.department_id , SUM(salary) ����, AVG(salary) ���, COUNT(*) �ο���
FROM employees e , departments d
WHERE e.department_id = d.department_id
GROUP BY e.department_id
ORDER BY 1;

-- ��������(�������̺�e - �ʿ��� �����͸�, ȿ����, ���ɰ� ���õ�)
SELECT e.department_id, �հ�, ���, �ο���
FROM ( SELECT department_id, SUM(salary) �հ�, AVG(salary) ���, COUNT(*) �ο��� 
       FROM employees
       GROUP BY department_id ) e, departments d
WHERE e.department_id = d.department_id
ORDER By 1;
