-- // 그룹 함수

-- SUM
SELECT SUM(DISTINCT salary),SUM(ALL salary), SUM(salary)
FROM employees;

-- AVG
SELECT SUM(salary), AVG(salary), AVG(DISTINCT salary)
FROM employees;

-- MAX, MIN
SELECT MAX(salary), MIN(salary)
FROM employees;

SELECT MIN( hire_date ), MAX( hire_date)
FROM employees;

-- 컬럼명보다 *을 많이 씀
SELECT COUNT(last_name), COUNT(commission_pct), COUNT(*) 
FROM employees;


-- 명시적 그룹핑

-- 부서별 최대 salary값, 평균값, 부서별 인원수
select department_id, max(salary), avg(salary), count(*)
from employees
group by department_id
order by 1;

-- // 그룹핑 주의할 점
-- 1. 그룹핑되지 않은 컬럼은 SELECT절에 올 수 없음 ***
SELECT department_id, SUM(salary)  -- 에러
FROM employees;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;  -- group by로 묶여야 쓸 수 있음

-- 2. WHERE 절에는 그룹함수를 사용할 수 없음
SELECT department_id, SUM(salary)
FROM employees
WHERE SUM(salary) > 3000   -- 에러
GROUP BY department_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 30000;

-- 3. GROUP BY 절에는 컬럼 별칭 및 순서값을 사용할 수 없음
SELECT department_id, SUM(salary)
FROM employees
GROUP BY 1  -- 에러
HAVING SUM(salary) > 30000;