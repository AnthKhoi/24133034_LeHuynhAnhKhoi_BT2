<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${product.name} - Chi tiết sản phẩm</title>
</head>
<body>

<div class="container my-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product" class="text-decoration-none">Sản phẩm</a></li>
            <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
        </ol>
    </nav>

    <!-- Product Detail Card -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-5">
        <div class="card-body p-4 p-lg-5">
            <div class="row g-5 align-items-center">
                <!-- Product Image -->
                <div class="col-lg-5 text-center">
                    <div class="p-4 bg-light rounded-4 border d-flex align-items-center justify-content-center" style="min-height:360px;">
                        <c:choose>
                            <c:when test="${not empty product.image}">
                                <c:url value="/image?fname=${product.image}" var="pImg"/>
                                <img src="${pImg}" alt="${product.name}" class="img-fluid rounded" style="max-height: 320px; object-fit: contain;">
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-image text-muted" style="font-size: 8rem;"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Product Info -->
                <div class="col-lg-7">
                    <span class="badge bg-danger mb-2 px-3 py-2 rounded-pill">
                        ${not empty product.categoryName ? product.categoryName : 'Sản phẩm công nghệ'}
                    </span>
                    <h2 class="fw-bold mb-3">${product.name}</h2>

                    <div class="display-6 fw-bold text-danger mb-4">
                        <fmt:formatNumber value="${product.price}" pattern="#,##0"/> ₫
                    </div>

                    <div class="mb-4">
                        <h6 class="fw-bold text-muted text-uppercase small">Mô tả sản phẩm:</h6>
                        <p class="lead fs-6 text-secondary">
                            ${not empty product.description ? product.description : 'Thông tin chi tiết của sản phẩm đang được cập nhật.'}
                        </p>
                    </div>

                    <div class="d-flex flex-wrap gap-3 mb-4">
                        <div class="d-flex align-items-center gap-2 border rounded-pill px-3 py-2 bg-light">
                            <i class="bi bi-shield-check text-success fs-5"></i>
                            <span class="small fw-semibold">Bảo hành 12 tháng chính hãng</span>
                        </div>
                        <div class="d-flex align-items-center gap-2 border rounded-pill px-3 py-2 bg-light">
                            <i class="bi bi-truck text-primary fs-5"></i>
                            <span class="small fw-semibold">Giao hàng nhanh 2 giờ</span>
                        </div>
                    </div>

                    <div class="d-flex gap-3">
                        <button type="button" class="btn btn-primary btn-lg rounded-pill px-5">
                            <i class="bi bi-cart-plus me-2"></i>Chọn mua ngay
                        </button>
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary btn-lg rounded-pill px-4">
                            Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Related Products -->
    <c:if test="${not empty relatedProducts}">
        <div class="my-5">
            <h4 class="fw-bold mb-4"><i class="bi bi-grid-fill me-2 text-danger"></i>Sản phẩm cùng danh mục liên quan</h4>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
                <c:forEach items="${relatedProducts}" var="rp">
                    <c:if test="${rp.id != product.id}">
                        <div class="col">
                            <div class="product-card">
                                <div class="card-img-wrapper">
                                    <c:choose>
                                        <c:when test="${not empty rp.image}">
                                            <c:url value="/image?fname=${rp.image}" var="rpImg"/>
                                            <img src="${rpImg}" alt="${rp.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-image text-muted fs-2"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="card-body">
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${rp.id}" class="product-title">
                                        ${rp.name}
                                    </a>
                                    <div class="product-price">
                                        <fmt:formatNumber value="${rp.price}" pattern="#,##0"/> ₫
                                    </div>
                                    <a href="${pageContext.request.contextPath}/product/detail?id=${rp.id}" class="btn btn-outline-primary btn-sm rounded-pill w-100 mt-3">
                                        Chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>
