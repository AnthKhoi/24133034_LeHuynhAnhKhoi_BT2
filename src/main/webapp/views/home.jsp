<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
    <h2>Welcome to Home</h2>
    <p>Hello ${sessionScope.account.fullName} (${sessionScope.account.userName})</p>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</body>
</html>