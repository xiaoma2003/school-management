package com.example.service.impl;

import com.example.entity.SysRole;
import com.example.mapper.SysRoleMapper;
import com.example.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysRoleServiceImpl implements SysRoleService {

    @Autowired
    private SysRoleMapper roleMapper;

    @Override
    public List<SysRole> findAll() {
        return roleMapper.findAll();
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
    public void save(SysRole role) {
        roleMapper.insert(role);
    }

    @Override
    public void update(SysRole role) {
        roleMapper.update(role);
    }

    @Override
    public void deleteById(Integer roleId) {
        roleMapper.deleteById(roleId);
    }

    @Override
    public boolean existsByCode(String roleCode) {
        return roleMapper.countByCode(roleCode) > 0;
    }
}