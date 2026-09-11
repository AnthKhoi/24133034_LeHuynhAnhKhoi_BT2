package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/admin/user/list"})
public class UserListController extends HttpServlet {

    private static final int PAGE_SIZE = 5;
    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";

        String pageStr = req.getParameter("page");
        int currentPage = 1;
        try { currentPage = Integer.parseInt(pageStr); } catch (Exception ignored) {}
        if (currentPage < 1) currentPage = 1;

        int totalRecords = userService.count(keyword);
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<User> userList = userService.search(keyword, currentPage, PAGE_SIZE);

        req.setAttribute("userList", userList);
        req.setAttribute("keyword", keyword);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalRecords", totalRecords);

        req.getRequestDispatcher("/views/admin/list-user.jsp").forward(req, resp);
    }
}
