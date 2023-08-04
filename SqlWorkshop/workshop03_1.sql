-- workshop03_1
-- 조인

-- 16. 동명이인 학생들의 이름
SELECT student_name 동일이름, count(*) "동명인 수"
FROM TB_STUDENT
group by student_name
having count(*) > 1
order by 1;

-- 17. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력
SELECT student_name 학생이름, 
       student_no 학번, 
       student_address "거주지 주소"
from TB_STUDENT
where (student_address like '강원도%' or student_address like '경기도%')
and substr(student_no,1,1) like '9%'
-- AND TO_CHAR(ENTRANCE_DATE, 'RRRR') LIKE '19%' 
order by 1;

-- 18. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인 (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회)
-- 단, 조인(join)사용하기 (USING절로 처리할 것) 
select department_no
from TB_DEPARTMENT
where department_name = '법학과';

select professor_name, professor_ssn
from TB_PROFESSOR join TB_DEPARTMENT using(department_no)
where department_no = 005
-- where department_name = '법학과'
-- order by professor_ssn;
order by 2;

-- 19. 과목 이름과 과목의 학과 이름 (USING절로 처리할 것)
select CLASS_NAME, DEPARTMENT_NAME
from TB_CLASS join TB_DEPARTMENT using(department_no)
ORDER BY 2;

-- NOTE
-- 20. 과목별 교수 이름 (USING절로 처리할 것)
select CLASS_NAME, PROFESSOR_NAME 
from TB_CLASS JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
              JOIN TB_PROFESSOR USING(PROFESSOR_NO);

