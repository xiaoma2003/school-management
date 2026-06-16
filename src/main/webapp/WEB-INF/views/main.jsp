<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<html>
<head>
    <meta charset="UTF-8">
    <title>校生通管理系统 - 主界面</title>
    <link rel="icon" type="image/x-icon" href="<%= ctx %>/favicon.ico">
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
        .modules { display: flex; gap: 30px; margin-top: 50px; justify-content: center; }
        .module { width: 220px; padding: 25px; background: #fff; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.1); text-align: center; }
        .module a { text-decoration: none; color: #333; }
        .module h3 { color: #4CAF50; font-size: 20px; }
        .required { color: #dc3545; margin-left: 4px; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="<%= ctx %>/main">首页</a></li>
            <li class="nav-module"><a href="<%= ctx %>/system/post/list">系统管理</a></li>
            <li class="nav-module"><a href="<%= ctx %>/school/grade/list">学校管理</a></li>
            <li class="nav-module"><a href="<%= ctx %>/equipment/list">设备管理</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="<%= ctx %>/logout">退出登录</a>
        </div>
        <div class="modules">
            <div class="module">
                <a href="<%= ctx %>/system/post/list">
                    <h3>系统管理</h3>
                    <p>用户、角色、部门管理</p>
                </a>
            </div>
            <div class="module">
                <a href="<%= ctx %>/school/grade/list">
                    <h3>学校管理</h3>
                    <p>年级、班级、学生管理</p>
                </a>
            </div>
            <div class="module">
                <a href="<%= ctx %>/equipment/list">
                    <h3>设备管理</h3>
                    <p>设备信息、状态管理</p>
                </a>
            </div>
        </div>
    </div>
</body>
</html>