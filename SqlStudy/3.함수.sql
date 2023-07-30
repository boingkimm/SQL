SELECT 25487*895632
FROM dual;

SELECT SYSDATE
FROM DUAL;

-- 함수

-- 1-1. 단일행 함수 - 문자함수

-- INITCAP : 첫 글자만 대문자
SELECT INITCAP('ORACLE SQL')
FROM dual;

SELECT email, INITCAP(email)
FROM employees;

-- UPPER : 모두 대문자
SELECT last_name, UPPER(last_name)
FROM employees;

SELECT last_name, salary
FROM employees
WHERE UPPER(last_name)='KING';  -- 검색 시

-- LOWER : 모두 소문자
SELECT last_name, LOWER(last_name)
FROM employees;

-- CONCAT : 문자열 연결
SELECT CONCAT( last_name, salary)  -- 함수
FROM employees;

SELECT last_name || salary   -- 연산자
FROM employees;

-- LENGTH : 문자열 길이
SELECT last_name, LENGTH(last_name)
FROM employees;

-- INSTR : 특정 문자의 위치
SELECT INSTR('MILLER' , 'L', 1 , 2 ), INSTR('MILLER' , 'X', 1 , 2 )
FROM dual;

SELECT INSTR('MILLER' , 'L', 5 , 2 ), INSTR('MILLER' , 'X', 1 , 2 )
FROM dual;

-- SUBSTR : 부분열 추출
SELECT SUBSTR('900303-1234567' , 8 , 1 ) 
FROM dual;

SELECT SUBSTR('900303-1234567' , 8 ) 
FROM dual;

SELECT SUBSTR('900303-1234567' , -8 ) -- 뒤에서 8번째부터 시작
FROM dual;

-- REPLACE : 치환
SELECT REPLACE('JACK and JUE' , 'J' , 'BL' ) 
FROM dual;

-- LPAD : 오른쪽 정렬 후 왼쪽 채우기
SELECT LPAD('MILLER' , 10 , '*' ) 
FROM dual;

-- RPAD : 왼쪽 정렬 후 오른쪽 채우기
SELECT RPAD('MILLER' , 10 , '*' ) 
FROM dual;

SELECT RPAD(SUBSTR('900303-1234567',1,8),14,'*' ) 주민번호
FROM dual;

-- LTRIM : 왼쪽부터 특정문자 삭제
SELECT LTRIM('MILLER', 'M')
FROM dual;

-- 왼쪽부터 삭제하다가 일치하지 않는 문자 만나면 중단, 중간의 M은 삭제되지 않음
SELECT LTRIM('MMMILLMMER', 'M')
FROM dual;

-- 지정문자 생략시 공백문자를 삭제 - 왼쪽 공백만 삭제됨
SELECT LTRIM('   MILLER   '), LENGTH(LTRIM('   MILLER   '))
FROM dual;

-- RTRIM : 오른쪽부터 특정문자 삭제
SELECT RTRIM('MILLER', 'R')
FROM dual;

SELECT RTRIM('MRRRILLERRR', 'R')
FROM dual;

SELECT RTRIM('   MILLER   '), LENGTH(RTRIM('   MILLER   '))
FROM dual;

-- TRIM : 특정 문자 삭제 - 양쪽, 왼쪽, 오른쪽
SELECT TRIM( BOTH '0' FROM '0001234567000' ) 
FROM dual;

SELECT TRIM( '0' FROM '0001234567000' ) -- BOTH생략 가능
FROM dual;

SELECT TRIM( LEADING '0' FROM '0001234567000' ) 
FROM dual;

SELECT TRIM( TRAILING '0' FROM '0001234567000' ) 
FROM dual;

SELECT TRIM( '0' FROM '0001230004567000' ) -- 중간의 값은 삭제 안됨
FROM dual;

--/////////////////////////////////////////////

-- 1-2. 단일행 함수 - 수치함수

-- ROUND : 반올림
SELECT ROUND( 456.789, 2 ) 
FROM dual;

SELECT ROUND( 456.789, -1 ) -- 음수는 정수로
FROM dual;

SELECT ROUND( 456.789 ) 
FROM dual;

-- TRUNC : 지정한 자리 수 이하에서 절삭
SELECT TRUNC( 456.789, 2 ) 
FROM dual;

SELECT TRUNC( 456.789, -1 ) -- 정수자리에서 절삭
FROM dual;

SELECT TRUNC( 456.789 ) 
FROM dual;

-- MOD : 나누기 연산 후 나머지를 반환 (%연산자 사용 못함)
SELECT MOD( 10 , 3 ) , MOD( 10 , 0 ) -- 0으로 나누면 값 자체를 그대로 반환
FROM dual;

-- CEIL : 주어진 실수보다 크거나 같은 최소정수값 반환
SELECT CEIL(10.6), CEIL(-10.6) 
FROM dual;

-- FLOOR : 주어진 실수보다 작거나 같은 최대정수값 반환
SELECT FLOOR(10.6), FLOOR(-10.6) 
FROM dual;

-- SIGN : 지정된 값이 양수면 1, 음수면 -1, 0이면 0 반환
SELECT SIGN( 100 ) , SIGN(-20) , SIGN(0) 
FROM dual;

SELECT employee_id,last_name,salary 
FROM employees
WHERE SIGN(salary-15000)=1;  --월급이 15000 보다 큰 사원만 출력

--/////////////////////////////////////////////
