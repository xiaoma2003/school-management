package com.example.controller;

import com.example.entity.SysRole;
import com.example.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/system/role")
public class SysRoleController {

    @Autowired
    private SysRoleService roleService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysRole> roles = roleService.findAll();
        model.addAttribute("roles", roles);
        return "system/role/list";
    }

    @GetMapping("/add")
    public String add(HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        return "system/role/add";
    }

    @PostMapping("/save")
    public String save(SysRole role, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (role.getRoleId() == null) {
            roleService.save(role);
        } else {
            roleService.update(role);
        }
        return "redirect:/system/role/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysRole role = roleService.findById(id);
        model.addAttribute("role", role);
        return "system/role/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        roleService.deleteById(id);
        return "redirect:/system/role/list";
    }
}