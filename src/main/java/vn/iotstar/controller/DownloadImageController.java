package vn.iotstar.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        File file = new File(Constant.DIR + "/" + fileName);
        if (file.exists() && file.isFile()) {
            String lower = fileName.toLowerCase();
            if (lower.endsWith(".png")) {
                resp.setContentType("image/png");
            } else if (lower.endsWith(".gif")) {
                resp.setContentType("image/gif");
            } else if (lower.endsWith(".webp")) {
                resp.setContentType("image/webp");
            } else {
                resp.setContentType("image/jpeg");
            }
            try (FileInputStream fis = new FileInputStream(file)) {
                IOUtils.copy(fis, resp.getOutputStream());
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}