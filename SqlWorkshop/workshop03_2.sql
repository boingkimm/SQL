-- WORKSHOP03_2 *****
-- ���� ���̺� ����, ��������(28)

-- 21. ���ι���ȸ�� �迭�� ���� ������ �����̸�
-- ( TB_CLASS, TB_DEPARTMENT, TB_CLASS_PROFESSOR, TB_PROFESSOR ���� )
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
                JOIN TB_PROFESSOR USING(PROFESSOR_NO)
                JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '�ι���ȸ'
ORDER BY 2;

-- NOTE
-- 22. �������а��� �л����� �������ϱ�. �����а� �л����� "�й�", "�л� �̸�", "��ü ����"
-- �Ҽ��� 1�ڸ����� �ݿø�. (TB_STUDENT, TB_GRADE, TB_DEPARTMENT ���� ) 
SELECT STUDENT_NO "�й�",
       STUDENT_NAME "�л� �̸�",
       ROUND(AVG(POINT),1) "��ü ����"
FROM TB_STUDENT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME = '�����а�'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;

-- NOTE
-- 23. �й��� A313047�� �л��� �������� ã��. (TB_STUDENT, TB_PROFESSOR, TB_DEPARTMENT ����)
SELECT DEPARTMENT_NAME AS "�а��̸�",
       STUDENT_NAME AS "�л��̸�",
       PROFESSOR_NAME AS "���������̸�"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
-- JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = DEPARTMENT_NO) -- ����
WHERE STUDENT_NO = 'A313047';

-- 24. 2007�⵵�� '�ΰ������' ������ ������ �л�
SELECT STUDENT_NAME, TERM_NO
FROM TB_CLASS 
JOIN TB_GRADE USING(CLASS_NO)
JOIN TB_STUDENT USING (STUDENT_NO) -- USING (DEPARTMENT_NO) ����
WHERE CLASS_NAME = '�ΰ������'
AND TERM_NO LIKE '2007%';

-- 25. ��ü�ɰ迭 ���� �� ���� ��米���� �������� ���� ����
SELECT CLASS_NAME,
       DEPARTMENT_NAME
FROM TB_CLASS 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR  USING (CLASS_NO)
WHERE CATEGORY = '��ü��'
AND PROFESSOR_NO IS NULL
ORDER BY 2, 1;

-- NOTE
-- 26. ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. �л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ�
-- �������� '�л��̸�', '��������'�� ǥ���ϸ� ���й� �л��� ���� ǥ��
SELECT STUDENT_NAME �л��̸�, NVL(PROFESSOR_NAME, '�������� ������') ��������
FROM TB_STUDENT 
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT ON (TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY TB_STUDENT.STUDENT_NO;

-- 27. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ�
SELECT CLASS_NO , CLASS_NAME ,TRUNC(AVG(POINT), 8) "AVG(POINT)"
FROM TB_CLASS
JOIN TB_DEPARTMENT USING ( DEPARTMENT_NO)
JOIN TB_GRADE USING ( CLASS_NO )
WHERE DEPARTMENT_NAME = 'ȯ�������а�'
AND CLASS_TYPE LIKE '%����%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

-- NOTE
-- 28. ��ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL ���� �ۼ�
-- �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ��
SELECT DEPARTMENT_NAME AS "�迭 �а���", ROUND(AVG(POINT),1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY IN (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = 'ȯ�������а�' AND CLASS_TYPE LIKE '%����%')
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

