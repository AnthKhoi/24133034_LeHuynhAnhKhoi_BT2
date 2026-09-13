<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu mới | Shopping Service</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #0f3460 0%, #16213e 50%, #1a1a2e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', system-ui, sans-serif;
            padding: 20px;
        }
        .auth-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 440px;
            overflow: hidden;
        }
        .auth-header {
            background: linear-gradient(135deg, #e94560 0%, #c73652 100%);
            color: white;
            padding: 24px;
            text-align: center;
        }
        .btn-primary {
            background: #e94560;
            border-color: #e94560;
            padding: 10px 0;
            font-weight: 600;
        }
        .btn-primary:hover {
            background: #c73652;
            border-color: #c73652;
        }
        .otp-input {
            letter-spacing: 6px;
            font-size: 20px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-header">
            <h3 class="mb-1 fw-bold"><i class="bi bi-shield-lock me-2"></i>Đặt lại mật khẩu</h3>
            <p class="mb-0 text-white-50 small">Nhập mã OTP đã nhận và thiết lập mật khẩu mới</p>
        </div>
        <div class="p-4">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="email" value="${email}">

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email</label>
                    <input type="email" class="form-control bg-light" value="${email}" disabled>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mã OTP (6 chữ số)</label>
                    <input type="text" class="form-control otp-input" name="otp" maxlength="6" pattern="[0-9]{6}" placeholder="------" required autofocus>
                    <div class="invalid-feedback">Vui lòng nhập 6 chữ số OTP.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mật khẩu mới</label>
                    <div class="input-group">
                        <input type="password" class="form-control" name="password" id="newPassword" placeholder="Tối thiểu 6 ký tự" minlength="6" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePw('newPassword', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                        <div class="invalid-feedback">Mật khẩu mới phải có tối thiểu 6 ký tự.</div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Xác nhận mật khẩu mới</label>
                    <div class="input-group">
                        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Nhập lại mật khẩu" minlength="6" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePw('confirmPassword', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                        <div class="invalid-feedback">Vui lòng xác nhận mật khẩu.</div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 rounded-pill mb-3">
                    <i class="bi bi-check-lg me-1"></i>Lưu mật khẩu mới
                </button>
            </form>

            <div class="text-center pt-2 border-top">
                <a href="${pageContext.request.contextPath}/login" class="small text-muted text-decoration-none">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
