<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Sửa người dùng</title></head>
<body>

<div class="d-flex align-items-center mb-4">
    <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-outline-secondary me-3">
        <i class="bi bi-arrow-left"></i>
    </a>
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-person-gear me-2 text-danger"></i>Sửa người dùng</h4>
        <small class="text-muted">Chỉnh sửa thông tin người dùng #${editUser.id}</small>
    </div>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/user/edit" method="post">
                    <input type="hidden" name="id" value="${editUser.id}">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="username"
                                   value="${editUser.userName}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Mật khẩu mới</label>
                            <div class="input-group">
                                <input type="password" class="form-control" name="password"
                                       id="passwordInput" placeholder="Để trống nếu không đổi">
                                <button class="btn btn-outline-secondary" type="button"
                                        onclick="togglePw('passwordInput', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                            <div class="form-text">Chỉ nhập khi muốn thay đổi mật khẩu.</div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Họ và tên</label>
                            <input type="text" class="form-control" name="fullname"
                                   value="${editUser.fullName}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Email</label>
                            <input type="email" class="form-control" name="email"
                                   value="${editUser.email}">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="tel" class="form-control" name="phone"
                                   value="${editUser.phone}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Vai trò <span class="text-danger">*</span></label>
                            <select class="form-select" name="roleid" required>
                                <option value="5" ${editUser.roleid == 5 ? 'selected' : ''}>User (Khách hàng)</option>
                                <option value="1" ${editUser.roleid == 1 ? 'selected' : ''}>Admin (Quản trị viên)</option>
                            </select>
                        </div>
                    </div>

                    <!-- Info card -->
                    <div class="alert alert-light border d-flex gap-3 align-items-start mb-3">
                        <i class="bi bi-info-circle text-primary fs-5 mt-1"></i>
                        <div>
                            <strong>Thông tin tài khoản:</strong><br>
                            <small class="text-muted">
                                Ngày tạo: <strong>${editUser.createdDate != null ? editUser.createdDate : 'Chưa có'}</strong>
                            </small>
                        </div>
                    </div>

                    <hr class="my-3">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-save me-2"></i>Lưu thay đổi
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
