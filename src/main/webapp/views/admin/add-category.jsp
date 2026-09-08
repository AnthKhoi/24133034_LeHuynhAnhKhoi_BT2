<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm danh mục</title>
</head>
<body>
    <h2>Thêm danh mục</h2>
    <form role="form" action="add" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>Tên danh mục:</label>
            <input class="form-control" placeholder="please enter category Name" name="name" />
        </div>
        <div class="form-group">
            <label>Ảnh đại diện</label>
            <input type="file" name="icon" />
        </div>
        <button type="submit" class="btn btn-default">Thêm</button>
        <button type="reset" class="btn btn-primary">Hủy</button>
    </form>
</body>
</html>