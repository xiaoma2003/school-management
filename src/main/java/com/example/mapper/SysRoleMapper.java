package com.example.mapper;

import com.example.entity.SysRole;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysRoleMapper {
    List<SysRole> findAll();
    SysRole findById(Integer roleId);
    SysRole findByCode(String roleCode);
    void insert(SysRole role);
    void update(SysRole role);
    void deleteById(Integer roleId);
    int countByCode(String roleCode);
}