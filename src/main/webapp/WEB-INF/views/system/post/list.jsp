<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>岗位管理</title>
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
        .btn { padding: 8px 16px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn:hover { background: #45a049; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .btn-edit { background: #007bff; }
        .btn-edit:hover { background: #0069d9; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; }
        .status-active { color: green; }
        .status-inactive { color: red; }
        .required { color: #dc3545; margin-left: 4px; }
        .error-msg { background: #f8d7da; color: #721c24; padding: 10px 15px; border-radius: 4px; margin-bottom: 15px; border: 1px solid #f5c6cb; }
    </style>
    <script>
        function checkPermission(permissionCode) {
            var permissions = '<%= session.getAttribute("permissionCodes") %>';
            return permissions != null && permissions.indexOf(permissionCode) >= 0;
        }
    </script>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="<%= ctx %>/main">首页</a></li>
            <c:if test="${sessionScope.permissionCodes != null && sessionScope.permissionCodes.contains('system:manage')}">
                <li class="nav-module"><a href="<%= ctx %>/system/post/list">系统管理</a></li>
                <li><a href="<%= ctx %>/system/post/list">岗位管理</a></li>
                <li><a href="<%= ctx %>/system/dept/list">部门管理</a></li>
                <li><a href="<%= ctx %>/system/role/list">角色管理</a></li>
                <li><a href="<%= ctx %>/system/user/list">用户管理</a></li>
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
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="<%= ctx %>/logout">退出登录</a>
        </div>
        <h2>岗位管理</h2>
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>
        <form action="<%= ctx %>/system/post/list" method="get" style="margin: 15px 0;">
            <input type="text" name="postName" placeholder="请输入岗位名称" style="width: 200px; padding: 8px; border: 1px solid #ddd;" value="<%= request.getParameter("postName") == null ? "" : request.getParameter("postName") %>"/>
            <input type="text" name="postCode" placeholder="请输入岗位编码" style="width: 200px; padding: 8px; border: 1px solid #ddd; margin-left: 10px;" value="<%= request.getParameter("postCode") == null ? "" : request.getParameter("postCode") %>"/>
            <button type="submit" class="btn">搜索</button>
            <button type="reset" class="btn" style="margin-left:10px; background: #6c757d;">重置</button>
        </form>
        <c:if test="${sessionScope.permissionCodes != null && sessionScope.permissionCodes.contains('system:manage')}">
            <a href="<%= ctx %>/system/post/add" class="btn">添加岗位</a>
        </c:if>
        <table>
            <tr>
                <th>岗位名称</th>
                <th>岗位编码</th>
                <th>排序</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${posts}" var="post">
            <tr>
                <td>${post.postName}</td>
                <td>${post.postCode}</td>
                <td>${post.sortOrder}</td>
                <td><span class="${post.status == 1 ? 'status-active' : 'status-inactive'}">${post.status == 1 ? '启用' : '禁用'}</span></td>
                <td>
                    <c:if test="${sessionScope.permissionCodes != null && sessionScope.permissionCodes.contains('system:manage')}">
                        <a href="<%= ctx %>/system/post/edit/${post.postId}" class="btn btn-edit" style="display: inline-block;">编辑</a>
                        <a href="<%= ctx %>/system/post/delete/${post.postId}" class="btn btn-danger" style="display: inline-block;" onclick="return confirm('确定删除？')">删除</a>
                    </c:if>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>