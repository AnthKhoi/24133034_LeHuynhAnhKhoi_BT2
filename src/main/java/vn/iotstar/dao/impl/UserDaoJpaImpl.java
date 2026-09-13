package vn.iotstar.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import vn.iotstar.model.User;
import vn.iotstar.util.JPAConfig;

public class UserDaoJpaImpl {

    public User findById(int id) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }

    public User findByUsername(String username) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.userName = :username", User.class)
                     .setParameter("username", username)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void updateProfile(User user) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            User u = em.find(User.class, user.getId());
            if (u != null) {
                u.setFullName(user.getFullName());
                u.setPhone(user.getPhone());
                if (user.getAvatar() != null && !user.getAvatar().trim().isEmpty()) {
                    u.setAvatar(user.getAvatar());
                }
                if (user.getPassWord() != null && !user.getPassWord().trim().isEmpty()) {
                    u.setPassWord(user.getPassWord().trim());
                }
                em.merge(u);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            em.close();
        }
    }
}
