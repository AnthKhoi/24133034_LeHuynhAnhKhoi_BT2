<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>
</head>
<body>
    <h2>Quản lý danh mục</h2>
    <a href="${pageContext.request.contextPath}/admin/category/add">Thêm danh mục mới</a> |
    <a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a>
    <table border="1">
        <tr>
            <th>STT</th>
            <th>Hình ảnh</th>
            <th>Tên danh mục</th>
            <th>Hành động</th>
        </tr>
        <c:forEach items="${cateList}" var="cate" varStatus="STT">
            <tr class="odd gradeX">
                <td>${STT.index + 1}</td>
                <c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
                <td><img height="150" width="200" src="${imgUrl}" /></td>
                <td>${cate.name}</td>
                <td>
                    <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>">Sửa</a> |
                    <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>