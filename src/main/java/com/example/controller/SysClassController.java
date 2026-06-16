package com.example.controller;

import com.example.entity.SysClass;
import com.example.service.SysClassService;
import com.example.service.SysGradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/school/class")
public class SysClassController {

    @Autowired
    private SysClassService classService;

    @Autowired
    private SysGradeService gradeService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysClass> classes = classService.findAll();
        model.addAttribute("classes", classes);
        return "school/class/list";
    }

    @GetMapping("/add")
    public String add(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        model.addAttribute("grades", gradeService.findAll());
        return "school/class/add";
    }

    @PostMapping("/save")
    public String save(SysClass clazz, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (clazz.getClassId() == null) {
            classService.save(clazz);
        } else {
            classService.update(clazz);
        }
        return "redirect:/school/class/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysClass clazz = classService.findById(id);
        model.addAttribute("clazz", clazz);
        model.addAttribute("grades", gradeService.findAll());
        return "school/class/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        classService.deleteById(id);
        return "redirect:/school/class/list";
    }
}