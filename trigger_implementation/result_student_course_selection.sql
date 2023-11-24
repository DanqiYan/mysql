/*
 Navicat Premium Data Transfer

 Source Server         : yan_mysql
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : localhost:3306
 Source Schema         : RUNOOB

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 24/11/2023 11:53:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses`  (
  `course_id` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_semester` tinyint(1) NOT NULL,
  `course_hours` tinyint(1) NOT NULL,
  `credit` tinyint(1) NULL DEFAULT NULL,
  CONSTRAINT `courses_chk_1` CHECK ((1 < `course_semester`) < 8)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of courses
-- ----------------------------
BEGIN;
INSERT INTO `courses` (`course_id`, `course_title`, `course_semester`, `course_hours`, `credit`) VALUES ('505', 'Qbasic', 1, 68, 4), ('205', 'Discrete Mathematics', 3, 64, 4), ('206', 'VC', 2, 68, 4), ('208', 'Data Structures', 2, 68, 4), ('210', 'Operating Systems', 3, 64, 4), ('212', 'Computer Components', 4, 86, 5), ('216', 'Databank', 2, 68, 4), ('301', 'Computer Networks', 5, 56, 3);
COMMIT;

-- ----------------------------
-- Table structure for results
-- ----------------------------
DROP TABLE IF EXISTS `results`;
CREATE TABLE `results`  (
  `student_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `score` tinyint(1) NULL DEFAULT NULL,
  `credit` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`, `course_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of results
-- ----------------------------
BEGIN;
INSERT INTO `results` (`student_id`, `course_id`, `score`, `credit`) VALUES ('2020101', '505', 70, 5), ('2020102', '505', 80, 5), ('2020201', '208', 80, 4), ('2020202', '208', 50, 4), ('2020202', '210', 70, 4), ('2020202', '216', 60, 4), ('4444444', '216', 70, 4);
COMMIT;

-- ----------------------------
-- Table structure for students
-- ----------------------------
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students`  (
  `faculty` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `class` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `major` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `student_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `student_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date_of_birth` datetime NULL DEFAULT NULL,
  `sum_credit` tinyint NULL DEFAULT NULL,
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of students
-- ----------------------------
BEGIN;
INSERT INTO `students` (`faculty`, `class`, `major`, `student_id`, `student_name`, `gender`, `date_of_birth`, `sum_credit`, `remark`) VALUES ('computer science', '0203', 'Computer Application and Maintenance', '2020101', '王玲玲', 'female', '1981-08-26 00:00:00', 9, NULL), ('computer science', '0203', 'Computer Application and Maintenance', '2020102', '张燕红', 'female', '1981-10-20 00:00:00', 9, NULL), ('computer science', '0203', 'Computer Application and Maintenance', '2020103', '杨勇', 'male', '1982-03-15 00:00:00', NULL, NULL), ('computer science', '0203', 'Computer Application and Maintenance', '2020104', '王红庆', 'male', '1983-05-17 00:00:00', NULL, NULL), ('computer science', '0203', 'Computer Application and Maintenance', '2020105', '陈园', 'female', '1982-04-12 00:00:00', NULL, NULL), ('computer science', '0201', 'Information Management', '2020201', '黄薇娜', 'female', '1983-08-19 00:00:00', 8, NULL), ('computer science', '0201', 'Information Management', '2020202', '沈昊', 'male', '1982-03-18 00:00:00', 12, NULL), ('computer science', '0201', 'Information Management', '2020203', '傅亮达', 'male', '1983-01-22 00:00:00', NULL, NULL), ('computer science', '0201', 'Information Management', '2020204', '任建刚', 'male', '1981-12-21 00:00:00', NULL, NULL), ('computer science', '0201', 'Information Management', '2020205', '叶小红', 'female', '1983-07-16 00:00:00', NULL, NULL), (NULL, NULL, NULL, '4444444', 'unknown', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Triggers structure for table courses
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger2`;
delimiter ;;
CREATE TRIGGER `trigger2` AFTER DELETE ON `courses` FOR EACH ROW BEGIN
	DELETE results from results 
	WHERE results.course_id = old.course_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table courses
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger3`;
delimiter ;;
CREATE TRIGGER `trigger3` AFTER UPDATE ON `courses` FOR EACH ROW BEGIN
		UPDATE results 
		SET results.course_id = new.course_id 
	WHERE
		results.course_id = old.course_id;
	END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table results
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger1`;
delimiter ;;
CREATE TRIGGER `trigger1` AFTER INSERT ON `results` FOR EACH ROW BEGIN
	UPDATE students
	SET sum_credit = sum_credit + new.credit WHERE student_id = new.student_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table results
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger4`;
delimiter ;;
CREATE TRIGGER `trigger4` AFTER INSERT ON `results` FOR EACH ROW BEGIN
	IF
		NOT EXISTS ( SELECT * FROM students WHERE student_id = new.student_id ) THEN
			INSERT INTO students ( student_id, student_name )
		VALUES
			( new.student_id, 'unknown' );
			
	END IF;
	
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
