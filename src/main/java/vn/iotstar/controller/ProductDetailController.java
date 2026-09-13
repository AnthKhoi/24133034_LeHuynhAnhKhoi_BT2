package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vn.iotstar.model.Product;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.ProductServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/product/detail", "/san-pham/chi-tiet"})
public class ProductDetailController extends HttpServlet {

    ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            Product product = productService.get(id);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/product");
                return;
            }

            // Lấy 4 sản phẩm liên quan cùng danh mục
            List<Product> relatedProducts = productService.search("", product.getCategoryId(), 1, 4);

            req.setAttribute("product", product);
            req.setAttribute("relatedProducts", relatedProducts);

            req.getRequestDispatcher("/views/product/detail.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }
}
