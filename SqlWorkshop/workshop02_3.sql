-- Workshop02_3
-- 함수

-- 6. 80 년생인 여학생 중 성이 ‘김’씨인 학생의 주민번호, 학생이름을 조회하시오. 단 학생이름으로 오름차순 정렬하시오.
select '['|| substr(student_ssn,1,8)||'******]'  as "[주민번호]", student_name as 이름
from TB_STUDENT
where STUDENT_SSN like '80_____2%'
      and STUDENT_NAME like '김%'
ORDER BY  2;

-- 7. 계열이 ‘예체능’인 학과의 정원을 기준으로 40 이상이면 ‘대강의실’ 30 이상이면 ‘중강의실’ 30 나머지는 ‘소강의실’로 출력한다. 단, 정원이 많은 순으로 정렬 한다.
select department_name as 학과이름, capacity as 정원,
       case when capacity >= 40 then '대강의실'
            when capacity >= 30 then '중강의실'
            else '소강의실'
        end as 강의실크기
from tb_department
where category = '예체능'
order by 2 desc , 1;

-- 8. 2005년1월1일부터 2006년12월31일까지의 기간에 입학한 학생 중 
-- 주소가 등록되지 않은 남학생의 학과번호, 학생이름, 지도교수번호, 입학년도를 조회하시오. 
-- 입학년도를 기준으로 오름차순 정렬한다.
select department_no as 학과번호, student_name as 학생이름, 
       coach_professor_no as 지도교수번호, 
       to_char(entrance_date, 'YYYY"년"') as 입학년도
from TB_STUDENT
where entrance_date between '05/01/01' and '06/12/31'
-- to_char(ENTRANCE_DATE, 'YYYY') between 2005 and 2007
and STUDENT_ADDRESS is null
and substr(STUDENT_SSN,8,1)= '1'
order by 4, 2;
