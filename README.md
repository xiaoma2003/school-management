# 校生通管理系统

基于 SSM（Spring + Spring MVC + MyBatis）框架的学校管理系统，提供学生、班级、年级、岗位、部门、角色、用户、设备等模块的完整管理功能，并支持基于角色的细粒度权限控制。

## 技术栈

- **后端框架**: Spring 5.3.20 + Spring MVC + MyBatis 3.5.10
- **数据库**: MySQL 8.0+
- **构建工具**: Maven 3.x
- **JSP 模板**: JSTL + JSP
- **Excel 处理**: Apache POI 5.2.3
- **服务器**: Apache Tomcat 9.x
- **JDK**: 1.8+

## 核心功能

### 1. 系统管理
- **岗位管理**：岗位的增删改查、按名称/编码搜索
- **部门管理**：部门的增删改查、支持多级部门结构
- **角色管理**：角色的增删改查、为角色分配权限
- **用户管理**：用户的增删改查、为用户分配部门和角色

### 2. 学校管理
- **年级管理**：年级的增删改查
- **班级管理**：班级的增删改查、按年级/名称搜索
- **学生管理**：学生的增删改查、Excel 批量导入、按学号/姓名搜索

### 3. 设备管理
- **设备管理**：设备的增删改查、按设备编号/名称搜索、状态管理

### 4. 权限管理
- 支持细粒度权限控制（系统管理、学校查看/管理、设备查看/管理）
- 导航栏根据权限动态显示
- 操作按钮（新增、编辑、删除）根据权限显隐
- 无权限访问时弹窗提示并跳转

## 权限编码

| 权限编码 | 权限名称 | 权限说明 |
|---------|---------|---------|
| `system:manage` | 系统管理 | 完整操作（岗位、部门、角色、用户）|
| `school:view` | 学校查看 | 只能查看学校管理信息 |
| `school:manage` | 学校管理 | 完整操作（年级、班级、学生）|
| `equipment:view` | 设备查看 | 只能查看设备信息 |
| `equipment:manage` | 设备管理 | 完整操作设备信息 |

## 内置测试账号

默认密码均为 `123456`（MD5 加密：`e10adc3949ba59abbe56e057f20f883e`）

| 用户名 | 角色 | 权限 |
|--------|------|------|
| `admin` | 超级管理员 | 所有权限 |
| `sunadmin` | 超级管理员 | 所有权限 |
| `zhanglaoshi` | 教师 | school:view |
| `lilaoshi` | 班主任 | school:manage |
| `wangcaiwu` | 财务人员 | school:view + equipment:view |
| `zhaohouqin` | 后勤人员 | equipment:manage |

## 项目结构

```
school-management/
├── src/main/java/com/example/
│   ├── controller/          # 控制器层
│   │   ├── LoginController.java
│   │   ├── SysRoleController.java
│   │   ├── SysUserController.java
│   │   ├── SysPostController.java
│   │   ├── SysDeptController.java
│   │   ├── SysGradeController.java
│   │   ├── SysClassController.java
│   │   ├── SysStudentController.java
│   │   └── SysEquipmentController.java
│   ├── service/             # 业务逻辑层
│   │   └── impl/
│   ├── mapper/              # MyBatis Mapper 接口
│   ├── entity/              # 实体类
│   ├── interceptor/         # 拦截器
│   │   └── PermissionInterceptor.java
│   └── util/                # 工具类
├── src/main/resources/
│   ├── spring/              # Spring 配置文件
│   │   ├── applicationContext.xml
│   │   └── springmvc.xml
│   ├── mybatis/mapper/      # MyBatis XML 映射文件
│   ├── schema.sql           # 数据库初始化脚本
│   └── student_import_template.xlsx  # 学生导入模板
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── views/           # JSP 页面
│   │   │   ├── login.jsp
│   │   │   ├── main.jsp
│   │   │   ├── system/      # 系统管理页面
│   │   │   ├── school/      # 学校管理页面
│   │   │   └── equipment/   # 设备管理页面
│   │   └── web.xml
│   ├── index.jsp            # 入口页面（重定向到登录）
│   └── favicon.ico
└── pom.xml                  # Maven 配置
```

## 快速开始

### 1. 环境准备
- 安装 JDK 1.8+
- 安装 Maven 3.x
- 安装 MySQL 8.0+
- 安装 Tomcat 9.x

### 2. 数据库初始化
```bash
mysql -u root -p
CREATE DATABASE school_management DEFAULT CHARSET utf8mb4;
USE school_management;
SOURCE src/main/resources/schema.sql;
```

### 3. 配置数据库
修改 `src/main/resources/spring/applicationContext.xml` 中的数据库连接信息：
```xml
<bean id="dataSource" class="org.apache.commons.dbcp2.BasicDataSource">
    <property name="url" value="jdbc:mysql://localhost:3306/school_management?useSSL=false&amp;serverTimezone=Asia/Shanghai"/>
    <property name="username" value="root"/>
    <property name="password" value="你的密码"/>
</bean>
```

### 4. 构建项目
```bash
mvn clean package
```

### 5. 部署
- 将 `target/school-management.war` 复制到 Tomcat 的 `webapps` 目录
- 启动 Tomcat：`bin/startup.sh`（Linux/Mac）或 `bin/startup.bat`（Windows）
- 访问：http://localhost:8080/school-management

## 主要功能说明

### 角色权限分配
1. 进入「系统管理 > 角色管理」
2. 编辑角色，勾选对应权限
3. 保存后，拥有该角色的用户重新登录即可生效

### 学生 Excel 导入
1. 进入「学校管理 > 学生管理 > 导入」
2. 下载导入模板（含班级ID参考）
3. 填写学生信息后上传
4. 系统自动批量导入

### 模糊查询
所有列表页均支持模糊搜索：
- 系统管理：按名称、编码搜索
- 学校管理：按学生学号/姓名、班级名称/年级搜索
- 设备管理：按设备编号/名称搜索

## 接口列表

| 模块 | 接口前缀 |
|------|---------|
| 登录登出 | `/`、`/login`、`/logout` |
| 系统管理 | `/system/{post\|dept\|role\|user}/*` |
| 学校管理 | `/school/{grade\|class\|student}/*` |
| 设备管理 | `/equipment/*` |

## 注意事项

1. **外键约束**：删除岗位/部门/角色/年级/班级前，请确保没有关联数据
2. **权限生效**：权限修改后，用户需重新登录才能生效
3. **Excel 导入**：班级ID必须与系统中已有的班级ID一致
4. **MD5 加密**：新增用户时密码使用 MD5 加密存储

## 开发计划

- [ ] 添加日志记录功能
- [ ] 添加数据导出功能
- [ ] 添加批量删除功能
- [ ] 优化权限管理（支持自定义权限）
- [ ] 添加操作审计

## 许可证

MIT License
