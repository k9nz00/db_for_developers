package com.semka;

import com.semka.dao.UserDao;
import com.semka.dao.impl.UserDaoImpl;
import com.semka.entity.UserEntity;

public class Main {
    public static void main(String[] args) {
        UserDao userDao = new UserDaoImpl();

//        Collection<UserEntity> users = userDao.getUsers();
//        users.forEach(u -> System.out.println(u.getFirstName()));

        UserEntity user = new UserEntity();
        user.setPasswordHash("");
        user.setLogin("user111");
        user.setEmail("user111@example.com");
        user.setFirstName("User");
        user.setLastName("User");
        user.setActive(true);
        userDao.saveUser(user);
    }
}
