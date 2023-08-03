-- Workshop02_1
-- SELECT문

-- 1. 영어영문학과 학생들 입학년도가 빠른 순
select student_no as 학번, student_name as 이름, to_date(entrance_date, 'YYYY-MM-DD') as 입학년도
from TB_STUDENT
where DEPARTMENT_NO = 002
order by 3;

-- 2. 교수 중 이름이 세글자가 아닌 교수 한 명 (두명 나옴 - 성 제외 이름이 두글자 아닌 교수?)
SELECT professor_name, PROFESSOR_SSN
FROM TB_PROFESSOR
where LENGTH(professor_name) != '3';
-- WHERE  PROFESSOR_NAME NOT LIKE '___';

-- NOTE 주민번호로 현재 나이 구하기
-- 3. 남자교수들의 이름과 나이. 나이 적은사람부터 출력 (교수 중 2000년 이후 출생자는 없음)
SELECT professor_name as 교수이름, 
to_number(to_char(sysdate,'YYYY'))-to_number('19'||substr(professor_ssn,1,2)) as 나이
from tb_professor
where SUBSTR(professor_ssn, 8, 1) = 1
order by 2, 1;

-- 4. 교수들의 이름 중 성 제외한 이름만 출력
select substr(professor_name,2) as 이름
from TB_PROFESSOR;

-- NOTE 입학년도(날짜->숫자) - 주민번호(출생연도, 문자->숫자)
-- 5. 재수생 입학자 (19세에 입학시 재수하지 않은 것으로 간주)
selec
from TB_STUDENT
where TO_NUMBER(TO_CHAR(ENTRANCE_DATE, 'YYYY'))
-  TO_NUMBER(TO_CHAR(TO_DATE(SUBSTR(student_ssn, 1, 2),'RR'), 'YYYY'))
> '19'
order by 1;t student_no, student_name

-- NOTE
-- 6. 2020년 크리스마스는 무슨 요일?
select to_char(to_date('2020/12/25'),'DAY')
from dual;

-- 8. 2000년도 이후 입학자 학번 A로 시작. 2000년 이전 학번 출력
select student_no, student_name
from TB_STUDENT
where student_no not like 'A%'
-- WHERE  SUBSTR(STUDENT_NO, 1, 1) <> 'A'
ORDER BY 1;

-- 9. 학번이 A517178인 한아름 학생의 학점 총 평점. 반올림하여 소수점 이하 한자리까지
select round(avg(point),1) as 평점
from TB_GRADE
where student_no = 'A517178';

-- 10. 학과별 학생수
select department_no as 학과번호, count(*) as "학생수(명)"
from TB_student
group by department_no
order by 1;

-- 11. 지도교수를 배정받지 못한 학생의 수
select count(*)
from TB_STUDENT
where COACH_PROFESSOR_NO is null;

-- NOTE
-- 12. 학번이 A112113인 김고운 학생의 연도별 평점. 반올림하여 소수점 이하 한자리까지
select SUBSTR(term_no,1,4) as 년도, round(avg(point),1) as "년도 별 평점"
from tb_grade
where student_no = 'A112113'
group by SUBSTR(term_no,1,4)
order by 1;

-- FIXME
-- 13. 학과별 휴학생 수
select department_no as 학과코드명, 
--     sum(decode(absence_yn, 'Y', 1, 'N', 0)) as "휴학생 수" ,
       sum(case when absence_yn = 'Y' then 1 else 0 end) as "휴학생 수"
from TB_STUDENT
group by department_no
order by 1;

-- 14. 동명이인 학생들의 이름 찾기
select student_name as 동일이름, count(*) as "동명인 수"
from TB_STUDENT
group by student_name
having count(*) > 1
order by 1;

