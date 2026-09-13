<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> | ShopMVC - Cửa hàng Công nghệ</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <sitemesh:write property='head'/>
    <style>
        :root {
            --primary-color: #e94560;
            --primary-hover: #c73652;
            --dark-color: #1a1a2e;
        }
        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: #f8fafc;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        /* Top notification bar */
        .top-bar {
            background-color: #0f3460;
            color: rgba(255,255,255,0.8);
            font-size: 0.82rem;
            padding: 6px 0;
        }
        /* Main Navbar */
        .main-nav {
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
            color: var(--primary-color) !important;
        }
        .nav-link {
            font-weight: 500;
            color: #4a5568 !important;
            padding: 8px 16px !important;
            transition: all 0.2s;
        }
        .nav-link:hover, .nav-link.active {
            color: var(--primary-color) !important;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover, .btn-primary:focus {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }
        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: #fff;
        }
        /* Product Cards */
        .product-card {
            border: none;
            border-radius: 12px;
            background: #fff;
            box-shadow: 0 2px 12px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            overflow: hidden;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        }
        .product-card .card-img-wrapper {
            height: 200px;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            padding: 10px;
        }
        .product-card .card-img-wrapper img {
            max-height: 100%;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.3s;
        }
        .product-card:hover .card-img-wrapper img {
            transform: scale(1.05);
        }
        .product-card .card-body {
            padding: 16px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .product-card .product-title {
            font-weight: 600;
            font-size: 1rem;
            color: #1a1a2e;
            text-decoration: none;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 48px;
            margin-bottom: 8px;
        }
        .product-card .product-title:hover {
            color: var(--primary-color);
        }
        .product-card .product-price {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-top: auto;
        }
        /* Main Container */
        .main-content {
            flex: 1;
            padding-bottom: 40px;
        }
        /* Footer */
        .site-footer {
            background-color: #1a1a2e;
            color: #a0aec0;
            padding: 50px 0 20px;
            margin-top: auto;
        }
        .site-footer h5 {
            color: #fff;
            font-weight: 600;
            margin-bottom: 20px;
        }
        .site-footer a {
            color: #a0aec0;
            text-decoration: none;
            transition: color 0.2s;
        }
        .site-footer a:hover {
            color: var(--primary-color);
        }
        .footer-bottom {
            border-top: 1px solid rgba(255,255,255,0.08);
            margin-top: 40px;
            padding-top: 20px;
            text-align: center;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <!-- Top Bar -->
    <div class="top-bar">
        <div class="container d-flex justify-content-between align-items-center">
            <div>
                <span class="me-3"><i class="bi bi-telephone-fill me-1"></i>Hotline: 1800 6868</span>
                <span><i class="bi bi-envelope-fill me-1"></i>support@shopmvc.vn</span>
            </div>
            <div>
                <span><i class="bi bi-truck me-1"></i>Miễn phí vận chuyển toàn quốc cho đơn từ 500k</span>
            </div>
        </div>
    </div>

    <!-- Main Navigation -->
    <nav class="navbar navbar-expand-lg main-nav">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-shop fs-3"></i>
                <span>ShopMVC</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.requestURI.endsWith('/home') ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/home">
                            <i class="bi bi-house-door me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageContext.request.requestURI.contains('/product') ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/product">
                            <i class="bi bi-grid me-1"></i>Sản phẩm
                        </a>
                    </li>
                </ul>

                <!-- Search Box -->
                <form class="d-flex me-3" action="${pageContext.request.contextPath}/product" method="get">
                    <div class="input-group">
                        <input class="form-control" type="search" name="keyword" value="${keyword}" placeholder="Tìm kiếm sản phẩm..." style="min-width: 220px;">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>

                <!-- User Session Menu -->
                <div class="d-flex align-items-center gap-2">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <div class="dropdown">
                                <button class="btn btn-outline-dark dropdown-toggle d-flex align-items-center gap-2 rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                                    <div style="width:26px; height:26px; background:#e94560; color:#fff; border-radius:50%; display:inline-flex; align-items:center; justify-content:center; font-size:0.8rem; font-weight:700;">
                                        ${sessionScope.account.userName.substring(0, 1).toUpperCase()}
                                    </div>
                                    <span>${not empty sessionScope.account.fullName ? sessionScope.account.fullName : sessionScope.account.userName}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                    <li>
                                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile">
                                            <i class="bi bi-person-gear me-2 text-primary"></i>Hồ sơ cá nhân
                                        </a>
                                    </li>
                                    <c:if test="${sessionScope.account.roleid == 1}">
                                        <li>
                                            <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin/category/list">
                                                <i class="bi bi-speedometer2 me-2 text-danger"></i>Trang Quản trị Admin
                                            </a>
                                        </li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                            <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary rounded-pill px-3 me-1">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary rounded-pill px-3">
                                <i class="bi bi-person-plus me-1"></i>Đăng ký
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Body injected by SiteMesh 3 -->
    <div class="main-content">
        <sitemesh:write property='body'/>
    </div>

    <!-- Footer -->
    <footer class="site-footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <h5 class="text-danger fw-bold"><i class="bi bi-shop me-2"></i>ShopMVC</h5>
                    <p class="small">Hệ thống phân phối thiết bị công nghệ hàng đầu, cam kết chính hãng 100%, bảo hành uy tín và hỗ trợ khách hàng tận tâm.</p>
                    <div class="d-flex gap-3 fs-5 mt-3">
                        <a href="#"><i class="bi bi-facebook"></i></a>
                        <a href="#"><i class="bi bi-youtube"></i></a>
                        <a href="#"><i class="bi bi-tiktok"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Liên kết nhanh</h5>
                    <ul class="list-unstyled small">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/product">Tất cả sản phẩm</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/register">Đăng ký tài khoản</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                    </ul>
                </div>
                <div class="col-lg-5 col-md-12">
                    <h5>Thông tin liên hệ</h5>
                    <ul class="list-unstyled small">
                        <li class="mb-2"><i class="bi bi-geo-alt-fill me-2 text-danger"></i>Số 1 Võ Văn Ngân, TP. Thủ Đức, TP. Hồ Chí Minh</li>
                        <li class="mb-2"><i class="bi bi-telephone-fill me-2 text-danger"></i>(028) 3896 8641 - Hotline: 1800 6868</li>
                        <li class="mb-2"><i class="bi bi-envelope-fill me-2 text-danger"></i>support@shopmvc.vn</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                &copy; 2026 <strong>ShopMVC</strong> - Shopping Servlet Service. All rights reserved.
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
