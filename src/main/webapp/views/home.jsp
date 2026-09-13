<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - Cửa hàng Công nghệ</title>
</head>
<body>

<!-- Hero Banner -->
<div class="container my-4">
    <div class="p-5 rounded-4 text-white position-relative overflow-hidden" style="background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);">
        <div class="row align-items-center position-relative" style="z-index:2;">
            <div class="col-lg-7">
                <span class="badge bg-danger mb-3 px-3 py-2 rounded-pill">Ưu đãi mùa hè 2026</span>
                <h1 class="display-5 fw-bold mb-3">Công nghệ đỉnh cao<br><span style="color:#e94560;">Giá tốt mỗi ngày</span></h1>
                <p class="lead text-white-50 mb-4">Khám phá hàng loạt thiết bị di động, laptop, phụ kiện công nghệ chính hãng mới nhất với nhiều ưu đãi độc quyền.</p>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-primary btn-lg rounded-pill px-4 me-2">
                    <i class="bi bi-bag-check me-2"></i>Xem tất cả sản phẩm
                </a>
            </div>
            <div class="col-lg-5 text-center d-none d-lg-block">
                <i class="bi bi-laptop text-white-50" style="font-size: 10rem;"></i>
            </div>
        </div>
    </div>
</div>

<!-- 10 Newest Products Section -->
<div class="container my-5">
    <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3">
        <div>
            <span class="badge bg-danger mb-2">Mới cập nhật</span>
            <h3 class="fw-bold mb-0 text-dark"><i class="bi bi-stars me-2 text-warning"></i>10 Sản phẩm mới nhất</h3>
        </div>
        <a href="${pageContext.request.contextPath}/product" class="text-decoration-none fw-semibold" style="color:#e94560;">
            Xem tất cả <i class="bi bi-arrow-right"></i>
        </a>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
        <c:forEach items="${latestProducts}" var="p">
            <div class="col">
                <div class="product-card">
                    <div class="card-img-wrapper">
                        <c:choose>
                            <c:when test="${not empty p.image}">
                                <c:url value="/image?fname=${p.image}" var="pImg"/>
                                <img src="${pImg}" alt="${p.name}">
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-image text-muted fs-1"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="card-body">
                        <small class="text-muted mb-1">${p.categoryName}</small>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="product-title" title="${p.name}">
                            ${p.name}
                        </a>
                        <div class="product-price">
                            <fmt:formatNumber value="${p.price}" pattern="#,##0"/> ₫
                        </div>
                        <a href="${pageContext.request.contextPath}/product/detail?id=${p.id}" class="btn btn-outline-primary btn-sm rounded-pill w-100 mt-3">
                            <i class="bi bi-eye me-1"></i>Chi tiết
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Categories Section -->
<div class="container my-5 py-4 bg-white rounded-4 shadow-sm">
    <h4 class="fw-bold text-center mb-4"><i class="bi bi-grid-3x3-gap-fill me-2 text-danger"></i>Danh mục nổi bật</h4>
    <div class="row row-cols-2 row-cols-md-4 g-3 text-center">
        <c:forEach items="${categories}" var="cat">
            <div class="col">
                <a href="${pageContext.request.contextPath}/product?cateId=${cat.id}" class="text-decoration-none text-dark">
                    <div class="p-3 rounded-3 border bg-light h-100 hover-shadow">
                        <i class="bi bi-phone-fill fs-2 text-danger d-block mb-2"></i>
                        <span class="fw-semibold">${cat.name}</span>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>