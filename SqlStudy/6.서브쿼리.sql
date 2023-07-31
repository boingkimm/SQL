-- // 서브쿼리
-- 모든 절에 올 수 있음. 주로 WHERE절

-- // 단일행 연산자

SELECT salary
FROM employees
WHERE last_name='Whalen'; -- 4400
-- +
SELECT last_name,salary
FROM employees
WHERE salary >= 4400;
-- =
SELECT last_name,salary  -- main query
FROM employees
WHERE salary >= ( SELECT salary  -- sub query
                  FROM employees
                  WHERE last_name='Whalen' );
                  
-- 사원들의 평균 월급보다 더 많은 월급을 받는 사원을 조회
select avg(salary)
from employees;  -- 6461.83

select *
from employees
where salary >= ( select avg(salary)
                  from employees );
                  
-- 부서번호가 100인 사원들 중에서 최대 월급을 받는 사원과 동일한 월급을 받는 사원을 조회
select *
from employees
where salary = (select max(salary)
                from employees
                where department_id = 100);
                
-- 사원 테이블에서 100번 부서의 최대 월급보다 많은 모든 부서 (HAVING절)
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > (SELECT MAX(salary)
                      FROM employees
                      WHERE department_id=100 );


-- // 복수행 연산자

-- // IN 연산자
SELECT salary
FROM employees
WHERE last_name IN ('Whalen','Fay'); -- 반환값이 복수행
 
SELECT last_name, salary
FROM employees
WHERE salary IN ( SELECT salary
                  FROM employees
                  WHERE last_name IN ('Whalen','Fay') );
                  
-- // ALL 연산자
-- > ALL : 최대값보다 큰 데이터를 조회
-- 최대 월급보다 많은 월급을 받는 사원들
SELECT last_name, department_id, salary
FROM employees
WHERE salary > ALL (SELECT salary  -- 복수행
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
SELECT last_name, department_id, salary
FROM employees
WHERE salary > (SELECT MAX(salary)   -- 단일행
                FROM employees
                WHERE job_id = 'IT_PROG');

-- < ALL : 최소값보다 작은 데이터를 조회
-- 최소 월급보다 적은 월급을 받는 사원들
SELECT last_name, department_id, salary  -- 복수행
FROM employees
WHERE salary < ALL (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');

SELECT last_name, department_id, salary
FROM employees
WHERE salary < (SELECT MAX(salary)   -- 단일행
                FROM employees
                WHERE job_id = 'IT_PROG');
                
-- // ANY 연산자
-- >ANY : 최소값보다 큰 데이터를 조회
-- 최소 월급보다 많은 월급
SELECT last_name, department_id, salary
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
SELECT last_name, department_id, salary
FROM employees
WHERE salary > (SELECT MIN(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');

-- <ANY : 최대값보다 작은 데이터를 조회
-- 최대 월급보다 작은 월급
SELECT last_name, department_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
                    
SELECT last_name, department_id, salary
FROM employees
WHERE salary < (SELECT MAX(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');
                
-- // EXISTS 연산자
-- 서브쿼리의 실행결과값 존재 여부에 따라 메인쿼리의 실행여부 결정
SELECT last_name, department_id, salary
FROM employees
WHERE EXISTS ( SELECT employee_id
               FROM employees
               WHERE commission_pct IS NOT NULL );
               
SELECT last_name, department_id, salary
FROM employees
WHERE EXISTS ( SELECT employee_id
               FROM employees
               WHERE salary < -100 ); -- 서브쿼리의 결과가 하나도 없음
               
-- // 다중 컬럼 서브쿼리
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN ( SELECT department_id, MAX(salary)
                              FROM employees
                              GROUP BY department_id )
ORDER BY 2;

-- // 인라인 뷰( in-line view )
SELECT e.department_id , SUM(salary) 총합, AVG(salary) 평균, COUNT(*) 인원수
FROM employees e , departments d
WHERE e.department_id = d.department_id
GROUP BY e.department_id
ORDER BY 1;

-- 서브쿼리(가상테이블e - 필요한 데이터만, 효율적, 성능과 관련됨)
SELECT e.department_id, 합계, 평균, 인원수
FROM ( SELECT department_id, SUM(salary) 합계, AVG(salary) 평균, COUNT(*) 인원수 
       FROM employees
       GROUP BY department_id ) e, departments d
WHERE e.department_id = d.department_id
ORDER By 1;
