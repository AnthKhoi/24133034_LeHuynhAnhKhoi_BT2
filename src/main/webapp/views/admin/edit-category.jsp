<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Sửa danh mục</title></head>
<body>

<div class="d-flex align-items-center mb-4">
    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary me-3">
        <i class="bi bi-arrow-left"></i>
    </a>
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-pencil-square me-2 text-danger"></i>Sửa danh mục</h4>
        <small class="text-muted">Chỉnh sửa thông tin danh mục #${category.id}</small>
    </div>
</div>

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="card">
            <div class="card-body p-4">
                <form role="form" action="edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${category.id}">

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-lg" name="name"
                               value="${category.name}" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Ảnh đại diện hiện tại</label>
                        <div class="mb-3">
                            <c:choose>
                                <c:when test="${not empty category.icon}">
                                    <c:url value="/image?fname=${category.icon}" var="imgUrl"/>
                                    <img id="currentImg" src="${imgUrl}" height="150"
                                         class="rounded border" style="object-fit:contain; max-width:100%;">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-light rounded d-flex align-items-center justify-content-center border"
                                         style="height:120px; width:200px;">
                                        <i class="bi bi-image text-muted fs-1"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <label class="form-label">Chọn ảnh mới (để trống nếu không thay đổi)</label>
                        <input type="file" class="form-control" name="icon" accept="image/*"
                               onchange="previewImage(this)">
                        <div class="mt-3 text-center" id="previewBox" style="display:none;">
                            <img id="previewImg" src="#" alt="Preview"
                                 class="rounded" style="max-height:200px; object-fit:contain;">
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-save me-2"></i>Lưu thay đổi
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/category/list"
                           class="btn btn-outline-secondary px-4">Hủy</a>
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
            var current = document.getElementById('currentImg');
            if (current) current.style.opacity = '0.4';
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>
