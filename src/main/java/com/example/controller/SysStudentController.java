package com.example.controller;

import com.example.entity.SysStudent;
import com.example.service.SysClassService;
import com.example.service.SysStudentService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.util.List;

@Controller
@RequestMapping("/school/student")
public class SysStudentController {

    @Autowired
    private SysStudentService studentService;

    @Autowired
    private SysClassService classService;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String studentNo,
                       @RequestParam(required = false) String studentName,
                       Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysStudent> students;
        boolean hasSearch = (studentNo != null && !studentNo.isEmpty()) ||
                            (studentName != null && !studentName.isEmpty());
        if (hasSearch) {
            students = studentService.search(studentNo, studentName);
        } else {
            students = studentService.findAll();
        }
        model.addAttribute("students", students);
        model.addAttribute("studentNo", studentNo);
        model.addAttribute("studentName", studentName);
        return "school/student/list";
    }

    @GetMapping("/add")
    public String add(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        model.addAttribute("classes", classService.findAll());
        return "school/student/add";
    }

    @PostMapping("/save")
    public String save(SysStudent student, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (student.getStudentId() == null) {
            studentService.save(student);
        } else {
            studentService.update(student);
        }
        return "redirect:/school/student/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysStudent student = studentService.findById(id);
        model.addAttribute("student", student);
        model.addAttribute("classes", classService.findAll());
        return "school/student/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        studentService.deleteById(id);
        return "redirect:/school/student/list";
    }

    @GetMapping("/import")
    public String importPage(HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        return "school/student/import";
    }

    @PostMapping("/import")
    public String importStudents(@RequestParam("file") MultipartFile file, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (!file.isEmpty()) {
            studentService.importStudents(file);
        }
        return "redirect:/school/student/list";
    }

    @GetMapping("/template")
    public ResponseEntity<byte[]> downloadTemplate(HttpSession session) throws Exception {
        if (session.getAttribute("username") == null) {
            return null;
        }

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("学生导入模板");

        CellStyle headerStyle = workbook.createCellStyle();
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setColor(IndexedColors.WHITE.getIndex());
        headerStyle.setFont(headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.BLUE.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);

        Row headerRow = sheet.createRow(0);
        String[] headers = {"学号*", "姓名*", "性别*", "出生日期*", "班级ID*", "电话", "地址", "状态*"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        CellStyle noteStyle = workbook.createCellStyle();
        Font noteFont = workbook.createFont();
        noteFont.setColor(IndexedColors.RED.getIndex());
        noteStyle.setFont(noteFont);

        Row noteRow = sheet.createRow(1);
        Cell noteCell = noteRow.createCell(0);
        noteCell.setCellValue("说明：*为必填项。性别:1=男,2=女。状态:1=启用,0=禁用。班级ID请参考下方班级列表。");
        noteCell.setCellStyle(noteStyle);

        List<com.example.entity.SysClass> classes = classService.findAll();
        Row classRow = sheet.createRow(3);
        Cell classTitleCell = classRow.createCell(0);
        classTitleCell.setCellValue("班级列表参考：");
        classTitleCell.setCellStyle(noteStyle);

        Row classHeaderRow = sheet.createRow(4);
        classHeaderRow.createCell(0).setCellValue("班级ID");
        classHeaderRow.createCell(1).setCellValue("班级名称");
        classHeaderRow.createCell(2).setCellValue("年级");
        for (int i = 0; i < 3; i++) {
            classHeaderRow.getCell(i).setCellStyle(headerStyle);
        }

        int rowNum = 5;
        for (com.example.entity.SysClass clazz : classes) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(clazz.getClassId());
            row.createCell(1).setCellValue(clazz.getClassName());
            row.createCell(2).setCellValue(clazz.getGradeName() != null ? clazz.getGradeName() : "");
        }

        Row exampleRow = sheet.createRow(rowNum + 1);
        exampleRow.createCell(0).setCellValue("2024001");
        exampleRow.createCell(1).setCellValue("张三");
        exampleRow.createCell(2).setCellValue(1);
        exampleRow.createCell(3).setCellValue("2010-05-15");
        exampleRow.createCell(4).setCellValue(1);
        exampleRow.createCell(5).setCellValue("13800138000");
        exampleRow.createCell(6).setCellValue("北京市朝阳区");
        exampleRow.createCell(7).setCellValue(1);

        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        workbook.write(baos);
        workbook.close();

        HttpHeaders headers2 = new HttpHeaders();
        headers2.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers2.setContentDispositionFormData("attachment", "student_import_template.xlsx");

        return new ResponseEntity<>(baos.toByteArray(), headers2,
                org.springframework.http.HttpStatus.OK);
    }
}