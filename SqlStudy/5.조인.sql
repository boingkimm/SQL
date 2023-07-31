-- 제약조건 검색 (PK, FK 찾기)
SELECT *
FROM USER_CONSTRAINTS;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEES';

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPARTMENTS';

-- // 오라클 조인 : WHERE절

-- // inner조인, equi 조인 (106개, 1명 누락)
SELECT last_name,department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employees.last_name,departments.department_name  -- 유일한 컬럼 - 테이블명 생략가능
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- 공통 컬럼 사용시 모호성 제거 : 테이블명.컬럼명
-- SELECT last_name,department_name, department_id
SELECT last_name, department_name, employees.department_id
FROM employees, departments
WHERE employees.department_id = departments.department_id;

-- 테이블 별칭(alias)
-- 테이블 별칭을 지정했을 경우에는 반드시 별칭을 사용하여 컬럼을 참조. 테이블명 사용불가
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

-- 검색 조건 추가 : WHERE절
SELECT emp.last_name,salary,department_name 
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id  -- 조인조건
AND last_name='Whalen'; -- 검색조건

-- 기존 문법 모두 사용 가능
-- 부서별로 2005년 이전에 입사한 직원들의 인원수
SELECT d.department_name 부서명, COUNT(e.employee_id) 인원수
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND TO_CHAR( hire_date , 'YYYY') <= 2005
GROUP BY d.department_name
ORDER BY 2;

-- // non-equi 조인 ( employees, job_grades )
SELECT last_name, salary, grade_level
FROM employees e, job_grades g
WHERE e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- n개 테이블 조인 = n-1개 조인조건
SELECT last_name, salary, department_name, grade_level
FROM employees e, departments d, job_grades g
WHERE e.department_id = d.department_id
AND e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- // self 조인 : 별칭으로 가상테이블 생성

-- 가상 사원테이블
select employee_id, last_name, manager_id
from EMPLOYEES e;

-- 가상 관리자테이블
select employee_id, last_name
from EMPLOYEES m;

select employee_id, last_name
from EMPLOYEES m2;

-- self 조인
SELECT e.last_name 사원명, m.last_name 관리자명 
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

-- 사원명, 관리자명, 관리자의 관리자명(m2)
SELECT e.last_name 사원명, m.last_name 관리자명, m2.last_name "관리자의 관리자명"
FROM employees e, employees m, employees m2
WHERE e.manager_id = m.employee_id
and  m.manager_id = m2.employee_id;

-- /////////////////////////////////
-- // outer 조인 : (+)
-- NULL값 가진 가상의 행 생성
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id(+);  -- 부서 없는 사람도 출력

SELECT e.last_name 사원명, m.last_name 관리자명 
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+);  -- 관리자 없는 사람도 출력

SELECT e.last_name 사원명,
       m.last_name 관리자명, mm.last_name "관리자의 관리자명" 
FROM employees e, employees m , employees mm
WHERE e.manager_id = m.employee_id(+) 
AND m.manager_id = mm.employee_id(+);

-- // cartesian product
-- 에러 안남. (emp 107 * dept 27 = 2889)
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept;


-- ////////////////////////////////////////

-- ANSI 조인 : FROM절

-- // natural 조인
SELECT last_name, department_name, department_id
FROM employees NATURAL JOIN departments;   -- pair로 비교함 (32개)

-- **자동으로 공통컬럼 인지 - 명시적으로 테이블명이나 별칭 사용하면 에러 발생
-- 공통컬럼은 테이블명, 별칭 사용 불가
SELECT last_name, department_name, e.department_id  -- 에러
FROM employees e NATURAL JOIN departments d; -- 공통컬럼 외 별칭 사용 가능

SELECT last_name, department_name, department_id
FROM employees e NATURAL JOIN departments d -- 조인조건
WHERE department_id=90; -- 검색조건

-- // USING(컬럼) 절 (=equi 조인)
SELECT last_name,department_name, department_id
FROM employees e JOIN departments d USING(department_id);

-- INNER 가능
-- 공통컬럼은 테이블명, 별칭 사용 불가
SELECT last_name,department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id);

SELECT last_name,department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id) -- 조인조건
WHERE department_id=90;  -- 검색조건

-- // ON 절
-- 공통컬럼은 별칭 사용 필수 (=오라클조인)
SELECT last_name,department_name, e.department_id
FROM employees e JOIN departments d ON e.department_id = d.department_id;

SELECT last_name,department_name, e.department_id
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id;
     
SELECT last_name,department_name, e.department_id
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id  -- 조인조건
WHERE e.department_id=90;  -- 검색조건

-- 부등연산자
-- 오라클 조인
SELECT last_name, salary, grade_level
FROM employees e, job_grades g
WHERE e.salary BETWEEN g.lowest_sal AND g.highest_sal;
-- ANSI
SELECT last_name, salary, grade_level
FROM employees e INNER JOIN job_grades g
ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- // self 조인
-- 오라클 조인
SELECT e.last_name 사원명, m.last_name 관리자명 
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;
-- ANSI
SELECT e.last_name 사원명, m.last_name 관리자명 
FROM employees e JOIN employees m
ON e.manager_id = m.employee_id;

-- // 3개 테이블
SELECT e.last_name 사원명, d.department_name 부서명, g.grade_level 등급
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
                 INNER JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

SELECT e.last_name 사원명, d.department_name 부서명, g.grade_level 등급
FROM employees e INNER JOIN departments d USING(department_id)
                 INNER JOIN job_grades g ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- // cross 조인 (=cartesian product)
SELECT last_name, department_name, e.department_id
FROM employees e cross JOIN departments d;


-- // outer 조인 - left | right | full

-- 누락 1명 : department_id값이 null 가진 Grant사원
SELECT last_name,department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id);

-- 누락된 값이 있는 테이블을 가리킴
-- (department_id 있는 employees e 테이블을 가리킴 : LEFT 왼쪽 다 나와)
SELECT last_name,department_name, department_id
FROM employees e LEFT OUTER JOIN departments d USING(department_id);

SELECT last_name,department_name, e.department_id
FROM employees e LEFT OUTER JOIN departments d ON d.department_id = e.department_id ;
