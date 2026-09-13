package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.Product;

public interface ProductService {
    void insert(Product product);
    void edit(Product product);
    void delete(int id);
    Product get(int id);
    List<Product> getAll();
    List<Product> getTop10Latest();
    List<Product> search(String keyword, Integer categoryId, int page, int pageSize);
    int count(String keyword, Integer categoryId);
}
