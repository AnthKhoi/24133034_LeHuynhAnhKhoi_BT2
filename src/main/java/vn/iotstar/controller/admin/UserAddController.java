package vn.iotstar.controller.admin;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/admin/user/add"})
public class UserAddController extends HttpServlet {

    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/add-user.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String username  = req.getParameter("username");
        String email     = req.getParameter("email");
        String fullname  = req.getParameter("fullname");
        String password  = req.getParameter("password");
        String phone     = req.getParameter("phone");
        String roleidStr = req.getParameter("roleid");

        // Validate
        if (userService.checkExistUsername(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/views/admin/add-user.jsp").forward(req, resp);
            return;
        }
        if (userService.checkExistEmail(email)) {
            req.setAttribute("error", "Email đã tồn tại!");
            req.getRequestDispatcher("/views/admin/add-user.jsp").forward(req, resp);
            return;
        }

        int roleid = 5;
        try { roleid = Integer.parseInt(roleidStr); } catch (Exception ignored) {}

        User user = new User();
        user.setEmail(email);
        user.setUserName(username);
        user.setFullName(fullname);
        user.setPassWord(password);
        user.setPhone(phone);
        user.setRoleid(roleid);
        user.setCreatedDate(new Date(System.currentTimeMillis()));
        userService.insert(user);

        resp.sendRedirect(req.getContextPath() + "/admin/user/list?success=add");
    }
}
