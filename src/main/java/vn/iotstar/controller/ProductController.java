package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/product", "/san-pham"})
public class ProductController extends HttpServlet {

    private static final int PAGE_SIZE = 6; // 6 sản phẩm / trang theo đúng yêu cầu
    ProductService productService = new ProductServiceImpl();
    CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";

        String cateIdStr = req.getParameter("cateId");
        Integer categoryId = null;
        try {
            if (cateIdStr != null && !cateIdStr.trim().isEmpty()) {
                categoryId = Integer.parseInt(cateIdStr);
            }
        } catch (Exception ignored) {}

        String pageStr = req.getParameter("page");
        int currentPage = 1;
        try { currentPage = Integer.parseInt(pageStr); } catch (Exception ignored) {}
        if (currentPage < 1) currentPage = 1;

        int totalRecords = productService.count(keyword, categoryId);
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<Product> productList = productService.search(keyword, categoryId, currentPage, PAGE_SIZE);
        List<Category> categoryList = categoryService.getAll();

        req.setAttribute("productList", productList);
        req.setAttribute("categoryList", categoryList);
        req.setAttribute("keyword", keyword);
        req.setAttribute("selectedCateId", categoryId);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalRecords", totalRecords);

        req.getRequestDispatcher("/views/product/list.jsp").forward(req, resp);
    }
}
