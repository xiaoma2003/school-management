package com.example.service;

import com.example.entity.SysGrade;

import java.util.List;

public interface SysGradeService {
    List<SysGrade> findAll();
    SysGrade findById(Integer gradeId);
    void save(SysGrade grade);
    void update(SysGrade grade);
    void deleteById(Integer gradeId);
    List<SysGrade> search(String gradeName, String remark);
}