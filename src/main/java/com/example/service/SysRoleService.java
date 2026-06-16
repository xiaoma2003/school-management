package com.example.service;

import com.example.entity.SysPermission;
import com.example.entity.SysRole;

import java.util.List;

public interface SysRoleService {
    List<SysRole> findAll();
    List<SysRole> search(String roleName, String roleCode);
    SysRole findById(Integer roleId);
    SysRole findByCode(String roleCode);
    void save(SysRole role, List<Integer> permissionIds);
    void update(SysRole role, List<Integer> permissionIds);
    void deleteById(Integer roleId);
    boolean existsByCode(String roleCode);
    List<SysPermission> findAllPermissions();
}