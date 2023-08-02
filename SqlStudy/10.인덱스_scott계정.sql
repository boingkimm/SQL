-- 10��. �ε���
-- scott����


-- index��ü�� ������ �ִ� �ּҰ�: ROWID (18����)

SELECT ROWID, empno, ename
from emp;

-- AAAE89 AAE AAAAF/ AAC ( 6 3 6 3 : ���̺� ���� �� ��)
-- �� ������ �ٸ��ϱ� ���� ����, ���̺�, �� �� ���� �� �� ����

SELECT *
FROM user_indexes
where TABLE_NAME = 'EMP'; -- pk�� empno������ �ε����� ������(�ڵ�����)

SELECT * 
FROM emp;

-- ename�� �ε��� �߰� (�̸����� �˻��ϴϱ�)
CREATE INDEX emp_ename_idx
ON emp(ename);

-- F10 (��ȹ����, �����ȹ) : TABLE ACCESS(FULL) ==> (BY INDEX ROWID)

SELECT * 
FROM emp
where ename = 'SMITH';
-- full scan
-- �ε��� ���� ��


-- ���� �� BƮ���� �����ϴ� ������尡 �ſ� ŭ. �ε��� �����ϸ� �ȵ�


SELECT *
FROM user_indexes
where TABLE_NAME = 'EMP';

select *
from emp
where upper(ename) = 'SMITH';  -- �ε����� �Լ�X

drop index emp_ename_idx;

