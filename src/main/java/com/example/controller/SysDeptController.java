package com.example.controller;

import com.example.entity.SysDept;
import com.example.service.SysDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/system/dept")
public class SysDeptController {

    @Autowired
    private SysDeptService deptService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session,
                       @RequestParam(required = false) String deptName,
                       @RequestParam(required = false) String deptCode) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysDept> depts;
        if ((deptName != null && !deptName.isEmpty()) || (deptCode != null && !deptCode.isEmpty())) {
            depts = deptService.search(deptName, deptCode);
        } else {
            depts = deptService.findAll();
        }
        model.addAttribute("depts", depts);
        model.addAttribute("deptName", deptName);
        model.addAttribute("deptCode", deptCode);
        return "system/dept/list";
    }

    @GetMapping("/add")
    public String add(HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        return "system/dept/add";
    }

    @PostMapping("/save")
    public String save(SysDept dept, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (dept.getDeptId() == null) {
            deptService.save(dept);
        } else {
            deptService.update(dept);
        }
        return "redirect:/system/dept/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysDept dept = deptService.findById(id);
        model.addAttribute("dept", dept);
        return "system/dept/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        deptService.deleteById(id);
        return "redirect:/system/dept/list";
    }
}