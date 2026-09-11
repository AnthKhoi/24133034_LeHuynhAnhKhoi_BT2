<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head><title>Thêm danh mục</title></head>
<body>

<div class="d-flex align-items-center mb-4">
    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary me-3">
        <i class="bi bi-arrow-left"></i>
    </a>
    <div>
        <h4 class="mb-0 fw-bold"><i class="bi bi-plus-circle me-2 text-danger"></i>Thêm danh mục mới</h4>
        <small class="text-muted">Điền đầy đủ thông tin để tạo danh mục</small>
    </div>
</div>

<div class="row justify-content-center">
    <div class="col-lg-7">
        <div class="card">
            <div class="card-body p-4">
                <form role="form" action="add" method="post" enctype="multipart/form-data">

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-lg" name="name"
                               placeholder="Nhập tên danh mục..." required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Ảnh đại diện</label>
                        <input type="file" class="form-control" name="icon" accept="image/*"
                               onchange="previewImage(this)">
                        <div class="mt-3 text-center" id="previewBox" style="display:none;">
                            <img id="previewImg" src="#" alt="Preview"
                                 class="rounded" style="max-height:200px; max-width:100%; object-fit:contain;">
                        </div>
                        <div class="form-text">Hỗ trợ: JPG, PNG, GIF. Tối đa 5MB.</div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-check-lg me-2"></i>Thêm danh mục
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
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>
