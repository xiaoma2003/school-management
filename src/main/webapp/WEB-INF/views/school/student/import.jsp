<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<html>
<head>
    <title>导入学生</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .sidebar { position: fixed; top: 0; left: 0; width: 200px; height: 100vh; background: #2c3e50; color: white; overflow-y: auto; }
        .sidebar h2 { text-align: center; padding: 20px; margin: 0; background: #1a252f; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar li { padding: 10px 20px; }
        .sidebar li:hover { background: #34495e; }
        .sidebar a { color: white; text-decoration: none; display: block; }
        .sidebar .nav-module { background: #1e88e5; }
        .content { margin-left: 200px; padding: 20px; height: 100vh; overflow-y: auto; height: 100vh; overflow-y: auto; }
        .header { background: #f8f9fa; padding: 15px 20px; border-bottom: 1px solid #e9ecef; }
        .header a { float: right; color: #666; text-decoration: none; }
        .welcome { font-size: 18px; color: #333; }
        .btn { padding: 8px 16px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn:hover { background: #45a049; }
        .btn-cancel { background: #6c757d; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, select { width: 300px; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .note { background: #f8f9fa; padding: 15px; border-radius: 4px; margin-bottom: 15px; }
    .required { color: #dc3545; margin-left: 4px; }
</style>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="<%= ctx %>/main">首页</a></li>
            <li class="nav-module"><a href="<%= ctx %>/system/post/list">系统管理</a></li>
            <li><a href="<%= ctx %>/school/grade/list">年级管理</a></li>
            <li><a href="<%= ctx %>/school/class/list">班级管理</a></li>
            <li><a href="<%= ctx %>/school/student/list">学生管理</a></li>
            <li class="nav-module"><a href="<%= ctx %>/equipment/list">设备管理</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="<%= ctx %>/logout">退出登录</a>
        </div>
        <h2>导入学生</h2>
        <div class="note">
            <strong>导入说明：</strong><br>
            1. 请先创建年级和班级信息<br>
            2. Excel文件格式：学号、姓名、性别(男/女)、出生日期(yyyy-MM-dd)、班级ID、电话、地址<br>
            3. 第一行为表头，从第二行开始为数据
        </div>
        <form action="<%= ctx %>/school/student/import" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>选择Excel文件</label>
                <input type="file" name="file" accept=".xlsx,.xls" required>
            </div>
            <button type="submit" class="btn">导入</button>
            <a href="<%= ctx %>/school/student/list" class="btn btn-cancel">取消</a>
        </form>
    </div>
</body>
</html>