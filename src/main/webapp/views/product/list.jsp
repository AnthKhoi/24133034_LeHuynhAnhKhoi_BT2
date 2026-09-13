<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm</title>
</head>
<body>

<div class="container my-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Sản phẩm</li>
        </ol>
    </nav>

    <div class="row g-4">
        <!-- Sidebar Filter -->
        <div class="col-lg-3">
            <div class="card p-3 shadow-sm border-0 mb-4">
                <h5 class="fw-bold mb-3"><i class="bi bi-filter me-2 text-danger"></i>Danh mục sản phẩm</h5>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/product?keyword=${keyword}"
                       class="list-group-item list-group-item-action ${empty selectedCateId ? 'active bg-danger border-danger text-white' : ''}">
                        Tất cả danh mục
                    </a>
                    <c:forEach items="${categoryList}" var="cat">
                        <a href="${pageContext.request.contextPath}/product?cateId=${cat.id}&keyword=${keyword}"
                           class="list-group-item list-group-item-action ${selectedCateId == cat.id ? 'active bg-danger border-danger text-white' : ''}">
                            ${cat.name}
                        </a>
                    </c:forEach>
                </div>
            </div>

            <!-- Hotline widget -->
            <div class="card p-3 shadow-sm border-0 bg-light text-center">
                <i class="bi bi-headset fs-1 text-danger mb-2"></i>
                <h6 class="fw-bold">Hỗ trợ tư vấn mua hàng</h6>
                <p class="small text-muted mb-2">Gọi ngay để nhận giá ưu đãi</p>
                <h5 class="fw-bold text-danger mb-0">1800 6868</h5>
            </div>
        </div>

        <!-- Product Grid & Pagination -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4 bg-white p-3 rounded-3 shadow-sm">
                <div>
                    <h4 class="fw-bold mb-0">Tất cả sản phẩm</h4>
                    <small class="text-muted">Tìm thấy <strong>${totalRecords}</strong> sản phẩm (Hiển thị 6 sản phẩm / trang)</small>
                </div>
                <c:if test="${not empty keyword}">
                    <span class="badge bg-light text-dark border">Từ khóa: "${keyword}"</span>
                </c:if>
            </div>

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
                <c:choose>
                    <c:when test="${empty productList}">
                        <div class="col-12 text-center py-5">
                            <i class="bi bi-inbox fs-1 text-muted d-block mb-3"></i>
                            <h5 class="text-muted">Không tìm thấy sản phẩm nào phù hợp!</h5>
                            <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-danger mt-2 rounded-pill">
                                Xem tất cả sản phẩm
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${productList}" var="p">
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
                                            <i class="bi bi-eye me-1"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pagination (6 sp / trang) -->
            <c:if test="${totalPages > 1}">
                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?keyword=${keyword}&cateId=${selectedCateId}&page=${currentPage-1}">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?keyword=${keyword}&cateId=${selectedCateId}&page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?keyword=${keyword}&cateId=${selectedCateId}&page=${currentPage+1}">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>
