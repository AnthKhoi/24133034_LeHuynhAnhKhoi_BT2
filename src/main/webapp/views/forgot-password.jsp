<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu | Shopping Service</title>
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
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-header">
            <h3 class="mb-1 fw-bold"><i class="bi bi-key-fill me-2"></i>Quên mật khẩu</h3>
            <p class="mb-0 text-white-50 small">Nhập email đăng ký để nhận mã OTP khôi phục mật khẩu</p>
        </div>
        <div class="p-4">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation" novalidate>
                <div class="mb-4">
                    <label class="form-label fw-semibold">Địa chỉ Email đã đăng ký</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                        <input type="email" class="form-control" name="email" value="${email}" placeholder="example@email.com" required autofocus>
                        <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                    </div>
                    <div class="form-text">Hệ thống sẽ gửi mã xác nhận 6 số tới địa chỉ email này.</div>
                </div>

                <button type="submit" class="btn btn-primary w-100 rounded-pill mb-3">
                    <i class="bi bi-send me-1"></i>Gửi mã OTP xác nhận
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
