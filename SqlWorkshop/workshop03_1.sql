-- workshop03_1
-- ����

-- 16. �������� �л����� �̸�
SELECT student_name �����̸�, count(*) "������ ��"
FROM TB_STUDENT
group by student_name
having count(*) > 1
order by 1;

-- 17. �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ���
SELECT student_name �л��̸�, 
       student_no �й�, 
       student_address "������ �ּ�"
from TB_STUDENT
where (student_address like '������%' or student_address like '��⵵%')
and substr(student_no,1,1) like '9%'
-- AND TO_CHAR(ENTRANCE_DATE, 'RRRR') LIKE '19%' 
order by 1;

-- 18. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ�� (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ)
-- ��, ����(join)����ϱ� (USING���� ó���� ��) 
select department_no
from TB_DEPARTMENT
where department_name = '���а�';

select professor_name, professor_ssn
from TB_PROFESSOR join TB_DEPARTMENT using(department_no)
where department_no = 005
-- where department_name = '���а�'
-- order by professor_ssn;
order by 2;

-- 19. ���� �̸��� ������ �а� �̸� (USING���� ó���� ��)
select CLASS_NAME, DEPARTMENT_NAME
from TB_CLASS join TB_DEPARTMENT using(department_no)
ORDER BY 2;

-- NOTE
-- 20. ���� ���� �̸� (USING���� ó���� ��)
select CLASS_NAME, PROFESSOR_NAME 
from TB_CLASS JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
              JOIN TB_PROFESSOR USING(PROFESSOR_NO);

