package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import vn.iotstar.model.Category;
import vn.iotstar.model.Product;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.ProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet(urlPatterns = {"/admin/product/add"})
public class ProductAddController extends HttpServlet {

    ProductService productService = new ProductServiceImpl();
    CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAll();
        req.setAttribute("categories", categories);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/add-product.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        Product product = new Product();
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");

        try {
            List<FileItem> items = upload.parseRequest(req);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");
                    if ("name".equals(fieldName)) {
                        product.setName(fieldValue);
                    } else if ("description".equals(fieldName)) {
                        product.setDescription(fieldValue);
                    } else if ("price".equals(fieldName)) {
                        try {
                            product.setPrice(new BigDecimal(fieldValue.trim()));
                        } catch (Exception e) {
                            product.setPrice(BigDecimal.ZERO);
                        }
                    } else if ("categoryId".equals(fieldName)) {
                        try {
                            product.setCategoryId(Integer.parseInt(fieldValue.trim()));
                        } catch (Exception ignored) {}
                    }
                } else if ("image".equals(item.getFieldName())) {
                    if (item.getSize() > 0 && item.getName() != null && !item.getName().trim().isEmpty()) {
                        String originalFileName = item.getName();
                        int index = originalFileName.lastIndexOf(".");
                        String ext = index >= 0 ? originalFileName.substring(index + 1) : "jpg";
                        String fileName = System.currentTimeMillis() + "." + ext;
                        File file = new File(Constant.DIR + "/products/" + fileName);
                        file.getParentFile().mkdirs();
                        item.write(file);
                        product.setImage("products/" + fileName);
                    } else {
                        product.setImage(null);
                    }
                }
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/product/list?success=add");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi thêm sản phẩm: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
