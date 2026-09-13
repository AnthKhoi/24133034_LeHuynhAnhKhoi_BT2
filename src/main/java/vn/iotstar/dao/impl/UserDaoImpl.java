package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

public class UserDaoImpl implements UserDao {

    private User mapRow(ResultSet rs) throws Exception {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setEmail(rs.getString("email"));
        user.setUserName(rs.getString("username"));
        user.setFullName(rs.getString("fullname"));
        user.setPassWord(rs.getString("password"));
        user.setAvatar(rs.getString("avatar"));
        user.setRoleid(rs.getInt("roleid"));
        user.setPhone(rs.getString("phone"));
        user.setCreatedDate(rs.getDate("createddate"));

        try {
            user.setActive(rs.getBoolean("is_active"));
        } catch (Exception ignored) {
            user.setActive(true);
        }
        if (user.getRoleid() == 1) {
            user.setActive(true);
        }

        try {
            user.setOtpCode(rs.getString("otp_code"));
        } catch (Exception ignored) {}

        try {
            user.setOtpExpiry(rs.getTimestamp("otp_expiry"));
        } catch (Exception ignored) {}

        return user;
    }

    @Override
    public User get(String username) {
        String sql = "SELECT * FROM [User] WHERE username=? OR email=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public User get(int id) {
        String sql = "SELECT * FROM [User] WHERE id=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public User getByEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public void insert(User user) {
        String sql = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createddate, is_active, otp_code, otp_expiry) "
                   + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate());
            ps.setBoolean(9, user.isActive());
            ps.setString(10, user.getOtpCode());
            ps.setTimestamp(11, user.getOtpExpiry());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void update(User user) {
        boolean hasPassword = user.getPassWord() != null && !user.getPassWord().isEmpty();
        String sql = "UPDATE [User] SET email=?, username=?, fullname=?, roleid=?, phone=?, avatar=?" +
                     (hasPassword ? ", password=?" : "") +
                     " WHERE id=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int idx = 1;
            ps.setString(idx++, user.getEmail());
            ps.setString(idx++, user.getUserName());
            ps.setString(idx++, user.getFullName());
            ps.setInt(idx++, user.getRoleid());
            ps.setString(idx++, user.getPhone());
            ps.setString(idx++, user.getAvatar());
            if (hasPassword) {
                ps.setString(idx++, user.getPassWord());
            }
            ps.setInt(idx, user.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM [User] WHERE id=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public List<User> search(String keyword, int offset, int limit) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [User] WHERE username LIKE ? OR fullname LIKE ? OR email LIKE ? " +
                     "ORDER BY id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ps.setInt(4, offset);
            ps.setInt(5, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public int countSearch(String keyword) {
        String sql = "SELECT COUNT(*) FROM [User] WHERE username LIKE ? OR fullname LIKE ? OR email LIKE ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public boolean checkExistEmail(String email) {
        String sql = "SELECT id FROM [User] WHERE email=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) {
        String sql = "SELECT id FROM [User] WHERE username=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeQuery().next();
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        String sql = "SELECT id FROM [User] WHERE phone=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            return ps.executeQuery().next();
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public void updateOtp(String email, String otpCode, Timestamp expiry) {
        String sql = "UPDATE [User] SET otp_code=?, otp_expiry=? WHERE email=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, otpCode);
            ps.setTimestamp(2, expiry);
            ps.setString(3, email);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public boolean verifyOtp(String email, String otpCode) {
        String sql = "SELECT id FROM [User] WHERE email=? AND otp_code=? AND (otp_expiry IS NULL OR otp_expiry >= GETDATE())";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, otpCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Xác thực thành công: kích hoạt tài khoản và xóa OTP
                String updateSql = "UPDATE [User] SET is_active=1, otp_code=NULL, otp_expiry=NULL WHERE email=?";
                try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                    updatePs.setString(1, email);
                    updatePs.executeUpdate();
                }
                return true;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public void updatePassword(String email, String newPassword) {
        String sql = "UPDATE [User] SET password=?, otp_code=NULL, otp_expiry=NULL WHERE email=?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}