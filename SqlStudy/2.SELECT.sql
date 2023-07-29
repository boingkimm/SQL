-- SELETE절

-- 1. 모든 컬럼 보기 (107개)
SELECT * FROM employees;

select *
from departments;

-- 2. 특정 컬럼 보기
SELECT employee_id, last_name, hire_date, salary
FROM employees;

-- 3. 연산 가능
SELECT last_name, salary, salary * 12
FROM employees;

-- 4. 별칭 (alias)
SELECT last_name as 이름, salary 월급, salary * 12 as 연봉
FROM employees;

-- 4-1. 공백문자, 특수문자는 ""
SELECT last_name as "사원 이름", salary "사원 월급", salary * 12 as "연 봉" FROM employees;

-- 5. null
SELECT last_name 이름, salary 월급, commission_pct 수수료,
 salary* 12+commission_pct as 연봉
FROM employees;

-- 5-1. NVL함수 (컬럼명, 바꿀 값)
SELECT last_name 이름, salary 월급, commission_pct 수수료,
 salary * 12+NVL(commission_pct,0) as 연봉
FROM employees;

-- 6. 연결: 컬럼 || 컬럼
SELECT last_name || salary as "이름 월급" FROM employees;

-- 6. 연결: 컬럼 || '값'
SELECT last_name || ' 사원' FROM employees;

SELECT last_name || '의 직업은 ' || job_id || ' 입니다' as "사원별 직급" 
FROM employees;

-- 7. 중복제거 DISTINCT (오름차순 정렬)
SELECT job_id
FROM employees;

SELECT DISTINCT job_id
FROM employees;

--//////////////////////////////////

-- WHERE절

-- 8. 비교연산자
SELECT employee_id,last_name,job_id, salary
FROM employees
WHERE salary >= 10000;

SELECT employee_id,last_name,job_id, salary
FROM employees
WHERE last_name = 'King';

-- SQL의 식별자는 대소문자 구별 안하지만, 값(리터럴)은 대소문자를 구별한다.
SELECT employee_id,last_name,job_id, salary
FROM employees
WHERE last_name = 'KING';

-- 날짜데이터도 비교연산 가능
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE hire_date > '07/12/31';

-- 9. BETWEEN a AND b (a,b포함됨)
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE salary BETWEEN 7000 AND 8000;

SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE hire_date BETWEEN '07/01/01' AND '08/12/31';

-- 10. IN 연산자
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE employee_id IN ( 100,200,300 );

SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE last_name IN ( 'King','Abel','Jones');

SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE hire_date IN ( '01/01/13','07/02/07');

-- 11. LIKE 연산자 + 와일드카드문자(%, _)
SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE 'J%';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '%ai%';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '%in';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '_b%';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '_____d';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '%_%';

-- ESCAPE : %나 _를 포함한 문자열을 검색 시
SELECT employee_id,last_name,salary,job_id
FROM employees
WHERE job_id LIKE '%E___' ESCAPE 'E';

-- 12. 논리 연산자 - AND
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 5000;

-- 12. 논리 연산자 - OR
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = 'IT_PROG' OR salary >= 5000;

-- 12. 논리 연산자 - NOT
SELECT last_name,job_id,salary
FROM employees
WHERE NOT salary < 20000;

SELECT last_name,job_id,salary
FROM employees
WHERE salary NOT IN (9000,8000,6000 );

SELECT last_name,job_id,salary
FROM employees
WHERE last_name NOT LIKE 'J%';

SELECT last_name,job_id,salary
FROM employees
WHERE salary NOT BETWEEN 2400 AND 20000;

SELECT last_name,job_id,salary
FROM employees
WHERE commission_pct IS NULL;

SELECT last_name,job_id,salary
FROM employees
WHERE manager_id IS NULL;  -- 사장 1명

SELECT last_name,job_id,salary
FROM employees
WHERE manager_id IS NOT NULL;  -- 106명

-- 논리 연산자 사용시 주의: AND가 OR보다 우선순위가 높음
SELECT last_name,job_id,salary,commission_pct
FROM employees
WHERE job_id ='AC_MGR' OR job_id='MK_REP'
AND commission_pct IS NULL
AND salary >=4000
AND salary <= 9000;

SELECT last_name,job_id,salary,commission_pct
FROM employees
WHERE ( job_id ='AC_MGR' OR job_id='MK_REP' ) 
AND commission_pct IS NULL
AND salary >=4000
AND salary <= 9000;

-- ////////////////////////////////////

-- ORDER BY절 : 정렬

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary DESC;

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary ASC;

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary;  -- 기본은 오름차순

SELECT employee_id,last_name,job_id,salary as "월급" 
FROM employees
ORDER BY 월급 DESC;  -- Alias 가능

SELECT employee_id,last_name,job_id,salary as "월급" 
FROM employees
ORDER BY 4 DESC;  --SELECT절에서 지정된 컬럼의 순서값

-- 문자데이터 정렬
SELECT employee_id,last_name as 이름,job_id,salary 
FROM employees
ORDER BY last_name ASC; -- A:65, B:66

SELECT employee_id,last_name as 이름,job_id,salary 
FROM employees
ORDER BY 이름 ASC;

SELECT employee_id,last_name as 이름,job_id,salary 
FROM employees
ORDER BY 2 ASC;

-- 날짜데이터 정렬
SELECT employee_id,last_name,salary,hire_date as 입사일
FROM employees
ORDER BY hire_date DESC;  -- 최근 날짜가 큰 값

SELECT employee_id,last_name,salary,hire_date as 입사일
FROM employees
ORDER BY 입사일 DESC;

SELECT employee_id,last_name,salary,hire_date as 입사일
FROM employees
ORDER BY 4 DESC;

-- 다중정렬
SELECT employee_id,last_name,salary,hire_date
FROM employees
ORDER BY salary DESC, hire_date;

SELECT employee_id,last_name,salary,hire_date
FROM employees
ORDER BY salary DESC, hire_date DESC;

SELECT employee_id,last_name,salary,hire_date
FROM employees
ORDER BY 3 DESC, 4;

-- NULL값은 가장 큰 값으로 처리
SELECT employee_id,last_name,salary,hire_date, COMMISSION_PCT
FROM employees
order by COMMISSION_PCT;