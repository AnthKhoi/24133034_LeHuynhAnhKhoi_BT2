package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.User;

public interface UserService {
    User login(String username, String password);
    User get(String username);
    User get(int id);
    User getByEmail(String email);
    void insert(User user);
    void update(User user);
    void delete(int id);
    boolean register(String username, String password, String email, String fullname, String phone);
    List<User> search(String keyword, int page, int pageSize);
    int count(String keyword);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);

    // OTP and Profile methods
    boolean registerWithOtp(String username, String password, String email, String fullname, String phone);
    boolean verifyOtp(String email, String otpCode);
    boolean sendForgotPasswordOtp(String email);
    boolean resetPassword(String email, String otpCode, String newPassword);
    void updateProfileJpa(User user);
    User getProfileJpa(int id);
}