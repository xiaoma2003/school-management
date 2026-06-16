package com.example.mapper;

import com.example.entity.SysRole;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SysRoleMapper {
    List<SysRole> findAll();
    List<SysRole> search(@Param("roleName") String roleName, @Param("roleCode") String roleCode);
    SysRole findById(Integer roleId);
    SysRole findByCode(String roleCode);
    void insert(SysRole role);
    void update(SysRole role);
    void deleteById(Integer roleId);
    int countByCode(String roleCode);
    void deletePermissionsByRoleId(@Param("roleId") Integer roleId);
    void insertPermissions(@Param("roleId") Integer roleId, @Param("permissionIds") List<Integer> permissionIds);
}