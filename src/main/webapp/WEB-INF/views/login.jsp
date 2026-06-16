<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>校生通管理系统 - 登录</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .login-box { width: 320px; margin: 100px auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .login-box h2 { text-align: center; color: #333; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn { width: 100%; padding: 10px; background: #4CAF50; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn:hover { background: #45a049; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>校生通管理系统</h2>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">用户名或密码错误</div>
        <% } %>
        <form action="/login" method="post">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn">登录</button>
        </form>
    </div>
</body>
</html>