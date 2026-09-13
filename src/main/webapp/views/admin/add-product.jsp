<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm sản phẩm mới</title>
</head>
<body>

<div class="d-flex align-items-center mb-4">
    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-secondary me-3">
        <i class="bi bi-arrow-left"></i>
    </a>
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-plus-circle-fill me-2 text-danger"></i>Thêm sản phẩm mới</h4>
        <small class="text-muted">Nhập đầy đủ thông tin chi tiết của sản phẩm</small>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-circle me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" placeholder="Ví dụ: iPhone 15 Pro Max..." required>
                        <div class="invalid-feedback">Vui lòng nhập tên sản phẩm.</div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                            <select class="form-select" name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" step="1000" min="0" class="form-control" name="price" placeholder="Ví dụ: 15000000" required>
                                <span class="input-group-text">₫</span>
                                <div class="invalid-feedback">Vui lòng nhập giá hợp lệ (>= 0).</div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                        <textarea class="form-control" name="description" rows="4" placeholder="Nhập thông tin mô tả chi tiết sản phẩm..."></textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Hình ảnh sản phẩm</label>
                        <input type="file" class="form-control" name="image" accept="image/*" onchange="previewImage(this)">
                        <div class="mt-3 text-center" id="previewBox" style="display:none;">
                            <img id="previewImg" src="#" alt="Preview" class="rounded border" style="max-height:220px; max-width:100%; object-fit:contain;">
                        </div>
                        <div class="form-text">Hỗ trợ các định dạng ảnh JPG, PNG, GIF, WebP.</div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-check-lg me-1"></i>Lưu sản phẩm
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-secondary px-4">
                            Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('previewImg').src = e.target.result;
            document.getElementById('previewBox').style.display = 'block';
        };
        reader.readAsDataURL(input.files[0]);
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
