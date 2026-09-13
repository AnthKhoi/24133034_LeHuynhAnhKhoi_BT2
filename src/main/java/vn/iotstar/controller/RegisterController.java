package vn.iotstar.controller;

import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        req.setAttribute("username", username);
        req.setAttribute("email", email);
        req.setAttribute("fullname", fullname);
        req.setAttribute("phone", phone);

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()
                || email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng điền đầy đủ các thông tin bắt buộc!");
            req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("alert", "Mật khẩu phải có độ dài từ 6 ký tự trở lên!");
            req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
            return;
        }

        UserService service = new UserServiceImpl();

        if (service.checkExistEmail(email.trim())) {
            req.setAttribute("alert", "Email này đã được sử dụng!");
            req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
            return;
        }
        if (service.checkExistUsername(username.trim())) {
            req.setAttribute("alert", "Tên tài khoản này đã được sử dụng!");
            req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
            return;
        }

        boolean isSuccess = service.registerWithOtp(username.trim(), password.trim(), email.trim(), fullname != null ? fullname.trim() : "", phone != null ? phone.trim() : "");
        if (isSuccess) {
            resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + URLEncoder.encode(email.trim(), "UTF-8"));
        } else {
            req.setAttribute("alert", "Lỗi hệ thống khi đăng ký. Vui lòng thử lại!");
            req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
        }
    }
}