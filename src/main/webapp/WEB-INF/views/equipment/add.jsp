<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加设备</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .sidebar { position: fixed; top: 0; left: 0; width: 200px; height: 100vh; background: #2c3e50; color: white; overflow-y: auto; }
        .sidebar h2 { text-align: center; padding: 20px; margin: 0; background: #1a252f; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar li { padding: 10px 20px; }
        .sidebar li:hover { background: #34495e; }
        .sidebar a { color: white; text-decoration: none; display: block; }
        .sidebar .nav-module { background: #1e88e5; }
        .sidebar .active { background: #34495e; }
        .content { margin-left: 200px; padding: 20px; height: 100vh; overflow-y: auto; height: 100vh; overflow-y: auto; }
        .header { background: #f8f9fa; padding: 15px 20px; border-bottom: 1px solid #e9ecef; }
        .header a { float: right; color: #666; text-decoration: none; }
        .welcome { font-size: 18px; color: #333; }
        .btn { padding: 8px 16px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn:hover { background: #45a049; }
        .btn-cancel { background: #6c757d; }
        .btn-cancel:hover { background: #5a6268; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, select, textarea { width: 400px; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .form-group textarea { height: 80px; }
        .error { color: red; margin-top: 5px; }
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
            <li><a href="<%= ctx %>/equipment/list" class="active">设备管理</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="<%= ctx %>/logout">退出登录</a>
        </div>
        <h2>添加设备</h2>
        <form action="<%= ctx %>/equipment/save" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label>设备编号<span class="required">*</span></label>
                <input type="text" name="equipmentNo" id="equipmentNo" required placeholder="请输入设备编号">
                <div class="error" id="equipmentNoError"></div>
            </div>
            <div class="form-group">
                <label>设备名称<span class="required">*</span></label>
                <input type="text" name="equipmentName" id="equipmentName" required placeholder="请输入设备名称">
            </div>
            <div class="form-group">
                <label>所属部门</label>
                <select name="deptId" id="deptSelect">
                    <option value="">-- 不属于任何部门 --</option>
                    <c:forEach items="${depts}" var="dept">
                        <option value="${dept.deptId}">${dept.deptName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>所属班级</label>
                <select name="classId" id="classSelect">
                    <option value="">-- 不属于任何班级 --</option>
                    <c:forEach items="${classes}" var="cls">
                        <option value="${cls.classId}">${cls.gradeName} - ${cls.className}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>状态</label>
                <select name="status">
                    <option value="1">正常</option>
                    <option value="2">故障</option>
                </select>
            </div>
            <div class="form-group">
                <label>备注</label>
                <textarea name="remark" placeholder="请输入备注信息"></textarea>
            </div>
            <button type="submit" class="btn">保存</button>
            <a href="<%= ctx %>/equipment/list" class="btn btn-cancel">取消</a>
        </form>
    </div>

    <script>
    function validateForm() {
        var equipmentNo = document.getElementById('equipmentNo').value.trim();
        var equipmentName = document.getElementById('equipmentName').value.trim();

        if (!equipmentNo) {
            document.getElementById('equipmentNoError').textContent = '请输入设备编号';
            return false;
        }

        var deptId = document.getElementById('deptSelect').value;
        var classId = document.getElementById('classSelect').value;

        if (deptId && classId) {
            alert('设备不能同时属于部门和班级，请选择其中一个或都不选');
            return false;
        }

        return true;
    }
    </script>
</body>
</html>
