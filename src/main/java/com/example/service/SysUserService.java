package com.example.service;

import com.example.entity.SysUser;

import java.util.List;

public interface SysUserService {
    List<SysUser> findAll();
    SysUser findById(Integer userId);
    SysUser findByUsername(String username);
    void save(SysUser user);
    void update(SysUser user);
    void deleteById(Integer userId);
    boolean existsByUsername(String username);
    boolean login(String username, String password);
}