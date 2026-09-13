package vn.iotstar.service.impl;

import java.io.File;
import java.util.List;
import vn.iotstar.dao.ProductDao;
import vn.iotstar.dao.impl.ProductDaoImpl;
import vn.iotstar.model.Product;
import vn.iotstar.service.ProductService;
import vn.iotstar.util.Constant;

public class ProductServiceImpl implements ProductService {

    ProductDao productDao = new ProductDaoImpl();

    @Override
    public void insert(Product product) {
        productDao.insert(product);
    }

    @Override
    public void edit(Product newProduct) {
        Product oldProduct = productDao.get(newProduct.getId());
        if (oldProduct == null) return;
        oldProduct.setName(newProduct.getName());
        oldProduct.setDescription(newProduct.getDescription());
        oldProduct.setPrice(newProduct.getPrice());
        oldProduct.setCategoryId(newProduct.getCategoryId());

        if (newProduct.getImage() != null && !newProduct.getImage().trim().isEmpty()) {
            // Xóa file ảnh cũ nếu tồn tại
            if (oldProduct.getImage() != null) {
                File file = new File(Constant.DIR + "/" + oldProduct.getImage());
                if (file.exists()) file.delete();
            }
            oldProduct.setImage(newProduct.getImage());
        }
        productDao.edit(oldProduct);
    }

    @Override
    public void delete(int id) {
        Product product = productDao.get(id);
        if (product != null && product.getImage() != null) {
            File file = new File(Constant.DIR + "/" + product.getImage());
            if (file.exists()) file.delete();
        }
        productDao.delete(id);
    }

    @Override
    public Product get(int id) {
        return productDao.get(id);
    }

    @Override
    public List<Product> getAll() {
        return productDao.getAll();
    }

    @Override
    public List<Product> getTop10Latest() {
        return productDao.getTop10Latest();
    }

    @Override
    public List<Product> search(String keyword, Integer categoryId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return productDao.search(keyword == null ? "" : keyword, categoryId, offset, pageSize);
    }

    @Override
    public int count(String keyword, Integer categoryId) {
        return productDao.countSearch(keyword == null ? "" : keyword, categoryId);
    }
}
