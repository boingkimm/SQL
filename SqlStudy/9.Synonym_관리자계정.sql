-- scott계정에 create view 권한 할당

GRANT create view 
TO scott;


-- // 시노님 synonym

select *
from scott.emp; -- 접근가능. 보안이슈 발생가능 => 별칭(동의어)

create synonym s_emp  -- 보안이슈 해결
for scott.emp;

drop synonym s_emp;

-- 시노님 만들어서 사용할 일 거의 없음
