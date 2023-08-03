-- WORKSHOP02_2
-- �˻�����

-- 1. 2001�⿡ ������ ���а� �л� �� (���а� �ڵ�� TB_DEPARTMENT ���� �˻�)
SELECT DEPARTMENT_NO 
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME='���а�';

SELECT COUNT(*)
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '003'
AND STUDENT_NO LIKE 'A1%';

-- 2. �迭�� �����С��� �а� �� ���������� 20 �̻�, 30 ������ �а��� �迭, �а��̸�, ������ ��ȸ�Ͻÿ�.
-- �� �а��̸��� �������� �������������Ͻÿ�.
SELECT CATEGORY AS �迭, DEPARTMENT_NAME AS �а��̸�, CAPACITY AS ����
FROM TB_DEPARTMENT
WHERE CATEGORY = '����'
      AND CAPACITY BETWEEN 20 AND 30
ORDER BY 2;

-- 3. ���С��ڰ� �� �迭�� �Ҽ� �а��� �� �� �ִ��� �迭, �а����� ����Ͻÿ�. �� �а����� ���� ������ �����Ͻÿ�. ( GROUP BY �̿� )
SELECT CATEGORY AS �迭, COUNT(*) AS �а���
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '%��%'
GROUP BY CATEGORY
ORDER BY 2 DESC;

-- 4. ��������а��� �����̸�, ����⵵, �ּҸ� ��ȸ�ϰ� ���̰� ���� ������ �����Ͻÿ�.
SELECT DEPARTMENT_NO 
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME= '������а�';

SELECT PROFESSOR_NAME AS �����̸�, SUBSTR(PROFESSOR_SSN,1,2) AS ����⵵, PROFESSOR_ADDRESS AS �ּ�
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '002'
ORDER BY 2;

-- 5. ������а� �л� �� ���￡ �����ϴ� �л��� �а���ȣ, �л��̸�, ���п��θ� ��ȸ�ϰ� �л��̸����� �������� �����Ͻÿ�. 
-- �� ���п��δ� ���� ��Y���̸� �����С����� ��N���̸� ���������� ����Ѵ�. ������а� �ڵ�� TB_DEPARTMENT ���� ã�´�.
-- (JOIN �� ��������ʴ´�) ( DECODE �Լ� �̿� )
SELECT DEPARTMENT_NO 
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME= '������а�';

SELECT DEPARTMENT_NO AS �а���ȣ,
       STUDENT_NAME AS �л��̸�,
       DECODE(ABSENCE_YN, 'Y', '����', 'N', '����') AS ���п���
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001'
      AND STUDENT_ADDRESS LIKE '%����%'
ORDER BY 2;