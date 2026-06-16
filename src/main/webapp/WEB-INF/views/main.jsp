<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>校生通管理系统 - 主界面</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .sidebar { width: 200px; height: 100vh; background: #2c3e50; float: left; color: white; }
        .sidebar h2 { text-align: center; padding: 20px; margin: 0; background: #1a252f; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar li { padding: 10px 20px; }
        .sidebar li:hover { background: #34495e; }
        .sidebar a { color: white; text-decoration: none; display: block; }
        .content { margin-left: 200px; padding: 20px; }
        .header { background: #f8f9fa; padding: 15px 20px; border-bottom: 1px solid #e9ecef; }
        .header a { float: right; color: #666; text-decoration: none; }
        .welcome { font-size: 18px; color: #333; }
        .modules { display: flex; gap: 20px; margin-top: 30px; }
        .module { width: 200px; padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); text-align: center; }
        .module a { text-decoration: none; color: #333; }
        .module h3 { color: #4CAF50; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="/main">首页</a></li>
            <li><a href="/system/post/list">系统管理</a></li>
            <li><a href="/school/grade/list">学校管理</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="/logout">退出登录</a>
        </div>
        <div class="modules">
            <div class="module">
                <a href="/system/post/list">
                    <h3>系统管理</h3>
                    <p>用户、角色、部门管理</p>
                </a>
            </div>
            <div class="module">
                <a href="/school/grade/list">
                    <h3>学校管理</h3>
                    <p>年级、班级、学生管理</p>
                </a>
            </div>
        </div>
    </div>
</body>
</html>