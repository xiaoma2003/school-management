package com.example.mapper;

import com.example.entity.SysPermission;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysPermissionMapper {
    List<SysPermission> findAll();
    SysPermission findById(Integer permissionId);
    List<SysPermission> findByRoleId(Integer roleId);
}
