-- Workshop02_3
-- �Լ�

-- 6. 80 ����� ���л� �� ���� ���衯���� �л��� �ֹι�ȣ, �л��̸��� ��ȸ�Ͻÿ�. �� �л��̸����� �������� �����Ͻÿ�.
select '['|| substr(student_ssn,1,8)||'******]'  as "[�ֹι�ȣ]", student_name as �̸�
from TB_STUDENT
where STUDENT_SSN like '80_____2%'
      and STUDENT_NAME like '��%'
ORDER BY  2;

-- 7. �迭�� ����ü�ɡ��� �а��� ������ �������� 40 �̻��̸� ���밭�ǽǡ� 30 �̻��̸� ���߰��ǽǡ� 30 �������� ���Ұ��ǽǡ��� ����Ѵ�. ��, ������ ���� ������ ���� �Ѵ�.
select department_name as �а��̸�, capacity as ����,
       case when capacity >= 40 then '�밭�ǽ�'
            when capacity >= 30 then '�߰��ǽ�'
            else '�Ұ��ǽ�'
        end as ���ǽ�ũ��
from tb_department
where category = '��ü��'
order by 2 desc , 1;

-- 8. 2005��1��1�Ϻ��� 2006��12��31�ϱ����� �Ⱓ�� ������ �л� �� 
-- �ּҰ� ��ϵ��� ���� ���л��� �а���ȣ, �л��̸�, ����������ȣ, ���г⵵�� ��ȸ�Ͻÿ�. 
-- ���г⵵�� �������� �������� �����Ѵ�.
select department_no as �а���ȣ, student_name as �л��̸�, 
       coach_professor_no as ����������ȣ, 
       to_char(entrance_date, 'YYYY"��"') as ���г⵵
from TB_STUDENT
where entrance_date between '05/01/01' and '06/12/31'
-- to_char(ENTRANCE_DATE, 'YYYY') between 2005 and 2007
and STUDENT_ADDRESS is null
and substr(STUDENT_SSN,8,1)= '1'
order by 4, 2;
