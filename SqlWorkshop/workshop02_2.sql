-- WORKSHOP02_2
-- 검색조건

-- 1. 2001년에 입학한 사학과 학생 수 (사학과 코드는 TB_DEPARTMENT 에서 검색)
SELECT DEPARTMENT_NO 
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME='사학과';

SELECT COUNT(*)
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '003'
AND STUDENT_NO LIKE 'A1%';

-- 2. 계열이 ‘공학’인 학과 중 입학정원이 20 이상, 30 이하인 학과의 계열, 학과이름, 정원을 조회하시오.
-- 단 학과이름을 기준으로 오름차순정렬하시오.
SELECT CATEGORY AS 계열, DEPARTMENT_NAME AS 학과이름, CAPACITY AS 정원
FROM TB_DEPARTMENT
WHERE CATEGORY = '공학'
      AND CAPACITY BETWEEN 20 AND 30
ORDER BY 2;

-- 3. ‘학’자가 들어간 계열의 소속 학과가 몇 개 있는지 계열, 학과수를 출력하시오. 단 학과수가 많은 순으로 정렬하시오. ( GROUP BY 이용 )
SELECT CATEGORY AS 계열, COUNT(*) AS 학과수
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '%학%'
GROUP BY CATEGORY
ORDER BY 2 DESC;

-- 4. ‘영어영문학과’ 교수이름, 출생년도, 주소를 조회하고 나이가 많은 순으로 정렬하시오.
SELECT DEPARTMENT_NO 
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME= '영어영문학과';

SELECT PROFESSOR_NAME AS 교수이름, SUBSTR(PROFESSOR_SSN,1,2) AS 출생년도, PROFESSOR_ADDRESS AS 주소
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '002'
ORDER BY 2;

-- 5. 국어국문학과 학생 중 서울에 거주하는 학생의 학과번호, 학생이름, 휴학여부를 조회하고 학생이름으로 오름차순 정렬하시오. 
-- 단 휴학여부는 값이 ‘Y’이면 ‘휴학’으로 ‘N’이면 ‘정상’으로 출력한다. 국어국문학과 코드는 TB_DEPARTMENT 에서 찾는다.
-- (JOIN 을 사용하지않는다) ( DECODE 함수 이용 )
SELECT DEPARTMENT_NO 
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME= '국어국문학과';

SELECT DEPARTMENT_NO AS 학과번호,
       STUDENT_NAME AS 학생이름,
       DECODE(ABSENCE_YN, 'Y', '휴학', 'N', '정상') AS 휴학여부
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001'
      AND STUDENT_ADDRESS LIKE '%서울%'
ORDER BY 2;