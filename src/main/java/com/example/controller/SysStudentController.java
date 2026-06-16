package com.example.controller;

import com.example.entity.SysStudent;
import com.example.service.SysClassService;
import com.example.service.SysStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
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
}