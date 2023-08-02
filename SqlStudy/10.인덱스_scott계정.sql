-- 10장. 인덱스
-- scott계정


-- index객체가 가지고 있는 주소값: ROWID (18글자)

SELECT ROWID, empno, ename
from emp;

-- AAAE89 AAE AAAAF/ AAC ( 6 3 6 3 : 테이블 파일 블럭 행)
-- 행 정보만 다르니까 동일 파일, 테이블, 블럭 내 임을 알 수 있음

SELECT *
FROM user_indexes
where TABLE_NAME = 'EMP'; -- pk인 empno때문에 인덱스가 존재함(자동생성)

SELECT * 
FROM emp;

-- ename에 인덱스 추가 (이름으로 검색하니까)
CREATE INDEX emp_ename_idx
ON emp(ename);

-- F10 (계획설명, 실행계획) : TABLE ACCESS(FULL) ==> (BY INDEX ROWID)

SELECT * 
FROM emp
where ename = 'SMITH';
-- full scan
-- 인덱스 생성 후


-- 정렬 및 B트리를 구현하는 오버헤드가 매우 큼. 인덱스 남발하면 안됨


SELECT *
FROM user_indexes
where TABLE_NAME = 'EMP';

select *
from emp
where upper(ename) = 'SMITH';  -- 인덱스에 함수X

drop index emp_ename_idx;

