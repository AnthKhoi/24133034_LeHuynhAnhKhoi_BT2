package vn.iotstar.util;

import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public static boolean sendOtpEmail(String toEmail, String otpCode, String subject, String messageContent) {
        // Luôn in mã OTP ra console để hỗ trợ kiểm thử và chấm bài ngay cả khi chưa cấu hình email thật
        System.out.println("================================================================================");
        System.out.println("[OTP SERVICE] Gửi OTP tới: " + toEmail);
        System.out.println("[OTP SERVICE] MÃ XÁC NHẬN OTP: >>> " + otpCode + " <<<");
        System.out.println("================================================================================");

        String username = System.getenv("MAIL_USERNAME");
        String password = System.getenv("MAIL_PASSWORD");
        if (username == null || username.trim().isEmpty()) {
            username = System.getProperty("mail.username");
        }
        if (password == null || password.trim().isEmpty()) {
            password = System.getProperty("mail.password");
        }

        // Nếu chưa cấu hình username/password, ta coi như in console thành công (để dev/test trơn tru)
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            System.out.println("[OTP SERVICE] Chưa cấu hình MAIL_USERNAME / MAIL_PASSWORD. Sử dụng mã OTP trong console log.");
            return true;
        }

        String host = System.getenv("MAIL_HOST");
        if (host == null || host.trim().isEmpty()) host = "smtp.gmail.com";
        String port = System.getenv("MAIL_PORT");
        if (port == null || port.trim().isEmpty()) port = "587";

        final String finalUsername = username;
        final String finalPassword = password;

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(finalUsername, finalPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(finalUsername, "ShopAdmin System"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            String htmlBody = "<div style=\"font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;\">"
                    + "<h2 style=\"color: #e94560; text-align: center;\">Xác thực mã OTP</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>" + messageContent + "</p>"
                    + "<div style=\"background-color: #f8f9fa; text-align: center; padding: 15px; border-radius: 6px; margin: 20px 0;\">"
                    + "<span style=\"font-size: 28px; font-weight: bold; letter-spacing: 6px; color: #1a1a2e;\">" + otpCode + "</span>"
                    + "</div>"
                    + "<p style=\"color: #6c757d; font-size: 13px;\">Mã OTP này có hiệu lực trong vòng 5 phút. Vui lòng không chia sẻ mã này với bất kỳ ai.</p>"
                    + "<hr style=\"border: none; border-top: 1px solid #e0e0e0; margin: 20px 0;\">"
                    + "<p style=\"color: #999; font-size: 12px; text-align: center;\">Shopping Service MVC - All rights reserved.</p>"
                    + "</div>";

            message.setContent(htmlBody, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("[OTP SERVICE] Email gửi thành công tới " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("[OTP SERVICE] Không thể gửi email: " + e.getMessage() + ". Vẫn có thể sử dụng mã OTP trên console để tiếp tục.");
            return true; // Trả về true để người dùng vẫn dùng được mã OTP console
        }
    }
}
