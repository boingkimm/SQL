-- scott������ create view ���� �Ҵ�

GRANT create view 
TO scott;


-- // �ó�� synonym

select *
from scott.emp; -- ���ٰ���. �����̽� �߻����� => ��Ī(���Ǿ�)

create synonym s_emp  -- �����̽� �ذ�
for scott.emp;

drop synonym s_emp;

-- �ó�� ���� ����� �� ���� ����
