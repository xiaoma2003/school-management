package com.example.service.impl;

import com.example.entity.SysEquipment;
import com.example.mapper.SysEquipmentMapper;
import com.example.service.SysEquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysEquipmentServiceImpl implements SysEquipmentService {

    @Autowired
    private SysEquipmentMapper equipmentMapper;

    @Override
    public List<SysEquipment> findAll() {
        return equipmentMapper.findAll();
    }

    @Override
    public SysEquipment findById(Integer equipmentId) {
        return equipmentMapper.findById(equipmentId);
    }

    @Override
    public SysEquipment findByEquipmentNo(String equipmentNo) {
        return equipmentMapper.findByEquipmentNo(equipmentNo);
    }

    @Override
    public void save(SysEquipment equipment) {
        equipmentMapper.insert(equipment);
    }

    @Override
    public void update(SysEquipment equipment) {
        equipmentMapper.update(equipment);
    }

    @Override
    public void deleteById(Integer equipmentId) {
        equipmentMapper.deleteById(equipmentId);
    }

    @Override
    public void updateStatus(Integer equipmentId, Integer status, String remark) {
        SysEquipment equipment = new SysEquipment();
        equipment.setEquipmentId(equipmentId);
        equipment.setStatus(status);
        equipment.setRemark(remark);
        equipmentMapper.updateStatus(equipment);
    }

    @Override
    public List<SysEquipment> search(String keyword, Integer status) {
        return equipmentMapper.search(keyword, status);
    }
}
