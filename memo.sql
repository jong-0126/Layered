-- 테이블 생성 (student)
CREATE TABLE student
(
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '학생 식별자',
    name VARCHAR(100) COMMENT '이름',
    age INT COMMENT '나이',
    grade VARCHAR(10) COMMENT '등급'
);

-- 테이블 생성 (major)
CREATE TABLE major
(
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '전공 식별자',
    name VARCHAR(50) NOT NULL COMMENT '이름',
    tutor VARCHAR(50) NOT NULL COMMENT '튜터'
);

-- 테이블 생성 (enrollment)
CREATE TABLE enrollment
(
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '등록 식별자',
    student_id BIGINT COMMENT '수강생 식별자',
    major_id BIGINT COMMENT '전공 식별자',
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (major_id) REFERENCES major(id)
);

-- students 테이블에 email 컬럼 추가
ALTER TABLE student ADD COLUMN email VARCHAR(100) NOT NULL;

-- major 테이블의 name 컬럼의 길이 변경
ALTER TABLE major MODIFY COLUMN name VARCHAR(100);

-- major 테이블의 튜터 UNIQUE 제약조건 설정
ALTER TABLE major ADD CONSTRAINT UNIQUE(tutor);


-- student 테이블에 데이터 삽입
INSERT INTO student (name, age, grade, email) VALUES('학생1', 20, 'AAA', 'a@a.com');
INSERT INTO student (name, age, grade, email) VALUES('학생2', 21, 'AA', 'b@b.com');
INSERT INTO student (name, age, grade, email) VALUES('학생3', 22, 'A', 'c@c.com');
INSERT INTO student (name, age, grade, email) VALUES('학생4', 23, 'BBB', 'd@d.com');
INSERT INTO student (name, age, grade, email) VALUES('학생5', 23, 'BB', 'e@e.com');
INSERT INTO student (name, age, grade, email) VALUES('학생6', 23, 'B', 'f@f.com');

-- major 테이블에 데이터 삽입
INSERT INTO major (name, tutor) VALUES('Spring', '황원욱');
INSERT INTO major (name, tutor) VALUES('NodeJS', '김스파');
INSERT INTO major (name, tutor) VALUES('React', '홍정기');
INSERT INTO major (name, tutor) VALUES('Vue', '김르타');

-- enrollment 테이블에 데이터 삽입
INSERT INTO enrollment (student_id, major_id) VALUES(1, 1);
INSERT INTO enrollment (student_id, major_id) VALUES(2, 2);

-- student 전체 조회
SELECT * FROM student;

-- student 식별자로 단건 조회
SELECT * FROM student WHERE id = 1;

-- student 식별자로 특정 컬럼만 조회
SELECT name, age FROM student WHERE id = 2;


-- 학생1 나이를 21로 업데이트
UPDATE student SET age = 21 WHERE name = '학생1';


-- 학생1 이름으로 student 조회
SELECT * FROM student WHERE name = '학생1';


-- 식별자 4번의 student 삭제
DELETE FROM student WHERE id = 4;

-- student 전체 조회
SELECT * FROM student;

-- student 들이 등록한 major와 관련된 정보 조회 (INNER JOIN) 교집합
SELECT s.name, m.name
FROM student s
         JOIN enrollment e ON s.id = e.student_id
         JOIN major m ON e.major_id = m.id;

-- 모든 student와 그들의 등록된 major 조회 (LEFT JOIN) 부분집합
SELECT s.name, m.name
FROM student s
         LEFT JOIN enrollment e ON s.id = e.student_id
         LEFT JOIN major m ON e.major_id = m.id;