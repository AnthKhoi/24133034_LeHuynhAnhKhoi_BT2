<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực mã OTP | Shopping Service</title>
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
            letter-spacing: 8px;
            font-size: 24px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-header">
            <h3 class="mb-1 fw-bold"><i class="bi bi-shield-check me-2"></i>Kích hoạt tài khoản</h3>
            <p class="mb-0 text-white-50 small">Nhập mã OTP 6 chữ số được gửi tới email của bạn</p>
        </div>
        <div class="p-4">
            <c:if test="${param.inactive == 'true'}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>Tài khoản chưa được kích hoạt. Vui lòng nhập mã OTP để kích hoạt tài khoản!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty info}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    <i class="bi bi-info-circle me-2"></i>${info}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Email nhận OTP</label>
                    <input type="email" class="form-control" name="email" value="${email}" placeholder="Email của bạn" required>
                    <div class="invalid-feedback">Vui lòng nhập đúng email.</div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mã xác thực OTP (6 chữ số)</label>
                    <input type="text" class="form-control otp-input" name="otp" maxlength="6" pattern="[0-9]{6}" placeholder="------" required autofocus>
                    <div class="invalid-feedback">Vui lòng nhập đủ 6 chữ số OTP.</div>
                    <div class="form-text text-center text-muted">Mã OTP có hiệu lực trong 5 phút. Nếu chưa nhận được mail, hãy kiểm tra hòm thư rác hoặc console log server.</div>
                </div>

                <button type="submit" class="btn btn-primary w-100 rounded-pill mb-3">
                    <i class="bi bi-check2-circle me-1"></i>Xác nhận kích hoạt
                </button>
            </form>

            <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                <a href="${pageContext.request.contextPath}/verify-otp?action=resend&email=${email}" class="small text-decoration-none" style="color:#e94560;">
                    <i class="bi bi-arrow-repeat me-1"></i>Gửi lại mã OTP
                </a>
                <a href="${pageContext.request.contextPath}/login" class="small text-muted text-decoration-none">
                    Quay lại đăng nhập
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
