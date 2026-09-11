package vn.iotstar.service.impl;

import java.io.File;
import java.util.List;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.util.Constant;

public class CategoryServiceImpl implements CategoryService {

    CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());
        if (oldCategory == null) return;
        oldCategory.setName(newCategory.getName());
        if (newCategory.getIcon() != null) {
            String fileName = oldCategory.getIcon();
            if (fileName != null) {
                File file = new File(Constant.DIR + "/" + fileName);
                if (file.exists()) file.delete();
            }
            oldCategory.setIcon(newCategory.getIcon());
        }
        categoryDao.edit(oldCategory);
    }

    @Override
    public void delete(int id) {
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return categoryDao.search(keyword == null ? "" : keyword, offset, pageSize);
    }

    @Override
    public int count(String keyword) {
        return categoryDao.countSearch(keyword == null ? "" : keyword);
    }
}