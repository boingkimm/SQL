-- workshop_테이블생성실습문제 (scott계정)

-- 강좌(subject) 테이블 생성
create table subject
( subno NUMBER(5) CONSTRAINT subject_subno_pk PRIMARY KEY,
  subname VARCHAR2(20) CONSTRAINT subject_subname_nn NOT NULL,
  term varchar2(1) CONSTRAINT subject_term_ck CHECK(term IN('1','2'),
  type varchar2(4)CONSTRAINT subject_type_ck CHECK(type IN('필수','선택')
);
  
-- student 테이블 생성
create table student
( studno number(5) constraint student_studno_pk PRIMARY KEY,
  stuname varchar2(10)
);
  
-- 수강(sugang) 테이블 생성
create table sugang
( studno NUMBER(5),
  subno NUMBER(5),
  regdate date,
  resut number(3),
  -- PK 작업 ( 복합컬럼 )
  CONSTRAINT sugang_studno_subno_pk PRIMARY KEY(studno, subno)
  -- FK 작업
  CONSTRAINT sugang_studno_fk FOREIGN KEY(studno) REFERENCES student(studno),
  CONSTRAINT sugang_subno_fk FOREIGN KEY(subno) REFERENCES subject (subno),
  );