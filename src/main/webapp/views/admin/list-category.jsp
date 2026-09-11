<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Quản lý danh mục</title></head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-grid-3x3-gap me-2 text-danger"></i>Danh sách danh mục</h4>
        <small class="text-muted">Tổng cộng: <strong>${totalRecords}</strong> danh mục</small>
    </div>
    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary">
        <i class="bi bi-plus-lg me-1"></i>Thêm danh mục
    </a>
</div>

<!-- Alert -->
<c:if test="${param.success == 'delete'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>Xóa danh mục thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Search -->
<div class="card mb-4">
    <div class="card-body py-3">
        <form method="get" action="${pageContext.request.contextPath}/admin/category/list" class="d-flex gap-2">
            <input type="text" name="keyword" value="${keyword}" class="form-control"
                   placeholder="Tìm kiếm theo tên danh mục..." style="max-width:400px;">
            <button type="submit" class="btn btn-outline-secondary">
                <i class="bi bi-search me-1"></i>Tìm kiếm
            </button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-danger">
                    <i class="bi bi-x-lg me-1"></i>Xóa lọc
                </a>
            </c:if>
        </form>
    </div>
</div>

<!-- Table -->
<div class="card">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th style="width:60px">#</th>
                        <th style="width:120px">Ảnh</th>
                        <th>Tên danh mục</th>
                        <th style="width:160px" class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty cateList}">
                            <tr>
                                <td colspan="4" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                    Không tìm thấy danh mục nào
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${cateList}" var="cate" varStatus="st">
                                <tr>
                                    <td class="fw-semibold text-muted">${(currentPage-1)*5 + st.index + 1}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty cate.icon}">
                                                <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                                                <img src="${imgUrl}" height="50" width="70"
                                                     class="rounded" style="object-fit:cover;" alt="${cate.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-light rounded d-flex align-items-center justify-content-center"
                                                     style="width:70px;height:50px;">
                                                    <i class="bi bi-image text-muted fs-4"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle fw-semibold">${cate.name}</td>
                                    <td class="align-middle text-center">
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}"
                                           class="btn btn-sm btn-outline-primary me-1">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger"
                                            onclick="confirmDelete(${cate.id}, '${cate.name}')">
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
                <a class="page-link" href="?keyword=${keyword}&page=${currentPage-1}">
                    <i class="bi bi-chevron-left"></i>
                </a>
            </li>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?keyword=${keyword}&page=${i}">${i}</a>
                </li>
            </c:forEach>
            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="page-link" href="?keyword=${keyword}&page=${currentPage+1}">
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
                Bạn có chắc chắn muốn xóa danh mục <strong id="cateName"></strong> không?
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <a id="deleteLink" href="#" class="btn btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>

<script>
function confirmDelete(id, name) {
    document.getElementById('cateName').textContent = name;
    document.getElementById('deleteLink').href =
        '${pageContext.request.contextPath}/admin/category/delete?id=' + id;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}
</script>
</body>
</html>
