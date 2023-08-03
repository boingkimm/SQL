-- Workshop02_1
-- SELECT��

-- 1. ������а� �л��� ���г⵵�� ���� ��
select student_no as �й�, student_name as �̸�, to_date(entrance_date, 'YYYY-MM-DD') as ���г⵵
from TB_STUDENT
where DEPARTMENT_NO = 002
order by 3;

-- 2. ���� �� �̸��� �����ڰ� �ƴ� ���� �� �� (�θ� ���� - �� ���� �̸��� �α��� �ƴ� ����?)
SELECT professor_name, PROFESSOR_SSN
FROM TB_PROFESSOR
where LENGTH(professor_name) != '3';
-- WHERE  PROFESSOR_NAME NOT LIKE '___';

-- NOTE �ֹι�ȣ�� ���� ���� ���ϱ�
-- 3. ���ڱ������� �̸��� ����. ���� ����������� ��� (���� �� 2000�� ���� ����ڴ� ����)
SELECT professor_name as �����̸�, 
to_number(to_char(sysdate,'YYYY'))-to_number('19'||substr(professor_ssn,1,2)) as ����
from tb_professor
where SUBSTR(professor_ssn, 8, 1) = 1
order by 2, 1;

-- 4. �������� �̸� �� �� ������ �̸��� ���
select substr(professor_name,2) as �̸�
from TB_PROFESSOR;

-- NOTE ���г⵵(��¥->����) - �ֹι�ȣ(�������, ����->����)
-- 5. ����� ������ (19���� ���н� ������� ���� ������ ����)
selec
from TB_STUDENT
where TO_NUMBER(TO_CHAR(ENTRANCE_DATE, 'YYYY'))
-  TO_NUMBER(TO_CHAR(TO_DATE(SUBSTR(student_ssn, 1, 2),'RR'), 'YYYY'))
> '19'
order by 1;t student_no, student_name

-- NOTE
-- 6. 2020�� ũ���������� ���� ����?
select to_char(to_date('2020/12/25'),'DAY')
from dual;

-- 8. 2000�⵵ ���� ������ �й� A�� ����. 2000�� ���� �й� ���
select student_no, student_name
from TB_STUDENT
where student_no not like 'A%'
-- WHERE  SUBSTR(STUDENT_NO, 1, 1) <> 'A'
ORDER BY 1;

-- 9. �й��� A517178�� �ѾƸ� �л��� ���� �� ����. �ݿø��Ͽ� �Ҽ��� ���� ���ڸ�����
select round(avg(point),1) as ����
from TB_GRADE
where student_no = 'A517178';

-- 10. �а��� �л���
select department_no as �а���ȣ, count(*) as "�л���(��)"
from TB_student
group by department_no
order by 1;

-- 11. ���������� �������� ���� �л��� ��
select count(*)
from TB_STUDENT
where COACH_PROFESSOR_NO is null;

-- NOTE
-- 12. �й��� A112113�� ���� �л��� ������ ����. �ݿø��Ͽ� �Ҽ��� ���� ���ڸ�����
select SUBSTR(term_no,1,4) as �⵵, round(avg(point),1) as "�⵵ �� ����"
from tb_grade
where student_no = 'A112113'
group by SUBSTR(term_no,1,4)
order by 1;

-- FIXME
-- 13. �а��� ���л� ��
select department_no as �а��ڵ��, 
--     sum(decode(absence_yn, 'Y', 1, 'N', 0)) as "���л� ��" ,
       sum(case when absence_yn = 'Y' then 1 else 0 end) as "���л� ��"
from TB_STUDENT
group by department_no
order by 1;

-- 14. �������� �л����� �̸� ã��
select student_name as �����̸�, count(*) as "������ ��"
from TB_STUDENT
group by student_name
having count(*) > 1
order by 1;

