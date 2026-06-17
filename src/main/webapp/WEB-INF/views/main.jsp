<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .content { margin-left: 200px; padding: 20px; height: 100vh; overflow-y: auto; }
        .header { background: #f8f9fa; padding: 15px 20px; border-bottom: 1px solid #e9ecef; }
        .header a { float: right; color: #666; text-decoration: none; }
        .welcome { font-size: 18px; color: #333; }
        .modules { display: flex; gap: 30px; margin-top: 50px; justify-content: center; flex-wrap: wrap; }
        .module { width: 220px; padding: 25px; background: #fff; border-radius: 8px; box-shadow: 0 0 15px rgba(0,0,0,0.1); text-align: center; }
        .module a { text-decoration: none; color: #333; }
        .module h3 { color: #4CAF50; font-size: 20px; }
        .required { color: #dc3545; margin-left: 4px; }
        .no-permission { opacity: 0.5; cursor: not-allowed; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="<%= ctx %>/main">首页</a></li>
            <c:if test="${sessionScope.permissionCodes != null && (sessionScope.permissionCodes.contains('system:manage'))}">
                <li class="nav-module"><a href="<%= ctx %>/system/post/list">系统管理</a></li>
            </c:if>
            <c:if test="${sessionScope.permissionCodes != null && (sessionScope.permissionCodes.contains('school:view') || sessionScope.permissionCodes.contains('school:manage'))}">
                <li class="nav-module"><a href="<%= ctx %>/school/grade/list">学校管理</a></li>
            </c:if>
            <c:if test="${sessionScope.permissionCodes != null && (sessionScope.permissionCodes.contains('equipment:view') || sessionScope.permissionCodes.contains('equipment:manage'))}">
                <li class="nav-module"><a href="<%= ctx %>/equipment/list">设备管理</a></li>
            </c:if>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username} | 角色: ${sessionScope.roleName}</span>
            <a href="<%= ctx %>/logout">退出登录</a>
        </div>
        <div class="modules">
            <c:if test="${sessionScope.permissionCodes != null && sessionScope.permissionCodes.contains('system:manage')}">
                <div class="module">
                    <a href="<%= ctx %>/system/post/list">
                        <h3>系统管理</h3>
                        <p>用户、角色、部门管理</p>
                    </a>
                </div>
            </c:if>
            <c:if test="${sessionScope.permissionCodes != null && (sessionScope.permissionCodes.contains('school:view') || sessionScope.permissionCodes.contains('school:manage'))}">
                <div class="module">
                    <a href="<%= ctx %>/school/grade/list">
                        <h3>学校管理</h3>
                        <p>年级、班级、学生管理</p>
                    </a>
                </div>
            </c:if>
            <c:if test="${sessionScope.permissionCodes != null && (sessionScope.permissionCodes.contains('equipment:view') || sessionScope.permissionCodes.contains('equipment:manage'))}">
                <div class="module">
                    <a href="<%= ctx %>/equipment/list">
                        <h3>设备管理</h3>
                        <p>设备信息、状态管理</p>
                    </a>
                </div>
            </c:if>
            <c:if test="${(sessionScope.permissionCodes == null || sessionScope.permissionCodes.isEmpty())}">
                <div class="module no-permission">
                    <h3>暂无权限</h3>
                    <p>请联系管理员分配权限</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>