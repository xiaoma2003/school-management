package com.example.service.impl;

import com.example.entity.SysGrade;
import com.example.mapper.SysGradeMapper;
import com.example.service.SysGradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysGradeServiceImpl implements SysGradeService {

    @Autowired
    private SysGradeMapper gradeMapper;

    @Override
    public List<SysGrade> findAll() {
        return gradeMapper.findAll();
    }

    @Override
    public SysGrade findById(Integer gradeId) {
        return gradeMapper.findById(gradeId);
    }

    @Override
    public void save(SysGrade grade) {
        gradeMapper.insert(grade);
    }

    @Override
    public void update(SysGrade grade) {
        gradeMapper.update(grade);
    }

    @Override
    public void deleteById(Integer gradeId) {
        gradeMapper.deleteById(gradeId);
    }
}