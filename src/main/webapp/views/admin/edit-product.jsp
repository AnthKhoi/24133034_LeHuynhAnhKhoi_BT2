<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa sản phẩm</title>
</head>
<body>

<div class="d-flex align-items-center mb-4">
    <a href="${pageContext.request.contextPath}/admin/product/list" class="btn btn-outline-secondary me-3">
        <i class="bi bi-arrow-left"></i>
    </a>
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-pencil-square me-2 text-danger"></i>Chỉnh sửa sản phẩm</h4>
        <small class="text-muted">Cập nhật thông tin sản phẩm #${product.id}</small>
    </div>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <input type="hidden" name="id" value="${product.id}">
                    <input type="hidden" name="oldImage" value="${product.image}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" value="${product.name}" required>
                        <div class="invalid-feedback">Vui lòng nhập tên sản phẩm.</div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                            <select class="form-select" name="categoryId" required>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.id}" ${product.categoryId == c.id ? 'selected' : ''}>${c.name}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" step="1000" min="0" class="form-control" name="price" value="${product.price}" required>
                                <span class="input-group-text">₫</span>
                                <div class="invalid-feedback">Vui lòng nhập giá hợp lệ.</div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô tả sản phẩm</label>
                        <textarea class="form-control" name="description" rows="4">${product.description}</textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Hình ảnh hiện tại</label>
                        <div class="mb-3">
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <c:url value="/image?fname=${product.image}" var="currentImg"/>
                                    <img id="currentImageDisplay" src="${currentImg}" height="140" class="rounded border p-1" style="object-fit:contain; max-width:100%;">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-light rounded border d-flex align-items-center justify-content-center p-3 text-muted" style="height:100px; width:160px;">
                                        <i class="bi bi-image fs-1"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <label class="form-label">Chọn ảnh mới (để trống nếu giữ ảnh hiện tại)</label>
                        <input type="file" class="form-control" name="image" accept="image/*" onchange="previewImage(this)">
                        <div class="mt-3 text-center" id="previewBox" style="display:none;">
                            <img id="previewImg" src="#" alt="Preview" class="rounded border" style="max-height:220px; object-fit:contain;">
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-save me-1"></i>Lưu thay đổi
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
            var curr = document.getElementById('currentImageDisplay');
            if (curr) curr.style.opacity = '0.35';
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
