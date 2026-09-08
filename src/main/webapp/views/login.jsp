<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
    <h2>Đăng Nhập Vào Hệ Thống</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <c:if test="${alert != null}">
            <h3 class="alert alert-danger" style="color:red">${alert}</h3>
        </c:if>
        <section>
            <label class="input login-input">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" placeholder="Tài khoản" name="username" class="form-control">
                </div>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control">
                </div>
            </label>
            <div>
                <input type="checkbox" name="remember" /> Nhớ tôi
            </div>
            <button type="submit" class="btn btn-primary">Đăng nhập</button>
        </section>
    </form>
    <p>Nếu bạn chưa có tài khoản trên hệ thống, thì hãy
       <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
    </p>
</body>
</html>