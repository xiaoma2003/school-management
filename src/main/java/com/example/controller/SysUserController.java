package com.example.controller;

import com.example.entity.SysUser;
import com.example.service.SysDeptService;
import com.example.service.SysPostService;
import com.example.service.SysRoleService;
import com.example.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/system/user")
public class SysUserController {

    @Autowired
    private SysUserService userService;

    @Autowired
    private SysDeptService deptService;

    @Autowired
    private SysPostService postService;

    @Autowired
    private SysRoleService roleService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysUser> users = userService.findAll();
        model.addAttribute("users", users);
        return "system/user/list";
    }

    @GetMapping("/add")
    public String add(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        model.addAttribute("depts", deptService.findAll());
        model.addAttribute("posts", postService.findAll());
        model.addAttribute("roles", roleService.findAll());
        return "system/user/add";
    }

    @PostMapping("/save")
    public String save(SysUser user, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (user.getUserId() == null) {
            userService.save(user);
        } else {
            userService.update(user);
        }
        return "redirect:/system/user/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysUser user = userService.findById(id);
        model.addAttribute("user", user);
        model.addAttribute("depts", deptService.findAll());
        model.addAttribute("posts", postService.findAll());
        model.addAttribute("roles", roleService.findAll());
        return "system/user/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        userService.deleteById(id);
        return "redirect:/system/user/list";
    }
}