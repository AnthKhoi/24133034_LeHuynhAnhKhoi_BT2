<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Quản lý người dùng</title></head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-people me-2 text-danger"></i>Danh sách người dùng</h4>
        <small class="text-muted">Tổng cộng: <strong>${totalRecords}</strong> người dùng</small>
    </div>
    <a href="${pageContext.request.contextPath}/admin/user/add" class="btn btn-primary">
        <i class="bi bi-person-plus-fill me-1"></i>Thêm người dùng
    </a>
</div>

<!-- Alerts -->
<c:if test="${param.success == 'add'}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="bi bi-check-circle me-2"></i>Thêm người dùng thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success == 'edit'}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="bi bi-check-circle me-2"></i>Cập nhật người dùng thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.success == 'delete'}">
    <div class="alert alert-success alert-dismissible fade show">
        <i class="bi bi-check-circle me-2"></i>Xóa người dùng thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${param.error == 'self'}">
    <div class="alert alert-danger alert-dismissible fade show">
        <i class="bi bi-exclamation-circle me-2"></i>Không thể xóa tài khoản đang đăng nhập!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Search -->
<div class="card mb-4">
    <div class="card-body py-3">
        <form method="get" action="${pageContext.request.contextPath}/admin/user/list" class="d-flex gap-2">
            <input type="text" name="keyword" value="${keyword}" class="form-control"
                   placeholder="Tìm theo username, họ tên, email..." style="max-width:400px;">
            <button type="submit" class="btn btn-outline-secondary">
                <i class="bi bi-search me-1"></i>Tìm kiếm
            </button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-outline-danger">
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
                        <th style="width:50px">#</th>
                        <th>Tài khoản</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Ngày tạo</th>
                        <th style="width:80px" class="text-center">Vai trò</th>
                        <th style="width:130px" class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty userList}">
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-people fs-1 d-block mb-2"></i>
                                    Không tìm thấy người dùng nào
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${userList}" var="u" varStatus="st">
                                <tr>
                                    <td class="text-muted fw-semibold">${(currentPage-1)*5 + st.index + 1}</td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <div style="background:#e94560; width:36px; height:36px; min-width:36px; border-radius:50%; display:inline-flex; align-items:center; justify-content:center; color:white; font-weight:700; font-size:0.85rem; text-transform:uppercase;">
                                                ${u.userName.substring(0,1)}</div>
                                            <div>
                                                <div class="fw-semibold">${u.userName}</div>
                                                <small class="text-muted">${u.fullName}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="align-middle">
                                        <c:choose>
                                            <c:when test="${not empty u.email}">${u.email}</c:when>
                                            <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle">
                                        <c:choose>
                                            <c:when test="${not empty u.phone}">${u.phone}</c:when>
                                            <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle">
                                        <c:choose>
                                            <c:when test="${not empty u.createdDate}">${u.createdDate}</c:when>
                                            <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle text-center">
                                        <c:choose>
                                            <c:when test="${u.roleid == 1}">
                                                <span class="badge bg-danger">Admin</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge" style="background:#0f3460">User</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle text-center">
                                        <a href="${pageContext.request.contextPath}/admin/user/edit?id=${u.id}"
                                           class="btn btn-sm btn-outline-primary me-1">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger"
                                            onclick="confirmDelete(${u.id}, '${u.userName}')">
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

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title text-danger"><i class="bi bi-exclamation-triangle me-2"></i>Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa người dùng <strong id="userName"></strong> không?
                <br><small class="text-danger">Hành động này không thể hoàn tác!</small>
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
    document.getElementById('userName').textContent = name;
    document.getElementById('deleteLink').href =
        '${pageContext.request.contextPath}/admin/user/delete?id=' + id;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}
</script>
</body>
</html>
