<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Thêm người dùng</title></head>
<body>

<div class="d-flex align-items-center mb-4">
    <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-outline-secondary me-3">
        <i class="bi bi-arrow-left"></i>
    </a>
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-person-plus-fill me-2 text-danger"></i>Thêm người dùng mới</h4>
        <small class="text-muted">Điền đầy đủ thông tin để tạo tài khoản</small>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger">
        <i class="bi bi-exclamation-circle me-2"></i>${error}
    </div>
</c:if>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/user/add" method="post">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="username"
                                   placeholder="username" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="password" class="form-control" name="password"
                                       id="passwordInput" placeholder="••••••••" required>
                                <button class="btn btn-outline-secondary" type="button"
                                        onclick="togglePw('passwordInput', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Họ và tên</label>
                            <input type="text" class="form-control" name="fullname"
                                   placeholder="Nguyễn Văn A">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Email</label>
                            <input type="email" class="form-control" name="email"
                                   placeholder="example@email.com">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="tel" class="form-control" name="phone"
                                   placeholder="0901234567">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Vai trò <span class="text-danger">*</span></label>
                            <select class="form-select" name="roleid" required>
                                <option value="5">User (Khách hàng)</option>
                                <option value="1">Admin (Quản trị viên)</option>
                            </select>
                        </div>
                    </div>

                    <hr class="my-3">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-person-check me-2"></i>Tạo tài khoản
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/user/list"
                           class="btn btn-outline-secondary px-4">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function togglePw(id, btn) {
    var inp = document.getElementById(id);
    if (inp.type === 'password') {
        inp.type = 'text';
        btn.innerHTML = '<i class="bi bi-eye-slash"></i>';
    } else {
        inp.type = 'password';
        btn.innerHTML = '<i class="bi bi-eye"></i>';
    }
}
</script>
</body>
</html>
