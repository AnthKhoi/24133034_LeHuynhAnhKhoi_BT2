package vn.iotstar.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {

    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String action = req.getParameter("action");

        if ("resend".equalsIgnoreCase(action) && email != null && !email.trim().isEmpty()) {
            User user = userService.getByEmail(email);
            if (user != null) {
                userService.registerWithOtp(user.getUserName(), user.getPassWord(), user.getEmail(), user.getFullName(), user.getPhone());
                req.setAttribute("info", "Mã OTP mới đã được gửi tới email của bạn (vui lòng kiểm tra email hoặc console log)!");
            }
        }

        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        if (email == null || email.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ email và mã OTP!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean verified = userService.verifyOtp(email.trim(), otp.trim());
        if (verified) {
            resp.sendRedirect(req.getContextPath() + "/login?success=activated");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn (5 phút)! Vui lòng thử lại hoặc bấm Gửi lại OTP.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
