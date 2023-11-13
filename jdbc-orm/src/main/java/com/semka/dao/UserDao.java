package com.semka.dao;

import com.semka.entity.UserEntity;

import java.util.Collection;

public interface UserDao {
    void saveUser(UserEntity user);

    Collection<UserEntity> getUsers();
}