package com.example.service.impl;

import com.example.entity.SysPermission;
import com.example.entity.SysRole;
import com.example.mapper.SysPermissionMapper;
import com.example.mapper.SysRoleMapper;
import com.example.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SysRoleServiceImpl implements SysRoleService {

    @Autowired
    private SysRoleMapper roleMapper;

    @Autowired
    private SysPermissionMapper permissionMapper;

    @Override
    public List<SysRole> findAll() {
        return roleMapper.findAll();
    }

    @Override
    public List<SysRole> search(String roleName, String roleCode) {
        return roleMapper.search(roleName, roleCode);
    }

    @Override
    public SysRole findById(Integer roleId) {
        return roleMapper.findById(roleId);
    }

    @Override
    public SysRole findByCode(String roleCode) {
        return roleMapper.findByCode(roleCode);
    }

    @Override
    @Transactional
    public void save(SysRole role, List<Integer> permissionIds) {
        roleMapper.insert(role);
        if (permissionIds != null && !permissionIds.isEmpty()) {
            roleMapper.insertPermissions(role.getRoleId(), permissionIds);
        }
    }

    @Override
    @Transactional
    public void update(SysRole role, List<Integer> permissionIds) {
        roleMapper.update(role);
        roleMapper.deletePermissionsByRoleId(role.getRoleId());
        if (permissionIds != null && !permissionIds.isEmpty()) {
            roleMapper.insertPermissions(role.getRoleId(), permissionIds);
        }
    }

    @Override
    @Transactional
    public void deleteById(Integer roleId) {
        roleMapper.deletePermissionsByRoleId(roleId);
        roleMapper.deleteById(roleId);
    }

    @Override
    public boolean existsByCode(String roleCode) {
        return roleMapper.countByCode(roleCode) > 0;
    }

    @Override
    public List<SysPermission> findAllPermissions() {
        return permissionMapper.findAll();
    }
}