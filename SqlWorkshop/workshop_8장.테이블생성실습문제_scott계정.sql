-- workshop_���̺�����ǽ����� (scott����)

-- ����(subject) ���̺� ����
create table subject
( subno NUMBER(5) CONSTRAINT subject_subno_pk PRIMARY KEY,
  subname VARCHAR2(20) CONSTRAINT subject_subname_nn NOT NULL,
  term varchar2(1) CONSTRAINT subject_term_ck CHECK(term IN('1','2'),
  type varchar2(4)CONSTRAINT subject_type_ck CHECK(type IN('�ʼ�','����')
);
  
-- student ���̺� ����
create table student
( studno number(5) constraint student_studno_pk PRIMARY KEY,
  stuname varchar2(10)
);
  
-- ����(sugang) ���̺� ����
create table sugang
( studno NUMBER(5),
  subno NUMBER(5),
  regdate date,
  resut number(3),
  -- PK �۾� ( �����÷� )
  CONSTRAINT sugang_studno_subno_pk PRIMARY KEY(studno, subno)
  -- FK �۾�
  CONSTRAINT sugang_studno_fk FOREIGN KEY(studno) REFERENCES student(studno),
  CONSTRAINT sugang_subno_fk FOREIGN KEY(subno) REFERENCES subject (subno),
  );