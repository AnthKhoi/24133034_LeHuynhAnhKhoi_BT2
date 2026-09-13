<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý sản phẩm</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-box-seam-fill me-2 text-danger"></i>Danh sách sản phẩm</h4>
        <small class="text-muted">Tổng cộng: <strong>${totalRecords}</strong> sản phẩm</small>
    </div>
    <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary">
        <i class="bi bi-plus-lg me-1"></i>Thêm sản phẩm mới
    </a>
</div>

<!-- Alerts -->
<c:if test="${param.success == 'add'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>Thêm sản phẩm mới thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success == 'edit'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>Cập nhật sản phẩm thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success == 'delete'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>Xóa sản phẩm thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Search & Filter Card -->
<div class="card mb-4">
    <div class="card-body py-3">
        <form method="get" action="${pageContext.request.contextPath}/admin/product/list" class="row g-2 align-items-center">
            <div class="col-md-5">
                <input type="text" name="keyword" value="${keyword}" class="form-control"
                       placeholder="Tìm kiếm theo tên sản phẩm...">
            </div>
            <div class="col-md-4">
                <select name="cateId" class="form-select">
                    <option value="">-- Tất cả danh mục --</option>
                    <c:forEach items="${categoryList}" var="c">
                        <option value="${c.id}" ${selectedCateId == c.id ? 'selected' : ''}>${c.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 d-flex gap-2">
                <button type="submit" class="btn btn-outline-secondary">
                    <i class="bi bi-search me-1"></i>Tìm kiếm
                </button>
                <c:if test="${not empty keyword or not empty selectedCateId}">
                    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-danger">
                        <i class="bi bi-x-lg me-1"></i>Xóa lọc
                    </a>
                </c:if>
            </div>
        </form>
    </div>
</div>

<!-- Products Table -->
<div class="card">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th style="width:50px">#</th>
                        <th style="width:90px">Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Đơn giá</th>
                        <th>Ngày tạo</th>
                        <th style="width:130px" class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty productList}">
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    Không tìm thấy sản phẩm nào
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${productList}" var="p" varStatus="st">
                                <tr>
                                    <td class="fw-semibold text-muted">${(currentPage-1)*5 + st.index + 1}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty p.image}">
                                                <c:url value="/image?fname=${p.image}" var="pImg"/>
                                                <img src="${pImg}" height="50" width="60" class="rounded border" style="object-fit:cover;" alt="${p.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-light rounded border d-flex align-items-center justify-content-center" style="width:60px;height:50px;">
                                                    <i class="bi bi-image text-muted fs-4"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="fw-semibold">${p.name}</div>
                                        <small class="text-muted text-truncate d-inline-block" style="max-width:260px;">${p.description}</small>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border">${not empty p.categoryName ? p.categoryName : 'Chưa phân loại'}</span>
                                    </td>
                                    <td class="fw-bold text-danger">
                                        <fmt:formatNumber value="${p.price}" pattern="#,##0"/> ₫
                                    </td>
                                    <td>
                                        <small class="text-muted"><fmt:formatDate value="${p.createdDate}" pattern="dd/MM/yyyy"/></small>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/product/edit?id=${p.id}" class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="confirmDelete(${p.id}, '${p.name}')" title="Xóa">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Pagination -->
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

<!-- Delete Confirm Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title text-danger"><i class="bi bi-exclamation-triangle me-2"></i>Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa sản phẩm <strong id="prodName"></strong> không?
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <a id="deleteLink" href="#" class="btn btn-danger">Xóa sản phẩm</a>
            </div>
        </div>
    </div>
</div>

<script>
function confirmDelete(id, name) {
    document.getElementById('prodName').textContent = name;
    document.getElementById('deleteLink').href =
        '${pageContext.request.contextPath}/admin/product/delete?id=' + id;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}
</script>
</body>
</html>
