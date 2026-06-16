package com.example.service;

import com.example.entity.SysStudent;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SysStudentService {
    List<SysStudent> findAll();
    SysStudent findById(Integer studentId);
    SysStudent findByStudentNo(String studentNo);
    List<SysStudent> findByClassId(Integer classId);
    void save(SysStudent student);
    void update(SysStudent student);
    void deleteById(Integer studentId);
    boolean existsByStudentNo(String studentNo);
    void importStudents(MultipartFile file);
    int batchInsert(List<SysStudent> students);
}