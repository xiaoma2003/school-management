<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加用户</title>
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
        .btn { padding: 8px 16px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn:hover { background: #45a049; }
        .btn-cancel { background: #6c757d; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, select { width: 300px; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="/main">首页</a></li>
            <li><a href="/system/post/list">岗位管理</a></li>
            <li><a href="/system/dept/list">部门管理</a></li>
            <li><a href="/system/role/list">角色管理</a></li>
            <li><a href="/system/user/list">用户管理</a></li>
            <li><a href="/school/grade/list">学校管理</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="/logout">退出登录</a>
        </div>
        <h2>添加用户</h2>
        <form action="/system/user/save" method="post">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>真实姓名</label>
                <input type="text" name="realName" required>
            </div>
            <div class="form-group">
                <label>邮箱</label>
                <input type="email" name="email">
            </div>
            <div class="form-group">
                <label>电话</label>
                <input type="text" name="phone">
            </div>
            <div class="form-group">
                <label>部门</label>
                <select name="deptId">
                    <option value="">请选择</option>
                    <c:forEach items="${depts}" var="dept">
                        <option value="${dept.deptId}">${dept.deptName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>岗位</label>
                <select name="postId">
                    <option value="">请选择</option>
                    <c:forEach items="${posts}" var="post">
                        <option value="${post.postId}">${post.postName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>角色</label>
                <select name="roleId">
                    <option value="">请选择</option>
                    <c:forEach items="${roles}" var="role">
                        <option value="${role.roleId}">${role.roleName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>状态</label>
                <select name="status">
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                </select>
            </div>
            <button type="submit" class="btn">保存</button>
            <a href="/system/user/list" class="btn btn-cancel">取消</a>
        </form>
    </div>
</body>
</html>