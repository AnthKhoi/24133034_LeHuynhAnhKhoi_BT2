package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.User;

public interface UserDao {
    User get(String username);
    User get(int id);
    void insert(User user);
    void update(User user);
    void delete(int id);
    List<User> search(String keyword, int offset, int limit);
    int countSearch(String keyword);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
}