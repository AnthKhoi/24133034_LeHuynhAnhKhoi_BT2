<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> | Admin Panel</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <sitemesh:write property='head'/>
    <style>
        :root {
            --sidebar-width: 260px;
            --primary-color: #e94560;
            --sidebar-bg: #1a1a2e;
            --sidebar-hover: #16213e;
        }
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: #333;
            min-height: 100vh;
        }
        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            min-height: 100vh;
            background: linear-gradient(180deg, #1a1a2e 0%, #16213e 60%, #0f3460 100%);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 4px 0 15px rgba(0,0,0,0.25);
            display: flex;
            flex-direction: column;
        }
        .sidebar-brand {
            padding: 22px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .sidebar-brand .logo-icon {
            width: 40px;
            height: 40px;
            background: var(--primary-color);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            color: #fff;
            box-shadow: 0 4px 10px rgba(233,69,96,0.4);
        }
        .sidebar-brand h5 {
            color: #fff;
            font-weight: 700;
            margin: 0;
            font-size: 1.15rem;
            letter-spacing: 0.5px;
        }
        .sidebar-brand small {
            color: rgba(255,255,255,0.45);
            font-size: 0.75rem;
            display: block;
        }
        .sidebar-nav {
            padding: 15px 10px;
            flex: 1;
        }
        .nav-section-header {
            color: rgba(255,255,255,0.4);
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 12px 14px 6px;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.75);
            padding: 11px 16px;
            border-radius: 8px;
            margin-bottom: 4px;
            font-size: 0.92rem;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.2s ease;
            text-decoration: none;
        }
        .sidebar .nav-link i {
            font-size: 1.1rem;
            width: 22px;
            text-align: center;
        }
        .sidebar .nav-link:hover {
            color: #fff;
            background: rgba(255,255,255,0.08);
            transform: translateX(4px);
        }
        .sidebar .nav-link.active {
            color: #fff;
            background: linear-gradient(135deg, #e94560 0%, #c73652 100%);
            box-shadow: 0 4px 12px rgba(233,69,96,0.35);
            font-weight: 600;
        }
        .sidebar-footer {
            padding: 15px 12px;
            border-top: 1px solid rgba(255,255,255,0.08);
        }
        /* Main Layout */
        .main-wrapper {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        /* Topbar */
        .topbar {
            height: 65px;
            background: #fff;
            padding: 0 30px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 900;
        }
        .topbar-user {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .topbar-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: #e94560;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 0.9rem;
            box-shadow: 0 2px 6px rgba(233,69,96,0.3);
        }
        /* Content Area */
        .content-body {
            padding: 28px 32px;
            flex: 1;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.05);
        }
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #edf2f7;
            padding: 16px 20px;
            border-radius: 12px 12px 0 0 !important;
            font-weight: 600;
        }
        .btn-primary {
            background: #e94560;
            border-color: #e94560;
        }
        .btn-primary:hover, .btn-primary:focus {
            background: #d1334e;
            border-color: #d1334e;
        }
        .btn-outline-primary {
            color: #e94560;
            border-color: #e94560;
        }
        .btn-outline-primary:hover {
            background: #e94560;
            border-color: #e94560;
            color: #fff;
        }
        .table thead th {
            background-color: #f8fafc;
            color: #64748b;
            font-weight: 600;
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 12px 16px;
            border-bottom: 1px solid #e2e8f0;
        }
        .table tbody td {
            padding: 14px 16px;
            vertical-align: middle;
            border-bottom: 1px solid #edf2f7;
        }
        .pagination .page-link {
            color: #e94560;
            border-radius: 6px;
            margin: 0 2px;
            border: 1px solid #e2e8f0;
        }
        .pagination .page-item.active .page-link {
            background: #e94560;
            border-color: #e94560;
            color: #fff;
        }
        .footer {
            padding: 16px 32px;
            background: #fff;
            border-top: 1px solid #edf2f7;
            font-size: 0.85rem;
            color: #888;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <div class="logo-icon"><i class="bi bi-shield-lock-fill"></i></div>
            <div>
                <h5>ShopAdmin</h5>
                <small>Hệ thống Quản trị</small>
            </div>
        </div>
        <div class="sidebar-nav">
            <div class="nav-section-header">Quản lý Dữ liệu</div>
            <a href="${pageContext.request.contextPath}/admin/category/list"
               class="nav-link ${pageContext.request.requestURI.contains('/admin/category') ? 'active' : ''}">
                <i class="bi bi-grid-3x3-gap-fill"></i>
                <span>Quản lý Danh mục</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/product/list"
               class="nav-link ${pageContext.request.requestURI.contains('/admin/product') ? 'active' : ''}">
                <i class="bi bi-box-seam-fill"></i>
                <span>Quản lý Sản phẩm</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/user/list"
               class="nav-link ${pageContext.request.requestURI.contains('/admin/user') ? 'active' : ''}">
                <i class="bi bi-people-fill"></i>
                <span>Quản lý Người dùng</span>
            </a>
            <div class="nav-section-header">Khác</div>
            <a href="${pageContext.request.contextPath}/home" class="nav-link" target="_blank">
                <i class="bi bi-box-arrow-up-right"></i>
                <span>Xem Trang chủ Web</span>
            </a>
        </div>
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger">
                <i class="bi bi-box-arrow-right"></i>
                <span>Đăng xuất</span>
            </a>
        </div>
    </aside>

    <!-- Main Content Wrapper -->
    <div class="main-wrapper">
        <!-- Topbar -->
        <header class="topbar">
            <div class="d-flex align-items-center gap-2">
                <span class="text-muted small"><i class="bi bi-calendar3 me-1"></i>Hôm nay:</span>
                <span class="badge bg-light text-dark border">
                    <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date()) %>
                </span>
            </div>
            <div class="topbar-user">
                <div class="text-end">
                    <div class="fw-semibold small">
                        ${not empty sessionScope.account.fullName ? sessionScope.account.fullName : (not empty sessionScope.account.userName ? sessionScope.account.userName : 'Admin')}
                    </div>
                    <small class="badge bg-danger">Quản trị viên</small>
                </div>
                <div class="topbar-avatar">
                    ${not empty sessionScope.account.userName ? sessionScope.account.userName.substring(0, 1).toUpperCase() : 'A'}
                </div>
            </div>
        </header>

        <!-- Dynamic Body Content injected by SiteMesh 3 -->
        <main class="content-body">
            <sitemesh:write property='body'/>
        </main>

        <!-- Footer -->
        <footer class="footer d-flex justify-content-between">
            <span>&copy; 2026 <strong>ShopAdmin MVC</strong> - Shopping Servlet Service</span>
            <span>Phiên bản 1.0</span>
        </footer>
    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>