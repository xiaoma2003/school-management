package com.example.mapper;

import com.example.entity.SysGrade;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysGradeMapper {
    List<SysGrade> findAll();
    SysGrade findById(Integer gradeId);
    void insert(SysGrade grade);
    void update(SysGrade grade);
    void deleteById(Integer gradeId);
}