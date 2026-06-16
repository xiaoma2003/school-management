package com.example.mapper;

import com.example.entity.SysClass;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysClassMapper {
    List<SysClass> findAll();
    SysClass findById(Integer classId);
    List<SysClass> findByGradeId(Integer gradeId);
    void insert(SysClass clazz);
    void update(SysClass clazz);
    void deleteById(Integer classId);
}