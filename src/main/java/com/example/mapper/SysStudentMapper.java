package com.example.mapper;

import com.example.entity.SysStudent;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysStudentMapper {
    List<SysStudent> findAll();
    SysStudent findById(Integer studentId);
    SysStudent findByStudentNo(String studentNo);
    List<SysStudent> findByClassId(Integer classId);
    void insert(SysStudent student);
    void update(SysStudent student);
    void deleteById(Integer studentId);
    int countByStudentNo(String studentNo);
    void batchInsert(List<SysStudent> students);
}