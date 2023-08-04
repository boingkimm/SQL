-- workshop04_1
-- DML

-- 34.현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용한 SQL 문을 작성하시오.
-- (단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다) ***확인하고 반드시 rollback 시킨다. 
SELECT * 
FROM tb_department;

UPDATE TB_DEPARTMENT
SET capacity = round(capacity*1.1, 0);

rollback;

-- 35. 학번 A413042인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경. ***확인하고 반드시 rollback
UPDATE tb_student
SET student_address = '서울시 종로구 숭인동 181-21'
WHERE student_no = 'A413042';

rollback;

-- 36. 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기. 예. 830530-2124663 ==> 830530 ***확인하고 반드시 rollback
UPDATE tb_student
SET student_ssn = substr(student_ssn, 1, 6);

rollback;

-- 37. 의학과 김명훈 학생의 2005년 1학기에 수강한 '피부생리학' 학점을 3.5로 변경. ***확인하고 반드시 rollback
UPDATE TB_GRADE
SET point = 3.5
where student_no = (select student_no
                    from TB_STUDENT JOIN TB_DEPARTMENT USING(department_no)
                    where student_name = '김명훈'
                    and department_name='의학과')
and term_no = '200501'
and class_no = (select class_no
                 from TB_class
                 where class_name = '피부생리학');
rollback;

-- NOTE
-- 38. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거. ***확인하고 반드시 rollback
--DELETE FROM TB_GRADE.POINT
DELETE FROM TB_GRADE
WHERE student_no IN (SELECT student_no 
                     FROM TB_STUDENT
                    WHERE ABSENCE_YN = 'Y');
rollback;
-- 5036개 중 483개 삭제