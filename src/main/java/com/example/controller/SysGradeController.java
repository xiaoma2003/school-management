package com.example.controller;

import com.example.entity.SysGrade;
import com.example.service.SysGradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/school/grade")
public class SysGradeController {

    @Autowired
    private SysGradeService gradeService;

    @Autowired
    private com.example.service.SysClassService classService;

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String gradeName,
                       @RequestParam(required = false) String remark,
                       Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysGrade> grades;
        boolean hasSearch = (gradeName != null && !gradeName.isEmpty()) ||
                            (remark != null && !remark.isEmpty());
        if (hasSearch) {
            grades = gradeService.search(gradeName, remark);
        } else {
            grades = gradeService.findAll();
        }
        model.addAttribute("grades", grades);
        model.addAttribute("gradeName", gradeName);
        model.addAttribute("remark", remark);
        return "school/grade/list";
    }

    @GetMapping("/add")
    public String add(HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        return "school/grade/add";
    }

    @PostMapping("/save")
    public String save(SysGrade grade, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (grade.getGradeId() == null) {
            gradeService.save(grade);
        } else {
            gradeService.update(grade);
        }
        return "redirect:/school/grade/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysGrade grade = gradeService.findById(id);
        model.addAttribute("grade", grade);
        return "school/grade/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session, Model model) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        int classCount = classService.countByGradeId(id);
        if (classCount > 0) {
            model.addAttribute("error", "该年级下有 " + classCount + " 个班级，无法删除");
            model.addAttribute("grades", gradeService.findAll());
            return "school/grade/list";
        }
        gradeService.deleteById(id);
        return "redirect:/school/grade/list";
    }
}