package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.model.Product;

public class ProductDaoImpl extends DBConnection implements ProductDao {

    private Product mapRow(ResultSet rs) throws Exception {
        Product p = new Product();
        p.setId(rs.getInt("product_id"));
        p.setName(rs.getString("product_name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setImage(rs.getString("image"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setCreatedDate(rs.getTimestamp("created_date"));
        try {
            p.setCategoryName(rs.getString("cate_name"));
        } catch (Exception ignored) {}
        return p;
    }

    @Override
    public void insert(Product product) {
        String sql = "INSERT INTO Products(product_name, description, price, image, category_id, created_date) VALUES (?,?,?,?,?,?)";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getImage());
            ps.setInt(5, product.getCategoryId());
            ps.setTimestamp(6, product.getCreatedDate() != null ? product.getCreatedDate() : new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void edit(Product product) {
        String sql = "UPDATE Products SET product_name=?, description=?, price=?, image=?, category_id=? WHERE product_id=?";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getImage());
            ps.setInt(5, product.getCategoryId());
            ps.setInt(6, product.getId());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Products WHERE product_id=?";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public Product get(int id) {
        String sql = "SELECT p.*, c.cate_name FROM Products p LEFT JOIN Category c ON p.category_id = c.cate_id WHERE p.product_id=?";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.cate_name FROM Products p LEFT JOIN Category c ON p.category_id = c.cate_id ORDER BY p.product_id DESC";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Product> getTop10Latest() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP 10 p.*, c.cate_name FROM Products p LEFT JOIN Category c ON p.category_id = c.cate_id "
                   + "ORDER BY p.created_date DESC, p.product_id DESC";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Product> search(String keyword, Integer categoryId, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, c.cate_name FROM Products p LEFT JOIN Category c ON p.category_id = c.cate_id WHERE p.product_name LIKE ? ");
        if (categoryId != null && categoryId > 0) {
            sql.append("AND p.category_id = ? ");
        }
        sql.append("ORDER BY p.created_date DESC, p.product_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            ps.setString(idx++, "%" + (keyword == null ? "" : keyword.trim()) + "%");
            if (categoryId != null && categoryId > 0) {
                ps.setInt(idx++, categoryId);
            }
            ps.setInt(idx++, offset);
            ps.setInt(idx++, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public int countSearch(String keyword, Integer categoryId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products p WHERE p.product_name LIKE ? ");
        if (categoryId != null && categoryId > 0) {
            sql.append("AND p.category_id = ? ");
        }
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int idx = 1;
            ps.setString(idx++, "%" + (keyword == null ? "" : keyword.trim()) + "%");
            if (categoryId != null && categoryId > 0) {
                ps.setInt(idx++, categoryId);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
