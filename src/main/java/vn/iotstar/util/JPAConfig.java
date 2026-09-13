package vn.iotstar.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class JPAConfig {
    private static EntityManagerFactory factory;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            try {
                factory = Persistence.createEntityManagerFactory("ShoppingService");
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("Không thể khởi tạo EntityManagerFactory: " + e.getMessage(), e);
            }
        }
        return factory.createEntityManager();
    }

    public static synchronized void closeFactory() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
