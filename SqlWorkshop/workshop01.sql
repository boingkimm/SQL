-- Workshop01

-- 1. �а���, �迭
select department_name as "�а� ��", category as "�迭"
FROM tb_department;

-- 2. �а��� �а�����
SELECT department_name || '�� ������ ' || capacity || '�� �Դϴ�.' as "�а��� ����"
FROM TB_DEPARTMENT;

-- 3. "������а�"�� �ٴϴ� ���л� �� ���� �������� ���л�
SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTEMENT_NAME = '������а�';

select student_name
from TB_STUDENT
where department_no = '001'
-- and student_ssn Like '%2______'
and substr(STUDENT_SSN,8,1)=2
and absence_yn = 'Y';

select student_name
from TB_STUDENT
where department_no = '001'
and SUBSTR(student_ssn, 8, 1) = 2
and absence_yn = 'Y';

-- 4. ��� �й����� ����� ã��
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119');

-- 5. ���������� 20�� �̻� 30�� ���� - �а���, �迭
select department_name, category
from TB_DEPARTMENT
where CAPACITY between 20 and 30;
-- where CAPACITY >= 20 AND CAPACITY <= 30;

-- 6. ������ �̸� �˾Ƴ���. ���� �� ���常 �Ҽ��а� ����
SELECT professor_name
from TB_PROFESSOR
where DEPARTMENT_NO is null;

-- 7. �а��� �������� ���� �л� Ȯ��
select STUDENT_NAME
from TB_STUDENT
where DEPARTMENT_NO is null;

-- 8. �������� �����ϴ� ������ �����ȣ ��ȸ
select class_no
from TB_CLASS
where PREATTENDING_CLASS_NO is not null;

-- 9. ���п� � �迭 �ִ��� ��ȸ
select DISTINCT category
from TB_DEPARTMENT;

-- 10. 02�й� ���� �����ڵ�, ���л� ���� - �й�, �̸�, �ֹι�ȣ ���
SELECT student_no, student_name, student_ssn
from TB_STUDENT
where student_no like 'A2%'
-- WHERE ENTRANCE_DATE LIKE '02%'
and student_address like '%����%'
and absence_yn = 'N';
