package com.semka.dao.impl;

import com.semka.dao.UserDao;
import com.semka.entity.UserEntity;
import com.semka.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.Collection;

public class UserDaoImpl implements UserDao {
    public void saveUser(UserEntity user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public Collection<UserEntity> getUsers() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from UserEntity", UserEntity.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}