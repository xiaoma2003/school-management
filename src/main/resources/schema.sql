CREATE TABLE IF NOT EXISTS `sys_post` (
    `post_id` INT AUTO_INCREMENT PRIMARY KEY,
    `post_name` VARCHAR(100) NOT NULL,
    `post_code` VARCHAR(50) UNIQUE NOT NULL,
    `sort_order` INT DEFAULT 0,
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_dept` (
    `dept_id` INT AUTO_INCREMENT PRIMARY KEY,
    `dept_name` VARCHAR(100) NOT NULL,
    `parent_id` INT DEFAULT 0,
    `sort_order` INT DEFAULT 0,
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_role` (
    `role_id` INT AUTO_INCREMENT PRIMARY KEY,
    `role_name` VARCHAR(100) NOT NULL,
    `role_code` VARCHAR(50) UNIQUE NOT NULL,
    `description` VARCHAR(500),
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_user` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) UNIQUE NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `real_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100),
    `phone` VARCHAR(20),
    `dept_id` INT,
    `post_id` INT,
    `role_id` INT,
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`dept_id`) REFERENCES `sys_dept`(`dept_id`),
    FOREIGN KEY (`post_id`) REFERENCES `sys_post`(`post_id`),
    FOREIGN KEY (`role_id`) REFERENCES `sys_role`(`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_grade` (
    `grade_id` INT AUTO_INCREMENT PRIMARY KEY,
    `grade_name` VARCHAR(50) NOT NULL,
    `sort_order` INT DEFAULT 0,
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_class` (
    `class_id` INT AUTO_INCREMENT PRIMARY KEY,
    `class_name` VARCHAR(50) NOT NULL,
    `grade_id` INT NOT NULL,
    `teacher_name` VARCHAR(50),
    `sort_order` INT DEFAULT 0,
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`grade_id`) REFERENCES `sys_grade`(`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `sys_student` (
    `student_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_no` VARCHAR(50) UNIQUE NOT NULL,
    `student_name` VARCHAR(100) NOT NULL,
    `gender` TINYINT,
    `birthday` DATE,
    `class_id` INT,
    `phone` VARCHAR(20),
    `address` VARCHAR(500),
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`class_id`) REFERENCES `sys_class`(`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `sys_role` (`role_name`, `role_code`, `description`) VALUES ('超级管理员', 'admin', '系统超级管理员');
INSERT INTO `sys_user` (`username`, `password`, `real_name`, `role_id`) VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', 1);

-- 设备管理表
CREATE TABLE IF NOT EXISTS `sys_equipment` (
    `equipment_id` INT AUTO_INCREMENT PRIMARY KEY,
    `equipment_no` VARCHAR(50) UNIQUE NOT NULL COMMENT '设备编号',
    `equipment_name` VARCHAR(100) NOT NULL COMMENT '设备名称',
    `dept_id` INT COMMENT '所属部门',
    `class_id` INT COMMENT '所属班级',
    `status` TINYINT DEFAULT 1 COMMENT '状态: 1=正常, 2=故障',
    `remark` VARCHAR(500) COMMENT '备注',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`dept_id`) REFERENCES `sys_dept`(`dept_id`),
    FOREIGN KEY (`class_id`) REFERENCES `sys_class`(`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;