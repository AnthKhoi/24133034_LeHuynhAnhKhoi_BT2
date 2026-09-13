<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống | Shopping Service</title>
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
            padding: 28px 24px;
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
        .form-control:focus {
            border-color: #e94560;
            box-shadow: 0 0 0 0.25rem rgba(233,69,96,0.25);
        }
    </style>
</head>
<body>
    <div class="auth-card">
        <div class="auth-header">
            <h3 class="mb-1 fw-bold"><i class="bi bi-shop me-2"></i>ShopMVC</h3>
            <p class="mb-0 text-white-50 small">Đăng nhập tài khoản để tiếp tục</p>
        </div>
        <div class="p-4">
            <!-- Alerts -->
            <c:if test="${not empty alert}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i>${alert}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success == 'activated'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>Kích hoạt tài khoản thành công! Hãy đăng nhập ngay.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success == 'reset'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.error == 'unauthorized'}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="bi bi-shield-exclamation me-2"></i>Bạn cần đăng nhập với tài khoản hợp lệ để tiếp tục!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Tài khoản</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" name="username" value="${username}" placeholder="Nhập username" required>
                        <div class="invalid-feedback">Vui lòng nhập tên tài khoản.</div>
                    </div>
                </div>

                <div class="mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <label class="form-label fw-semibold mb-0">Mật khẩu</label>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none" style="color:#e94560;">Quên mật khẩu?</a>
                    </div>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" name="password" id="passwordInput" placeholder="••••••••" required>
                        <button class="btn btn-outline-secondary" type="button" onclick="togglePw('passwordInput', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                        <div class="invalid-feedback">Vui lòng nhập mật khẩu.</div>
                    </div>
                </div>

                <div class="mb-4 form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="remember">
                    <label class="form-check-label small" for="rememberMe">Ghi nhớ đăng nhập</label>
                </div>

                <button type="submit" class="btn btn-primary w-100 rounded-pill mb-3">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                </button>
            </form>

            <div class="text-center pt-2 border-top">
                <span class="text-muted small">Chưa có tài khoản?</span>
                <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-decoration-none ms-1" style="color:#e94560;">Đăng ký ngay</a>
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