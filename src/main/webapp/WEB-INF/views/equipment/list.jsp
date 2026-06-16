<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String ctx = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>设备管理</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .sidebar { width: 200px; height: 100vh; background: #2c3e50; float: left; color: white; }
        .sidebar h2 { text-align: center; padding: 20px; margin: 0; background: #1a252f; }
        .sidebar ul { list-style: none; padding: 0; }
        .sidebar li { padding: 10px 20px; }
        .sidebar li:hover { background: #34495e; }
        .sidebar a { color: white; text-decoration: none; display: block; }
        .sidebar .active { background: #34495e; }
        .content { margin-left: 200px; padding: 20px; }
        .header { background: #f8f9fa; padding: 15px 20px; border-bottom: 1px solid #e9ecef; }
        .header a { float: right; color: #666; text-decoration: none; }
        .welcome { font-size: 18px; color: #333; }
        .btn { padding: 8px 16px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn:hover { background: #45a049; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .btn-edit { background: #007bff; }
        .btn-edit:hover { background: #0069d9; }
        .btn-warning { background: #fd7e14; }
        .btn-warning:hover { background: #e56b0f; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; }
        .status-normal { color: green; font-weight: bold; }
        .status-faulty { color: red; font-weight: bold; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        .modal-content { background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 400px; border-radius: 8px; }
        .modal select, .modal textarea { width: 100%; padding: 8px; margin: 10px 0; border: 1px solid #ddd; border-radius: 4px; }
        .modal-header { font-size: 18px; font-weight: bold; margin-bottom: 15px; }
        .modal-footer { text-align: right; margin-top: 15px; }
        .modal .btn-cancel { background: #6c757d; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>校生通管理系统</h2>
        <ul>
            <li><a href="<%= ctx %>/main">首页</a></li>
            <li><a href="<%= ctx %>/system/post/list">系统管理</a></li>
            <li><a href="<%= ctx %>/school/grade/list">学校管理</a></li>
            <li><a href="<%= ctx %>/equipment/list" class="active">设备管理</a></li>
        </ul>
    </div>
    <div class="content">
        <div class="header">
            <span class="welcome">欢迎, ${sessionScope.username}</span>
            <a href="<%= ctx %>/logout">退出登录</a>
        </div>
        <h2>设备管理</h2>
        <a href="<%= ctx %>/equipment/add" class="btn">添加设备</a>
        <table>
            <tr>
                <th>设备编号</th>
                <th>设备名称</th>
                <th>所属部门</th>
                <th>所属班级</th>
                <th>状态</th>
                <th>备注</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${equipments}" var="eq">
            <tr>
                <td>${eq.equipmentNo}</td>
                <td>${eq.equipmentName}</td>
                <td>${eq.deptName == null ? '-' : eq.deptName}</td>
                <td>${eq.className == null ? '-' : eq.className}</td>
                <td>
                    <span class="${eq.status == 1 ? 'status-normal' : 'status-faulty'}">
                        ${eq.status == 1 ? '正常' : '故障'}
                    </span>
                </td>
                <td>${eq.remark == null ? '-' : eq.remark}</td>
                <td>
                    <a href="<%= ctx %>/equipment/edit/${eq.equipmentId}" class="btn btn-edit" style="display: inline-block;">编辑</a>
                    <button onclick="showStatusModal(${eq.equipmentId}, ${eq.status})" class="btn btn-warning" style="display: inline-block;">改状态</button>
                    <a href="<%= ctx %>/equipment/delete/${eq.equipmentId}" class="btn btn-danger" style="display: inline-block;" onclick="return confirm('确定删除？')">删除</a>
                </td>
            </tr>
            </c:forEach>
        </table>
    </div>

    <!-- 状态修改模态框 -->
    <div id="statusModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">修改设备状态</div>
            <form id="statusForm">
                <input type="hidden" name="equipmentId" id="statusEquipmentId">
                <div>
                    <label>设备状态</label>
                    <select name="status" id="statusSelect">
                        <option value="1">正常</option>
                        <option value="2">故障</option>
                    </select>
                </div>
                <div>
                    <label>备注</label>
                    <textarea name="remark" id="statusRemark" rows="3" placeholder="请输入备注信息"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" onclick="closeStatusModal()">取消</button>
                    <button type="button" class="btn" onclick="submitStatus()">保存</button>
                </div>
            </form>
        </div>
    </div>

    <script>
    function showStatusModal(equipmentId, currentStatus) {
        document.getElementById('statusEquipmentId').value = equipmentId;
        document.getElementById('statusSelect').value = currentStatus;
        document.getElementById('statusRemark').value = '';
        document.getElementById('statusModal').style.display = 'block';
    }

    function closeStatusModal() {
        document.getElementById('statusModal').style.display = 'none';
    }

    function submitStatus() {
        var equipmentId = document.getElementById('statusEquipmentId').value;
        var status = document.getElementById('statusSelect').value;
        var remark = document.getElementById('statusRemark').value;

        var xhr = new XMLHttpRequest();
        xhr.open('POST', '<%= ctx %>/equipment/updateStatus', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                alert('状态修改成功');
                closeStatusModal();
                location.reload();
            }
        };
        xhr.send('equipmentId=' + equipmentId + '&status=' + status + '&remark=' + encodeURIComponent(remark));
    }

    window.onclick = function(event) {
        var modal = document.getElementById('statusModal');
        if (event.target == modal) {
            closeStatusModal();
        }
    }
    </script>
</body>
</html>
