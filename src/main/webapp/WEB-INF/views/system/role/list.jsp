<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>角色管理</title>
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
        .permission-tag { display: inline-block; padding: 2px 8px; background: #e3f2fd; color: #1976d2; border-radius: 4px; font-size: 12px; margin: 2px; }
        .required { color: #dc3545; margin-left: 4px; }
    </style>
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
        <h2>角色管理</h2>
        <form action="<%= ctx %>/system/role/list" method="get" style="margin: 15px 0;">
            <input type="text" name="roleName" placeholder="请输入角色名称" style="width: 200px; padding: 8px; border: 1px solid #ddd;" value="<%= request.getParameter("roleName") == null ? "" : request.getParameter("roleName") %>"/>
            <input type="text" name="roleCode" placeholder="请输入角色编码" style="width: 200px; padding: 8px; border: 1px solid #ddd; margin-left: 10px;" value="<%= request.getParameter("roleCode") == null ? "" : request.getParameter("roleCode") %>"/>
            <button type="submit" class="btn">搜索</button>
            <button type="reset" class="btn" style="margin-left:10px; background: #6c757d;">重置</button>
        </form>
        <c:if test="${sessionScope.permissionCodes != null && sessionScope.permissionCodes.contains('system:manage')}">
            <a href="<%= ctx %>/system/role/add" class="btn">添加角色</a>
        </c:if>
        <table>
            <tr>
                <th>角色名称</th>
                <th>角色编码</th>
                <th>描述</th>
                <th>权限</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${roles}" var="role">
            <tr>
                <td>${role.roleName}</td>
                <td>${role.roleCode}</td>
                <td>${role.description}</td>
                <td>
                    <c:forEach items="${role.permissions}" var="perm">
                        <span class="permission-tag">${perm.permissionName}</span>
                    </c:forEach>
                </td>
                <td><span class="${role.status == 1 ? 'status-active' : 'status-inactive'}">${role.status == 1 ? '启用' : '禁用'}</span></td>
                <td>
                    <c:if test="${sessionScope.permissionCodes != null && sessionScope.permissionCodes.contains('system:manage')}">
                        <a href="<%= ctx %>/system/role/edit/${role.roleId}" class="btn btn-edit" style="display: inline-block;">编辑</a>
                        <a href="<%= ctx %>/system/role/delete/${role.roleId}" class="btn btn-danger" style="display: inline-block;" onclick="return confirm('确定删除？')">删除</a>
                    </c:if>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>