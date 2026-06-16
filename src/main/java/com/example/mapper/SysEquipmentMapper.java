package com.example.mapper;

import com.example.entity.SysEquipment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysEquipmentMapper {
    List<SysEquipment> findAll();
    SysEquipment findById(Integer equipmentId);
    SysEquipment findByEquipmentNo(String equipmentNo);
    void insert(SysEquipment equipment);
    void update(SysEquipment equipment);
    void deleteById(Integer equipmentId);
    void updateStatus(SysEquipment equipment);
}
