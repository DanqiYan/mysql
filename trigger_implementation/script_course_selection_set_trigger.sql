-- 1. 在学生成绩库中创建触发器trigger1，实现如下功能：当在result中插入一条学生选课信息后，自动实现更新该学生在students中的总学分信息。
-- 1. Build trigger1 in table 'results' so that when inserting a student's course selection information, 
-- the sum of credits in table 'students' will be automatically updated.

CREATE TRIGGER trigger1 AFTER INSERT ON results FOR EACH ROW
BEGIN
		UPDATE students 
		SET sum_credit = sum_credit + new.credit 
	WHERE
		student_id = new.student_id;
	
END;


-- test trigger1
INSERT INTO results
VALUES
	( 2020202, 210, 70, 4 );
	
	
-- 2. 创建触发器trigger2，实现当删除courses中某门课程的记录时，对应results中所有有关此课程的记录均删除。
-- 2. Build trigger2 so that when deleting a course from table 'courses', the records about this course in table 'results' will also be deleted.

DELIMITER |
CREATE TRIGGER trigger2 AFTER DELETE ON courses FOR EACH ROW
BEGIN
		DELETE results 
	FROM
		results 
	WHERE
		results.course_id = old.course_id;
	
END | 
DELIMITER;


-- test trigger2
DELETE 
FROM
	courses 
WHERE
	course_title = 'Computer Basics';
	
	
-- 3. 创建触发器trigger3，实现当修改courses中的某门课的course_id时，对应results中的course_id也作相应修改。
-- 3. Build trigger3 so that when modifying the course_id of table 'courses', the course_id in table 'results' changes accordingly.

DELIMITER |
CREATE TRIGGER trigger3 AFTER UPDATE ON courses FOR EACH ROW
BEGIN
		UPDATE results 
		SET results.course_id = new.course_id 
	WHERE
		results.course_id = old.course_id;
	END | 
DELIMITER ;

-- test trigger3
update courses set course_id = 505 where course_title = 'Qbasic';

-- 4.创建触发器4，实现当向results插入一条选课记录时，查看该学生的信息是否存在在students中，如果不存在，则把该学生的基本信息加入到students中。
-- 4. Build trigger4 so that when inserting a student's course selection record in table 'results', 
-- it will check if the information of this student already exists in table 'students',
-- if not, add the basic inforation of this student in table 'students'.



DELIMITER |
CREATE TRIGGER trigger4 AFTER INSERT ON results FOR EACH ROW
BEGIN
	IF
		NOT EXISTS ( SELECT * FROM students WHERE student_id = new.student_id ) THEN
			INSERT INTO students ( student_id, student_name )
		VALUES
			( new.student_id, 'unknown' );
			
	END IF;
	
END | 
DELIMITER ;


-- test trigger4
insert into results values(4444444, 216, 70, 4);
