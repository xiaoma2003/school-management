package com.example.service;

import com.example.entity.SysClass;

import java.util.List;

public interface SysClassService {
    List<SysClass> findAll();
    SysClass findById(Integer classId);
    List<SysClass> findByGradeId(Integer gradeId);
    void save(SysClass clazz);
    void update(SysClass clazz);
    void deleteById(Integer classId);
    List<SysClass> search(String className, Integer gradeId);
}