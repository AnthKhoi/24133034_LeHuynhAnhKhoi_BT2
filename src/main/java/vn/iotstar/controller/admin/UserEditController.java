package vn.iotstar.controller.admin;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/admin/user/edit"})
public class UserEditController extends HttpServlet {

    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            User user = userService.get(id);
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/user/list");
                return;
            }
            req.setAttribute("editUser", user);
            req.getRequestDispatcher("/views/admin/edit-user.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/user/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String idStr     = req.getParameter("id");
        String username  = req.getParameter("username");
        String email     = req.getParameter("email");
        String fullname  = req.getParameter("fullname");
        String password  = req.getParameter("password");
        String phone     = req.getParameter("phone");
        String roleidStr = req.getParameter("roleid");

        int id = Integer.parseInt(idStr);
        User currentUser = userService.get(id);
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/user/list");
            return;
        }

        int roleid = 5;
        try { roleid = Integer.parseInt(roleidStr); } catch (Exception ignored) {}

        // Kiểm tra username nếu thay đổi
        if (!username.equals(currentUser.getUserName()) && userService.checkExistUsername(username)) {
            req.setAttribute("error", "Tên đăng nhập đã được sử dụng bởi người dùng khác!");
            currentUser.setFullName(fullname);
            currentUser.setEmail(email);
            currentUser.setPhone(phone);
            currentUser.setRoleid(roleid);
            req.setAttribute("editUser", currentUser);
            req.getRequestDispatcher("/views/admin/edit-user.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra email nếu thay đổi
        if (email != null && !email.trim().isEmpty() && !email.equals(currentUser.getEmail()) && userService.checkExistEmail(email)) {
            req.setAttribute("error", "Email đã được sử dụng bởi người dùng khác!");
            currentUser.setUserName(username);
            currentUser.setFullName(fullname);
            currentUser.setPhone(phone);
            currentUser.setRoleid(roleid);
            req.setAttribute("editUser", currentUser);
            req.getRequestDispatcher("/views/admin/edit-user.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setId(id);
        user.setEmail(email);
        user.setUserName(username);
        user.setFullName(fullname);
        user.setPhone(phone);
        user.setRoleid(roleid);
        // Chỉ cập nhật password nếu được nhập
        if (password != null && !password.trim().isEmpty()) {
            user.setPassWord(password.trim());
        } else {
            user.setPassWord("");
        }

        userService.update(user);
        resp.sendRedirect(req.getContextPath() + "/admin/user/list?success=edit");
    }
}
