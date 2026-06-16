<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>部门管理</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .sidebar { width: 200px; height: 100vh; background: #2c3e50; float: left; color: white; }
        .sidebar h2 { text-align: center; padding: 20px; margin: 0; background: #1a252f; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar li { padding: 10px 20px; }
        .sidebar li:hover { background: #34495e; }
        .sidebar a { color: white; text-decoration: none; display: block; }
        .sidebar .nav-module { background: #1e88e5; }
        .content { margin-left: 200px; padding: 20px; }
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
</style>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="<%= ctx %>/main">首页</a></li>
            <li><a href="<%= ctx %>/system/post/list">岗位管理</a></li>
            <li><a href="<%= ctx %>/system/dept/list">部门管理</a></li>
            <li><a href="<%= ctx %>/system/role/list">角色管理</a></li>
            <li><a href="<%= ctx %>/system/user/list">用户管理</a></li>
            <li class="nav-module"><a href="<%= ctx %>/school/grade/list">学校管理</a></li>
            <li class="nav-module"><a href="<%= ctx %>/equipment/list">设备管理</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="<%= ctx %>/logout">退出登录</a>
        </div>
        <h2>部门管理</h2>
        <a href="<%= ctx %>/system/dept/add" class="btn">添加部门</a>
        <table>
            <tr>
                <th>部门名称</th>
                <th>上级部门</th>
                <th>排序</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${depts}" var="dept">
            <tr>
                <td>${dept.deptName}</td>
                <td>${dept.parentId == 0 ? '无' : dept.parentId}</td>
                <td>${dept.sortOrder}</td>
                <td><span class="${dept.status == 1 ? 'status-active' : 'status-inactive'}">${dept.status == 1 ? '启用' : '禁用'}</span></td>
                <td>
                    <a href="<%= ctx %>/system/dept/edit/${dept.deptId}" class="btn btn-edit" style="display: inline-block;">编辑</a>
                    <a href="<%= ctx %>/system/dept/delete/${dept.deptId}" class="btn btn-danger" style="display: inline-block;" onclick="return confirm('确定删除？')">删除</a>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>