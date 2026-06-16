package com.example.service.impl;

import com.example.entity.SysDept;
import com.example.mapper.SysDeptMapper;
import com.example.service.SysDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysDeptServiceImpl implements SysDeptService {

    @Autowired
    private SysDeptMapper deptMapper;

    @Override
    public List<SysDept> findAll() {
        return deptMapper.findAll();
    }

    @Override
    public List<SysDept> search(String deptName, String deptCode) {
        return deptMapper.search(deptName, deptCode);
    }

    @Override
    public SysDept findById(Integer deptId) {
        return deptMapper.findById(deptId);
    }

    @Override
    public void save(SysDept dept) {
        deptMapper.insert(dept);
    }

    @Override
    public void update(SysDept dept) {
        deptMapper.update(dept);
    }

    @Override
    public void deleteById(Integer deptId) {
        deptMapper.deleteById(deptId);
    }
}