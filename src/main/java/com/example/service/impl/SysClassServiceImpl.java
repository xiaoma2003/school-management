package com.example.service.impl;

import com.example.entity.SysClass;
import com.example.mapper.SysClassMapper;
import com.example.service.SysClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysClassServiceImpl implements SysClassService {

    @Autowired
    private SysClassMapper classMapper;

    @Override
    public List<SysClass> findAll() {
        return classMapper.findAll();
    }

    @Override
    public SysClass findById(Integer classId) {
        return classMapper.findById(classId);
    }

    @Override
    public List<SysClass> findByGradeId(Integer gradeId) {
        return classMapper.findByGradeId(gradeId);
    }

    @Override
    public void save(SysClass clazz) {
        classMapper.insert(clazz);
    }

    @Override
    public void update(SysClass clazz) {
        classMapper.update(clazz);
    }

    @Override
    public void deleteById(Integer classId) {
        classMapper.deleteById(classId);
    }
}