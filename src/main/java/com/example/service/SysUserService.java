package com.example.service;

import com.example.entity.SysUser;

import java.util.List;

public interface SysUserService {
    List<SysUser> findAll();
    List<SysUser> search(String username, String realName);
    SysUser findById(Integer userId);
    SysUser findByUsername(String username);
    void save(SysUser user);
    void update(SysUser user);
    void deleteById(Integer userId);
    boolean existsByUsername(String username);
    boolean login(String username, String password);
    int countByPostId(Integer postId);
    int countByDeptId(Integer deptId);
    int countByRoleId(Integer roleId);
}