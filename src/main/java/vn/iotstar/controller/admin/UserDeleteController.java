package vn.iotstar.controller.admin;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/admin/user/delete"})
public class UserDeleteController extends HttpServlet {

    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        // Không cho xóa chính mình
        HttpSession session = req.getSession(false);
        vn.iotstar.model.User sessionUser = null;
        if (session != null) {
            sessionUser = (vn.iotstar.model.User) session.getAttribute("account");
            if (sessionUser == null) {
                sessionUser = (vn.iotstar.model.User) session.getAttribute("user");
            }
        }
        try {
            int id = Integer.parseInt(idStr);
            if (sessionUser != null && sessionUser.getId() == id) {
                resp.sendRedirect(req.getContextPath() + "/admin/user/list?error=self");
                return;
            }
            userService.delete(id);
        } catch (Exception e) { e.printStackTrace(); }
        resp.sendRedirect(req.getContextPath() + "/admin/user/list?success=delete");
    }
}
