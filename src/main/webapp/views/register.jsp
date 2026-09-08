<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <h2>Tạo tài khoản mới</h2>
        <c:if test="${alert != null}">
            <h3 class="alert alert-danger" style="color:red">${alert}</h3>
        </c:if>
        <section>
            <label class="input login-input">
                <div class="input-group">
                    <input type="text" placeholder="Tài khoản" name="username" class="form-control">
                </div>
                <div class="input-group">
                    <input type="email" placeholder="Email" name="email" class="form-control">
                </div>
                <div class="input-group">
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control">
                </div>
                <div class="input-group">
                    <input type="text" placeholder="Họ tên" name="fullname" class="form-control">
                </div>
                <div class="input-group">
                    <input type="text" placeholder="Phone" name="phone" class="form-control">
                </div>
            </label>
            <button type="submit">Tạo tài khoản</button>
        </section>
    </form>
</body>
</html>