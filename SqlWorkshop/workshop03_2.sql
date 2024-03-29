-- WORKSHOP03_2 *****
-- 여러 테이블 조인, 서브쿼리(28)

-- 21. ‘인문사회’ 계열에 속한 과목의 교수이름
-- ( TB_CLASS, TB_DEPARTMENT, TB_CLASS_PROFESSOR, TB_PROFESSOR 참조 )
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
                JOIN TB_PROFESSOR USING(PROFESSOR_NO)
                JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회'
ORDER BY 2;

-- NOTE
-- 22. ‘음악학과’ 학생들의 평점구하기. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"
-- 소수점 1자리까지 반올림. (TB_STUDENT, TB_GRADE, TB_DEPARTMENT 참조 ) 
SELECT STUDENT_NO "학번",
       STUDENT_NAME "학생 이름",
       ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;

-- NOTE
-- 23. 학번이 A313047인 학생의 지도교수 찾기. (TB_STUDENT, TB_PROFESSOR, TB_DEPARTMENT 참조)
SELECT DEPARTMENT_NAME AS "학과이름",
       STUDENT_NAME AS "학생이름",
       PROFESSOR_NAME AS "지도교수이름"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
-- JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = DEPARTMENT_NO) -- 에러
WHERE STUDENT_NO = 'A313047';

-- 24. 2007년도에 '인간관계론' 과목을 수강한 학생
SELECT STUDENT_NAME, TERM_NO
FROM TB_CLASS 
JOIN TB_GRADE USING(CLASS_NO)
JOIN TB_STUDENT USING (STUDENT_NO) -- USING (DEPARTMENT_NO) 에러
WHERE CLASS_NAME = '인간관계론'
AND TERM_NO LIKE '2007%';

-- 25. 예체능계열 과목 중 과목 담당교수를 배정받지 못한 과목
SELECT CLASS_NAME,
       DEPARTMENT_NAME
FROM TB_CLASS 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR  USING (CLASS_NO)
WHERE CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL
ORDER BY 2, 1;

-- NOTE
-- 26. 서반아어학과 학생들의 지도교수를 게시하고자 한다. 학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우 "지도교수 미지정?으로 표시하도록 하는 SQL 문을 작성
-- 출력헤더는 '학생이름', '지도교수'로 표시하며 고학번 학생이 먼저 표시
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT 
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT ON (TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '서반아어학과'
ORDER BY TB_STUDENT.STUDENT_NO;

-- 27. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성
SELECT CLASS_NO , CLASS_NAME ,TRUNC(AVG(POINT), 8) "AVG(POINT)"
FROM TB_CLASS
JOIN TB_DEPARTMENT USING ( DEPARTMENT_NO)
JOIN TB_GRADE USING ( CLASS_NO )
WHERE DEPARTMENT_NAME = '환경조경학과'
AND CLASS_TYPE LIKE '%전공%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

-- NOTE
-- 28. “환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 작성
-- 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시
SELECT DEPARTMENT_NAME AS "계열 학과명", ROUND(AVG(POINT),1) AS "전공평점"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY IN (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '환경조경학과' AND CLASS_TYPE LIKE '%전공%')
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

