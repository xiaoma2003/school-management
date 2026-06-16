package com.example.service;

import com.example.entity.SysDept;

import java.util.List;

public interface SysDeptService {
    List<SysDept> findAll();
    List<SysDept> search(String deptName, String deptCode);
    SysDept findById(Integer deptId);
    void save(SysDept dept);
    void update(SysDept dept);
    void deleteById(Integer deptId);
}