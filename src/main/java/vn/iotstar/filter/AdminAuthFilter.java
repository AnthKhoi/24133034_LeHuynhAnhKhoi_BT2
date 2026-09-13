package vn.iotstar.filter;

import vn.iotstar.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("account");
            if (user == null) {
                user = (User) session.getAttribute("user");
            }
        }

        if (user == null || user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/login?error=unauthorized");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override public void init(FilterConfig cfg) {}
    @Override public void destroy() {}
}