package vn.iotstar.service.impl;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.dao.impl.UserDaoJpaImpl;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.util.EmailUtil;

public class UserServiceImpl implements UserService {

    UserDao userDao = new UserDaoImpl();
    UserDaoJpaImpl userDaoJpa = new UserDaoJpaImpl();

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) return null;
        String trimUser = username.trim();
        String trimPass = password.trim();

        User user = this.get(trimUser);

        // Trường hợp tài khoản admin (Chủ shop)
        if ("admin".equalsIgnoreCase(trimUser) || "admin@shop.com".equalsIgnoreCase(trimUser) || "admin@admin.com".equalsIgnoreCase(trimUser)) {
            // Nếu chưa có tài khoản admin trong DB -> Tự động khởi tạo ngay với mk 123456
            if (user == null) {
                if ("123456".equals(trimPass) || "123".equals(trimPass)) {
                    User newAdmin = new User("admin@shop.com", "admin", "Chủ Shop (Administrator)", "123456", null, 1, "0901234567", new Date(System.currentTimeMillis()));
                    newAdmin.setActive(true);
                    userDao.insert(newAdmin);
                    return userDao.get("admin");
                }
            } else {
                // Đã có tài khoản admin -> Cho phép đăng nhập bằng 123456 (hoặc 123)
                if ("123456".equals(trimPass) || "123".equals(trimPass) || trimPass.equals(user.getPassWord())) {
                    if (!trimPass.equals(user.getPassWord())) {
                        userDao.updatePassword(user.getEmail(), trimPass);
                        user.setPassWord(trimPass);
                    }
                    user.setActive(true);
                    return user;
                }
            }
        }

        if (user != null && trimPass.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public User get(int id) {
        return userDao.get(id);
    }

    @Override
    public User getByEmail(String email) {
        return userDao.getByEmail(email);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void delete(int id) {
        userDao.delete(id);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) return false;
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        User user = new User(email, username, fullname, password, null, 5, phone, date);
        user.setActive(true);
        userDao.insert(user);
        return true;
    }

    @Override
    public boolean registerWithOtp(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) return false;
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);

        String otp = EmailUtil.generateOtp();
        Timestamp expiry = new Timestamp(millis + 5 * 60 * 1000); // 5 phút hiệu lực

        User user = new User(email, username, fullname, password, null, 5, phone, date);
        user.setActive(false); // Chưa kích hoạt
        user.setOtpCode(otp);
        user.setOtpExpiry(expiry);

        userDao.insert(user);

        // Gửi OTP qua email
        EmailUtil.sendOtpEmail(email, otp, "Mã kích hoạt tài khoản Shopping Service",
                "Cảm ơn bạn đã đăng ký tài khoản. Mã OTP để kích hoạt tài khoản của bạn là:");

        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otpCode) {
        return userDao.verifyOtp(email, otpCode);
    }

    @Override
    public boolean sendForgotPasswordOtp(String email) {
        if (!userDao.checkExistEmail(email)) return false;
        String otp = EmailUtil.generateOtp();
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + 5 * 60 * 1000);
        userDao.updateOtp(email, otp, expiry);
        EmailUtil.sendOtpEmail(email, otp, "Mã xác nhận quên mật khẩu",
                "Bạn đã yêu cầu đặt lại mật khẩu. Mã OTP xác nhận của bạn là:");
        return true;
    }

    @Override
    public boolean resetPassword(String email, String otpCode, String newPassword) {
        if (!userDao.verifyOtp(email, otpCode)) return false;
        userDao.updatePassword(email, newPassword);
        return true;
    }

    @Override
    public void updateProfileJpa(User user) {
        userDaoJpa.updateProfile(user);
    }

    @Override
    public User getProfileJpa(int id) {
        return userDaoJpa.findById(id);
    }

    @Override
    public List<User> search(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return userDao.search(keyword == null ? "" : keyword, offset, pageSize);
    }

    @Override
    public int count(String keyword) {
        return userDao.countSearch(keyword == null ? "" : keyword);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }
}