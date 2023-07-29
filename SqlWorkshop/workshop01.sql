-- Workshop01

-- 1. 학과명, 계열
select department_name as "학과 명", category as "계열"
FROM tb_department;

-- 2. 학과의 학과정원
SELECT department_name || '의 정원은 ' || capacity || '명 입니다.' as "학과별 정원"
FROM TB_DEPARTMENT;

-- 3. "국어국문학과"에 다니는 여학생 중 현재 휴학중인 여학생
SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTEMENT_NAME = '국어국문학과';

select student_name
from TB_STUDENT
where department_no = '001'
-- and student_ssn Like '%2______'
and substr(STUDENT_SSN,8,1)=2
and absence_yn = 'Y';

select student_name
from TB_STUDENT
where department_no = '001'
and SUBSTR(student_ssn, 8, 1) = 2
and absence_yn = 'Y';

-- 4. 대상 학번으로 대상자 찾기
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119');

-- 5. 입학정원이 20명 이상 30명 이하 - 학과명, 계열
select department_name, category
from TB_DEPARTMENT
where CAPACITY between 20 and 30;
-- where CAPACITY >= 20 AND CAPACITY <= 30;

-- 6. 총장의 이름 알아내기. 교수 중 총장만 소속학과 없음
SELECT professor_name
from TB_PROFESSOR
where DEPARTMENT_NO is null;

-- 7. 학과가 지정되지 않은 학생 확인
select STUDENT_NAME
from TB_STUDENT
where DEPARTMENT_NO is null;

-- 8. 선수과목 존재하는 과목의 과목번호 조회
select class_no
from TB_CLASS
where PREATTENDING_CLASS_NO is not null;

-- 9. 대학에 어떤 계열 있는지 조회
select DISTINCT category
from TB_DEPARTMENT;

-- 10. 02학번 전주 거주자들, 휴학생 제외 - 학번, 이름, 주민번호 출력
SELECT student_no, student_name, student_ssn
from TB_STUDENT
where student_no like 'A2%'
-- WHERE ENTRANCE_DATE LIKE '02%'
and student_address like '%전주%'
and absence_yn = 'N';
