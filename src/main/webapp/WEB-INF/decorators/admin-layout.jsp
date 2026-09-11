<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/> | Admin Panel</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body { background-color: #f0f2f5; }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            width: 260px;
            position: fixed;
            top: 0; left: 0;
            z-index: 100;
            box-shadow: 4px 0 15px rgba(0,0,0,0.3);
        }
        .sidebar-brand {
            padding: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .sidebar-brand h4 {
            color: #e94560;
            font-weight: 700;
            margin: 0;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.75);
            padding: 12px 20px;
            border-radius: 8px;
            margin: 2px 10px;
            transition: all 0.3s;
            font-size: 0.95rem;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: #fff;
            background: rgba(233,69,96,0.25);
        }
        .sidebar .nav-link i { margin-right: 10px; width: 20px; }
        .sidebar .nav-section {
            color: rgba(255,255,255,0.4);
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 15px 20px 5px;
        }
        .main-content {
            margin-left: 260px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .topbar {
            background: #fff;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .topbar .page-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #1a1a2e;
            margin: 0;
        }
        .content-area {
            padding: 30px;
            flex: 1;
        }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 15px rgba(0,0,0,0.08); }
        .card-header { border-radius: 12px 12px 0 0 !important; }
        .btn-primary { background: #e94560; border-color: #e94560; }
        .btn-primary:hover { background: #c73652; border-color: #c73652; }
        .table thead th { background: #f8f9fa; font-weight: 600; font-size: 0.85rem; color: #6c757d; text-transform: uppercase; letter-spacing: 0.5px; }
        .badge-role-admin { background: #e94560; }
        .badge-role-user { background: #0f3460; }
        .pagination .page-link { color: #e94560; }
        .pagination .page-item.active .page-link { background: #e94560; border-color: #e94560; color: #fff; }
        .user-avatar-sm { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; background: #e94560; color: white; display: inline-flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 700; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-brand">
            <h4><i class="bi bi-shop me-2"></i>ShopAdmin</h4>
            <small style="color:rgba(255,255,255,0.5);">Quản trị hệ thống</small>
        </div>
        <nav class="mt-3">
            <div class="nav-section">Dashboard</div>
            <a href="${pageContext.request.contextPath}/admin/category/list"
               class="nav-link ${pageContext.request.requestURI.contains('/admin/category') ? 'active' : ''}">
                <i class="bi bi-speedometer2"></i>Tổng quan
            </a>

            <div class="nav-section">Danh mục</div>
            <a href="${pageContext.request.contextPath}/admin/category/list"
               class="nav-link ${pageContext.request.requestURI.contains('/admin/category') ? 'active' : ''}">
                <i class="bi bi-grid-3x3-gap"></i>Quản lý danh mục
            </a>

            <div class="nav-section">Người dùng</div>
            <a href="${pageContext.request.contextPath}/admin/user/list"
               class="nav-link ${pageContext.request.requestURI.contains('/admin/user') ? 'active' : ''}">
                <i class="bi bi-people"></i>Quản lý người dùng
            </a>

            <div class="nav-section mt-auto">Tài khoản</div>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger">
                <i class="bi bi-box-arrow-right"></i>Đăng xuất
            </a>
        </nav>
    </div>

    <!-- Main -->
    <div class="main-content">
        <div class="topbar">
            <h5 class="page-title"><sitemesh:write property="title"/></h5>
            <div class="d-flex align-items-center gap-3">
                <span class="text-muted small"><i class="bi bi-person-circle me-1"></i>
                    ${sessionScope.account.fullName != null ? sessionScope.account.fullName : sessionScope.account.userName}
                </span>
                <span class="badge bg-danger">Admin</span>
            </div>
        </div>
        <div class="content-area">
            <sitemesh:write property="body"/>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
