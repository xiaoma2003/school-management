package com.example.service;

import com.example.entity.SysDept;

import java.util.List;

public interface SysDeptService {
    List<SysDept> findAll();
    SysDept findById(Integer deptId);
    void save(SysDept dept);
    void update(SysDept dept);
    void deleteById(Integer deptId);
}