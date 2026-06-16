package com.example.mapper;

import com.example.entity.SysUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SysUserMapper {
    List<SysUser> findAll();
    List<SysUser> search(@Param("username") String username, @Param("realName") String realName);
    SysUser findById(Integer userId);
    SysUser findByUsername(String username);
    void insert(SysUser user);
    void update(SysUser user);
    void deleteById(Integer userId);
    int countByUsername(String username);
}