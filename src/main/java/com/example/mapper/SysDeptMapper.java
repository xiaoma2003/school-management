package com.example.mapper;

import com.example.entity.SysDept;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SysDeptMapper {
    List<SysDept> findAll();
    List<SysDept> search(@Param("deptName") String deptName, @Param("deptCode") String deptCode);
    SysDept findById(Integer deptId);
    void insert(SysDept dept);
    void update(SysDept dept);
    void deleteById(Integer deptId);
}