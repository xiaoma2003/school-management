package com.example.service.impl;

import com.example.entity.SysStudent;
import com.example.mapper.SysStudentMapper;
import com.example.service.SysStudentService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class SysStudentServiceImpl implements SysStudentService {

    @Autowired
    private SysStudentMapper studentMapper;

    @Override
    public List<SysStudent> findAll() {
        return studentMapper.findAll();
    }

    @Override
    public SysStudent findById(Integer studentId) {
        return studentMapper.findById(studentId);
    }

    @Override
    public SysStudent findByStudentNo(String studentNo) {
        return studentMapper.findByStudentNo(studentNo);
    }

    @Override
    public List<SysStudent> findByClassId(Integer classId) {
        return studentMapper.findByClassId(classId);
    }

    @Override
    public void save(SysStudent student) {
        studentMapper.insert(student);
    }

    @Override
    public void update(SysStudent student) {
        studentMapper.update(student);
    }

    @Override
    public void deleteById(Integer studentId) {
        studentMapper.deleteById(studentId);
    }

    @Override
    public boolean existsByStudentNo(String studentNo) {
        return studentMapper.countByStudentNo(studentNo) > 0;
    }

    @Override
    public void importStudents(MultipartFile file) {
        List<SysStudent> students = new ArrayList<>();
        try (InputStream is = file.getInputStream();
             Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheetAt(0);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                
                SysStudent student = new SysStudent();
                student.setStudentNo(getCellStringValue(row.getCell(0)));
                student.setStudentName(getCellStringValue(row.getCell(1)));
                
                String genderStr = getCellStringValue(row.getCell(2));
                student.setGender("男".equals(genderStr) ? 1 : ("女".equals(genderStr) ? 2 : null));
                
                String birthdayStr = getCellStringValue(row.getCell(3));
                if (birthdayStr != null && !birthdayStr.isEmpty()) {
                    try {
                        student.setBirthday(sdf.parse(birthdayStr));
                    } catch (ParseException e) {
                    }
                }
                
                student.setClassId(getCellIntValue(row.getCell(4)));
                student.setPhone(getCellStringValue(row.getCell(5)));
                student.setAddress(getCellStringValue(row.getCell(6)));
                student.setStatus(1);
                
                if (!existsByStudentNo(student.getStudentNo())) {
                    students.add(student);
                }
            }
            
            if (!students.isEmpty()) {
                batchInsert(students);
            }
        } catch (Exception e) {
            throw new RuntimeException("导入学生数据失败", e);
        }
    }

    @Override
    public int batchInsert(List<SysStudent> students) {
        studentMapper.batchInsert(students);
        return students.size();
    }

    private String getCellStringValue(Cell cell) {
        if (cell == null) return null;
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
                }
                return String.valueOf((long) cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            default:
                return null;
        }
    }

    private Integer getCellIntValue(Cell cell) {
        if (cell == null) return null;
        switch (cell.getCellType()) {
            case NUMERIC:
                return (int) cell.getNumericCellValue();
            case STRING:
                try {
                    return Integer.parseInt(cell.getStringCellValue());
                } catch (NumberFormatException e) {
                    return null;
                }
            default:
                return null;
        }
    }
}