package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/profile", "/tai-khoan"})
public class ProfileController extends HttpServlet {

    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("account") : null;
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=unauthorized");
            return;
        }

        // Lấy dữ liệu user mới nhất bằng JPA
        User user = userService.getProfileJpa(sessionUser.getId());
        if (user == null) {
            user = sessionUser;
        }
        req.setAttribute("profileUser", user);
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("account") : null;
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");

        String fullname = null;
        String phone = null;
        String newPassword = null;
        String avatarPath = null;

        try {
            List<FileItem> items = upload.parseRequest(req);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString("UTF-8");
                    if ("fullname".equals(name)) {
                        fullname = value;
                    } else if ("phone".equals(name)) {
                        phone = value;
                    } else if ("newPassword".equals(name)) {
                        newPassword = value;
                    }
                } else if ("avatar".equals(item.getFieldName())) {
                    if (item.getSize() > 0 && item.getName() != null && !item.getName().trim().isEmpty()) {
                        String originalFileName = item.getName();
                        int index = originalFileName.lastIndexOf(".");
                        String ext = index >= 0 ? originalFileName.substring(index + 1) : "jpg";
                        String fileName = "user_" + sessionUser.getId() + "_" + System.currentTimeMillis() + "." + ext;
                        File file = new File(Constant.DIR + "/users/" + fileName);
                        file.getParentFile().mkdirs();
                        item.write(file);
                        avatarPath = "users/" + fileName;
                    }
                }
            }

            // Cập nhật thông tin User bằng JPA
            User userToUpdate = new User();
            userToUpdate.setId(sessionUser.getId());
            userToUpdate.setFullName(fullname);
            userToUpdate.setPhone(phone);
            if (avatarPath != null) {
                userToUpdate.setAvatar(avatarPath);
            }
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                userToUpdate.setPassWord(newPassword.trim());
            }

            userService.updateProfileJpa(userToUpdate);

            // Cập nhật lại đối tượng User trong session
            User refreshedUser = userService.getProfileJpa(sessionUser.getId());
            if (refreshedUser != null) {
                session.setAttribute("account", refreshedUser);
            }

            resp.sendRedirect(req.getContextPath() + "/profile?success=update");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật hồ sơ: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
