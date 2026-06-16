package com.example.service;

import com.example.entity.SysRole;

import java.util.List;

public interface SysRoleService {
    List<SysRole> findAll();
    SysRole findById(Integer roleId);
    SysRole findByCode(String roleCode);
    void save(SysRole role);
    void update(SysRole role);
    void deleteById(Integer roleId);
    boolean existsByCode(String roleCode);
}