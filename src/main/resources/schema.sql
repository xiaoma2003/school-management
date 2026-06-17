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
    `remark` VARCHAR(500),
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

-- 权限表
CREATE TABLE IF NOT EXISTS `sys_permission` (
    `permission_id` INT AUTO_INCREMENT PRIMARY KEY,
    `permission_name` VARCHAR(100) NOT NULL COMMENT '权限名称',
    `permission_code` VARCHAR(50) UNIQUE NOT NULL COMMENT '权限代码',
    `permission_type` VARCHAR(20) NOT NULL COMMENT '权限类型: system/school/equipment',
    `permission_level` VARCHAR(20) COMMENT '权限级别: view/manage/full',
    `description` VARCHAR(500) COMMENT '权限描述',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 角色权限关联表
CREATE TABLE IF NOT EXISTS `sys_role_permission` (
    `role_id` INT NOT NULL,
    `permission_id` INT NOT NULL,
    PRIMARY KEY (`role_id`, `permission_id`),
    FOREIGN KEY (`role_id`) REFERENCES `sys_role`(`role_id`),
    FOREIGN KEY (`permission_id`) REFERENCES `sys_permission`(`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 初始化权限数据
INSERT INTO `sys_permission` (`permission_name`, `permission_code`, `permission_type`, `permission_level`, `description`) VALUES
('系统管理', 'system:manage', 'system', 'full', '系统管理权限，能进入系统管理模块并进行所有操作'),
('学校查看', 'school:view', 'school', 'view', '学校管理查看权限，只能查看学校管理信息'),
('学校管理', 'school:manage', 'school', 'manage', '学校管理操作权限，能查看、添加、修改学校管理信息'),
('设备查看', 'equipment:view', 'equipment', 'view', '设备管理查看权限，只能查看设备信息'),
('设备管理', 'equipment:manage', 'equipment', 'manage', '设备管理操作权限，能查看、添加、修改设备信息');

-- 给超级管理员角色添加所有权限
INSERT INTO `sys_role_permission` (`role_id`, `permission_id`)
SELECT 1, `permission_id` FROM `sys_permission`;

-- 初始化岗位数据
INSERT INTO `sys_post` (`post_name`, `post_code`, `sort_order`, `status`) VALUES
('校长', 'principal', 1, 1),
('教导主任', 'dean', 2, 1),
('班主任', 'teacher', 3, 1),
('财务', 'finance', 4, 1),
('后勤', 'logistics', 5, 1),
('管理员', 'admin', 6, 1);

-- 初始化部门数据
INSERT INTO `sys_dept` (`dept_name`, `parent_id`, `sort_order`, `status`) VALUES
('校长办公室', 0, 1, 1),
('教务处', 0, 2, 1),
('财务处', 0, 3, 1),
('后勤处', 0, 4, 1),
('信息技术部', 0, 5, 1),
('初中部', 0, 6, 1),
('高中部', 0, 7, 1);

-- 初始化角色数据
INSERT INTO `sys_role` (`role_name`, `role_code`, `description`, `status`) VALUES
('教师', 'teacher', '任课教师，可查看学生信息', 1),
('班主任', 'class_teacher', '班主任，可管理班级和学生', 1),
('财务人员', 'finance', '财务人员，可查看财务相关信息', 1),
('后勤人员', 'logistics', '后勤人员，可管理设备', 1);

-- 初始化年级数据
INSERT INTO `sys_grade` (`grade_name`, `sort_order`, `status`, `remark`) VALUES
('初一', 1, 1, '七年级'),
('初二', 2, 1, '八年级'),
('初三', 3, 1, '九年级'),
('高一', 4, 1, '高一年级'),
('高二', 5, 1, '高二年级'),
('高三', 6, 1, '高三年级');

-- 初始化班级数据
INSERT INTO `sys_class` (`class_name`, `grade_id`, `teacher_name`, `sort_order`, `status`) VALUES
('初一(1)班', 1, '张老师', 1, 1),
('初一(2)班', 1, '李老师', 2, 1),
('初二(1)班', 2, '王老师', 1, 1),
('初二(2)班', 2, '赵老师', 2, 1),
('初三(1)班', 3, '刘老师', 1, 1),
('初三(2)班', 3, '陈老师', 2, 1),
('高一(1)班', 4, '孙老师', 1, 1),
('高一(2)班', 4, '周老师', 2, 1),
('高二(1)班', 5, '吴老师', 1, 1),
('高二(2)班', 5, '郑老师', 2, 1),
('高三(1)班', 6, '黄老师', 1, 1),
('高三(2)班', 6, '杨老师', 2, 1);

-- 初始化学生数据
INSERT INTO `sys_student` (`student_no`, `student_name`, `gender`, `birthday`, `class_id`, `phone`, `address`, `status`) VALUES
('2024001', '张三', 1, '2010-05-15', 1, '13800138001', '北京市朝阳区', 1),
('2024002', '李四', 1, '2010-08-20', 1, '13800138002', '北京市海淀区', 1),
('2024003', '王五', 2, '2010-12-10', 1, '13800138003', '北京市西城区', 1),
('2024004', '赵六', 1, '2010-03-25', 2, '13800138004', '北京市东城区', 1),
('2024005', '孙七', 2, '2010-07-08', 2, '13800138005', '北京市丰台区', 1),
('2024006', '周八', 1, '2010-09-12', 3, '13800138006', '北京市石景山区', 1),
('2024007', '吴九', 2, '2010-01-18', 3, '13800138007', '北京市通州区', 1),
('2024008', '郑十', 1, '2010-06-22', 4, '13800138008', '北京市顺义区', 1),
('2023001', '钱十一', 2, '2009-04-10', 7, '13800138009', '北京市昌平区', 1),
('2023002', '刘十二', 1, '2009-11-05', 7, '13800138010', '北京市大兴区', 1),
('2023003', '陈十三', 2, '2009-02-28', 8, '13800138011', '北京市房山区', 1),
('2023004', '杨十四', 1, '2009-05-15', 8, '13800138012', '北京市门头沟区', 1),
('2022001', '黄十五', 2, '2008-08-30', 11, '13800138013', '北京市怀柔区', 1),
('2022002', '许十六', 1, '2008-10-20', 11, '13800138014', '北京市密云区', 1),
('2022003', '何十七', 2, '2008-12-05', 12, '13800138015', '北京市延庆区', 1);

-- 初始化设备数据
INSERT INTO `sys_equipment` (`equipment_no`, `equipment_name`, `dept_id`, `class_id`, `status`, `remark`) VALUES
('EQ001', '投影仪', 5, 1, 1, '初一(1)班教室投影仪'),
('EQ002', '投影仪', 5, 2, 1, '初一(2)班教室投影仪'),
('EQ003', '电脑', 5, 1, 1, '教师用电脑'),
('EQ004', '电脑', 5, 2, 1, '教师用电脑'),
('EQ005', '空调', 5, 1, 1, '教室空调'),
('EQ006', '空调', 5, 2, 1, '教室空调'),
('EQ007', '打印机', 2, NULL, 1, '教务处打印机'),
('EQ008', '复印机', 2, NULL, 1, '教务处复印机'),
('EQ009', '服务器', 5, NULL, 1, '校园服务器'),
('EQ010', '监控摄像头', 4, NULL, 1, '校门口监控'),
('EQ011', '电子白板', 5, 7, 1, '高一(1)班电子白板'),
('EQ012', '电子白板', 5, 8, 2, '高一(2)班电子白板，需要维修'),
('EQ013', '实验设备', 5, NULL, 1, '物理实验室设备'),
('EQ014', '音响系统', 5, NULL, 1, '操场音响'),
('EQ015', '图书管理系统', 2, NULL, 1, '图书馆管理系统');

-- 初始化用户数据（密码均为 md5(123456) = e10adc3949ba59abbe56e057f20f883e）
INSERT INTO `sys_user` (`username`, `password`, `real_name`, `email`, `phone`, `dept_id`, `post_id`, `role_id`, `status`) VALUES
('zhanglaoshi', 'e10adc3949ba59abbe56e057f20f883e', '张老师', 'zhang@school.com', '13900139001', 6, 3, 2, 1),
('lilaoshi', 'e10adc3949ba59abbe56e057f20f883e', '李老师', 'li@school.com', '13900139002', 6, 3, 3, 1),
('wangcaiwu', 'e10adc3949ba59abbe56e057f20f883e', '王财务', 'wang@school.com', '13900139003', 3, 4, 4, 1),
('zhaohouqin', 'e10adc3949ba59abbe56e057f20f883e', '赵后勤', 'zhao@school.com', '13900139004', 4, 5, 5, 1),
('sunadmin', 'e10adc3949ba59abbe56e057f20f883e', '孙管理员', 'sun@school.com', '13900139005', 5, 6, 1, 1);

-- 给教师角色添加学校查看权限
INSERT INTO `sys_role_permission` (`role_id`, `permission_id`)
SELECT 2, `permission_id` FROM `sys_permission` WHERE `permission_code` = 'school:view';

-- 给班主任角色添加学校管理权限
INSERT INTO `sys_role_permission` (`role_id`, `permission_id`)
SELECT 3, `permission_id` FROM `sys_permission` WHERE `permission_code` IN ('school:manage');

-- 给财务人员角色添加查看权限
INSERT INTO `sys_role_permission` (`role_id`, `permission_id`)
SELECT 4, `permission_id` FROM `sys_permission` WHERE `permission_code` IN ('school:view', 'equipment:view');

-- 给后勤人员角色添加设备管理权限
INSERT INTO `sys_role_permission` (`role_id`, `permission_id`)
SELECT 5, `permission_id` FROM `sys_permission` WHERE `permission_code` IN ('equipment:manage');