-- workshop04_1
-- DML

-- 34.�� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�.
-- (��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�) ***Ȯ���ϰ� �ݵ�� rollback ��Ų��. 
SELECT * 
FROM tb_department;

UPDATE TB_DEPARTMENT
SET capacity = round(capacity*1.1, 0);

rollback;

-- 35. �й� A413042�� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����. ***Ȯ���ϰ� �ݵ�� rollback
UPDATE tb_student
SET student_address = '����� ���α� ���ε� 181-21'
WHERE student_no = 'A413042';

rollback;

-- 36. �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�. ��. 830530-2124663 ==> 830530 ***Ȯ���ϰ� �ݵ�� rollback
UPDATE tb_student
SET student_ssn = substr(student_ssn, 1, 6);

rollback;

-- 37. ���а� ����� �л��� 2005�� 1�б⿡ ������ '�Ǻλ�����' ������ 3.5�� ����. ***Ȯ���ϰ� �ݵ�� rollback
UPDATE TB_GRADE
SET point = 3.5
where student_no = (select student_no
                    from TB_STUDENT JOIN TB_DEPARTMENT USING(department_no)
                    where student_name = '�����'
                    and department_name='���а�')
and term_no = '200501'
and class_no = (select class_no
                 from TB_class
                 where class_name = '�Ǻλ�����');
rollback;

-- NOTE
-- 38. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� ����. ***Ȯ���ϰ� �ݵ�� rollback
--DELETE FROM TB_GRADE.POINT
DELETE FROM TB_GRADE
WHERE student_no IN (SELECT student_no 
                     FROM TB_STUDENT
                    WHERE ABSENCE_YN = 'Y');
rollback;
-- 5036�� �� 483�� ����