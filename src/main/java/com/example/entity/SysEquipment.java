package com.example.entity;

import java.util.Date;

public class SysEquipment {
    private Integer equipmentId;
    private String equipmentNo;
    private String equipmentName;
    private Integer deptId;
    private Integer classId;
    private Integer status;
    private String remark;
    private Date createTime;
    private Date updateTime;

    private String deptName;
    private String className;

    public SysEquipment() {}

    public Integer getEquipmentId() { return equipmentId; }
    public void setEquipmentId(Integer equipmentId) { this.equipmentId = equipmentId; }
    public String getEquipmentNo() { return equipmentNo; }
    public void setEquipmentNo(String equipmentNo) { this.equipmentNo = equipmentNo; }
    public String getEquipmentName() { return equipmentName; }
    public void setEquipmentName(String equipmentName) { this.equipmentName = equipmentName; }
    public Integer getDeptId() { return deptId; }
    public void setDeptId(Integer deptId) { this.deptId = deptId; }
    public Integer getClassId() { return classId; }
    public void setClassId(Integer classId) { this.classId = classId; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
}
