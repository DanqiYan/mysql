CREATE TABLE
IF
	NOT EXISTS students (
		faculty VARCHAR ( 30 ),
		class VARCHAR ( 4 ),
		major VARCHAR ( 100 ),
		student_id VARCHAR ( 8 ) NOT NULL,
		student_name VARCHAR ( 30 ) NOT NULL,
		gender VARCHAR ( 10 ),
		date_of_birth DATETIME,
		sum_credit TINYINT,
		remark TEXT,
		PRIMARY KEY ( student_id ) 
	);
CREATE TABLE
IF
	NOT EXISTS courses (
		course_id VARCHAR ( 3 ) NOT NULL,
		course_title VARCHAR ( 100 ) NOT NULL,
		course_semester TINYINT ( 1 ) NOT NULL,
		course_hours TINYINT ( 1 ) NOT NULL,
		credit TINYINT ( 1 ),
		CHECK ( 1 < course_semester < 8 ) 
	);
CREATE TABLE
IF
	NOT EXISTS results (
		student_id VARCHAR ( 8 ) NOT NULL,
		course_id VARCHAR ( 3 ) NOT NULL,
		score TINYINT ( 1 ),
		credit TINYINT ( 1 ),
		PRIMARY KEY ( student_id, course_id ) 
	);
INSERT INTO students
VALUES
	( 'computer science', '0203', 'Computer Application and Maintenance', 02020101, '王玲玲', 'female', '1981-8-26', 9, NULL ),
	( 'computer science', '0203', 'Computer Application and Maintenance', 02020102, '张燕红', 'female', '1981-10-20', 9, NULL ),
	( 'computer science', '0203', 'Computer Application and Maintenance', 02020103, '杨勇', 'male', '1982-3-15', NULL, NULL ),
	( 'computer science', '0203', 'Computer Application and Maintenance', 02020104, '王红庆', 'male', '1983-5-17', NULL, NULL ),
	( 'computer science', '0203', 'Computer Application and Maintenance', 02020105, '陈园', 'female', '1982-4-12', NULL, NULL ),
	( 'computer science', '0201', 'Information Management', 02020201, '黄薇娜', 'female', '1983-8-19', 8, NULL ),
	( 'computer science', '0201', 'Information Management', 02020202, '沈昊', 'male', '1982-3-18', 8, NULL ),
	( 'computer science', '0201', 'Information Management', 02020203, '傅亮达', 'male', '1983-1-22', NULL, NULL ),
	( 'computer science', '0201', 'Information Management', 02020204, '任建刚', 'male', '1981-12-21', NULL, NULL ),
	( 'computer science', '0201', 'Information Management', 02020205, '叶小红', 'female', '1983-7-16', NULL, NULL );
INSERT INTO courses
VALUES
	( 101, 'Computer Basics', 1, 86, 4 ),
	( 102, 'Qbasic', 1, 68, 4 ),
	( 205, 'Discrete Mathematics', 3, 64, 4 ),
	( 206, 'VC', 2, 68, 4 ),
	( 208, 'Data Structures', 2, 68, 4 ),
	( 210, 'Operating Systems', 3, 64, 4 ),
	( 212, 'Computer Components', 4, 86, 5 ),
	( 216, 'Databank', 2, 68, 4 ),
	( 301, 'Computer Networks', 5, 56, 3 );
INSERT INTO results
VALUES
	( 02020101, 101, 85, 4 ),
	( 02020101, 102, 70, 5 ),
	( 02020102, 101, 90, 4 ),
	( 02020102, 102, 80, 5 ),
	( 02020201, 101, 86, 4 ),
	( 02020201, 208, 80, 4 ),
	( 02020202, 208, 50, 4 ),
	( 02020202, 216, 60, 4 );