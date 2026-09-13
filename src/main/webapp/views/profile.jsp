<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ cá nhân</title>
</head>
<body>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
                </ol>
            </nav>

            <c:if test="${param.success == 'update'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>Cập nhật thông tin hồ sơ bằng JPA thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <div class="card-header bg-white border-bottom p-4">
                    <h4 class="fw-bold mb-1"><i class="bi bi-person-gear me-2 text-danger"></i>Hồ sơ người dùng</h4>
                    <p class="text-muted small mb-0">Cập nhật họ tên, số điện thoại và ảnh đại diện (Lưu qua JPA Hibernate)</p>
                </div>
                <div class="card-body p-4 p-lg-5">
                    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <!-- Avatar Section -->
                        <div class="text-center mb-4 pb-3 border-bottom">
                            <div class="position-relative d-inline-block">
                                <c:choose>
                                    <c:when test="${not empty profileUser.avatar}">
                                        <c:url value="/image?fname=${profileUser.avatar}" var="avtUrl"/>
                                        <img id="avatarPreview" src="${avtUrl}" alt="Avatar"
                                             class="rounded-circle border shadow-sm"
                                             style="width: 120px; height: 120px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div id="avatarPlaceholder" class="rounded-circle border shadow-sm d-flex align-items-center justify-content-center mx-auto"
                                             style="width: 120px; height: 120px; background: #e94560; color: #fff; font-size: 2.5rem; font-weight: 700;">
                                            ${not empty profileUser.userName ? profileUser.userName.substring(0, 1).toUpperCase() : 'U'}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="mt-3">
                                <label for="avatarInput" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                                    <i class="bi bi-camera me-1"></i>Thay đổi ảnh đại diện
                                </label>
                                <input type="file" id="avatarInput" name="avatar" accept="image/*" class="d-none" onchange="previewAvatar(this)">
                            </div>
                            <div class="form-text">Cho phép định dạng JPG, PNG, GIF. Kích thước khuyến nghị 200x200px.</div>
                        </div>

                        <!-- Readonly Info -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Tên tài khoản</label>
                                <input type="text" class="form-control bg-light" value="${profileUser.userName}" disabled>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Email</label>
                                <input type="email" class="form-control bg-light" value="${profileUser.email}" disabled>
                            </div>
                        </div>

                        <!-- Editable Info -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="fullname" value="${profileUser.fullName}" placeholder="Nhập họ và tên" required>
                                <div class="invalid-feedback">Vui lòng nhập họ và tên.</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="tel" class="form-control" name="phone" value="${profileUser.phone}" placeholder="Ví dụ: 0901234567">
                            </div>
                        </div>

                        <!-- Password Change (Optional) -->
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Mật khẩu mới (để trống nếu không đổi)</label>
                            <input type="password" class="form-control" name="newPassword" placeholder="Nhập mật khẩu mới nếu muốn đổi">
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary rounded-pill px-4">
                                Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill px-4">
                                <i class="bi bi-save me-1"></i>Lưu thay đổi (JPA)
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function previewAvatar(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var img = document.getElementById('avatarPreview');
            var placeholder = document.getElementById('avatarPlaceholder');
            if (img) {
                img.src = e.target.result;
            } else if (placeholder) {
                placeholder.innerHTML = '<img src="' + e.target.result + '" class="rounded-circle" style="width: 120px; height: 120px; object-fit: cover;">';
                placeholder.style.background = 'transparent';
            }
        };
        reader.readAsDataURL(input.files[0]);
    }
}
(function () {
    'use strict';
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>
</body>
</html>
