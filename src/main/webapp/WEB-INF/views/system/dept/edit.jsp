<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<html>
<head>
    <title>编辑部门</title>
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
        <h2>编辑部门</h2>
        <form action="<%= ctx %>/system/dept/save" method="post">
            <input type="hidden" name="deptId" value="${dept.deptId}">
            <div class="form-group">
                <label>部门名称</label>
                <input type="text" name="deptName" value="${dept.deptName}" required>
            </div>
            <div class="form-group">
                <label>上级部门ID</label>
                <input type="number" name="parentId" value="${dept.parentId}">
            </div>
            <div class="form-group">
                <label>排序</label>
                <input type="number" name="sortOrder" value="${dept.sortOrder}">
            </div>
            <div class="form-group">
                <label>状态</label>
                <select name="status">
                    <option value="1" ${dept.status == 1 ? 'selected' : ''}>启用</option>
                    <option value="0" ${dept.status == 0 ? 'selected' : ''}>禁用</option>
                </select>
            </div>
            <button type="submit" class="btn">保存</button>
            <a href="<%= ctx %>/system/dept/list" class="btn btn-cancel">取消</a>
        </form>
    </div>
</body>
</html>