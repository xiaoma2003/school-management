package com.example.service;

import com.example.entity.SysEquipment;

import java.util.List;

public interface SysEquipmentService {
    List<SysEquipment> findAll();
    SysEquipment findById(Integer equipmentId);
    SysEquipment findByEquipmentNo(String equipmentNo);
    void save(SysEquipment equipment);
    void update(SysEquipment equipment);
    void deleteById(Integer equipmentId);
    void updateStatus(Integer equipmentId, Integer status, String remark);
    List<SysEquipment> search(String keyword, Integer status);
    int countByClassId(Integer classId);
    int countByDeptId(Integer deptId);
}
