package com.example.controller;

import com.example.entity.SysPermission;
import com.example.entity.SysRole;
import com.example.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/system/role")
public class SysRoleController {

    @Autowired
    private SysRoleService roleService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session,
                       @RequestParam(required = false) String roleName,
                       @RequestParam(required = false) String roleCode) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysRole> roles;
        if ((roleName != null && !roleName.isEmpty()) || (roleCode != null && !roleCode.isEmpty())) {
            roles = roleService.search(roleName, roleCode);
        } else {
            roles = roleService.findAll();
        }
        model.addAttribute("roles", roles);
        model.addAttribute("roleName", roleName);
        model.addAttribute("roleCode", roleCode);
        return "system/role/list";
    }

    @GetMapping("/add")
    public String add(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysPermission> permissions = roleService.findAllPermissions();
        model.addAttribute("permissions", permissions);
        return "system/role/add";
    }

    @PostMapping("/save")
    public String save(SysRole role,
                      @RequestParam(value = "permissionIds", required = false) List<Integer> permissionIds,
                      Model model,
                      HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        
        // 校验角色编码是否重复
        SysRole existingRole = roleService.findByCode(role.getRoleCode());
        if (existingRole != null && !existingRole.getRoleId().equals(role.getRoleId())) {
            model.addAttribute("error", "角色编码 '" + role.getRoleCode() + "' 已存在，请使用其他编码");
            model.addAttribute("role", role);
            model.addAttribute("permissions", roleService.findAllPermissions());
            if (role.getRoleId() == null) {
                return "system/role/add";
            } else {
                List<Integer> selectedPermissionIds = new ArrayList<>();
                if (permissionIds != null) {
                    selectedPermissionIds.addAll(permissionIds);
                }
                model.addAttribute("selectedPermissionIds", selectedPermissionIds);
                return "system/role/edit";
            }
        }
        
        if (role.getRoleId() == null) {
            roleService.save(role, permissionIds);
        } else {
            roleService.update(role, permissionIds);
        }
        return "redirect:/system/role/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysRole role = roleService.findById(id);
        List<SysPermission> permissions = roleService.findAllPermissions();
        model.addAttribute("role", role);
        model.addAttribute("permissions", permissions);

        List<Integer> selectedPermissionIds = new ArrayList<>();
        if (role.getPermissions() != null) {
            for (SysPermission p : role.getPermissions()) {
                selectedPermissionIds.add(p.getPermissionId());
            }
        }
        model.addAttribute("selectedPermissionIds", selectedPermissionIds);

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