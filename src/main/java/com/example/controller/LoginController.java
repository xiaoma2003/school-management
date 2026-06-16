package com.example.controller;

import com.example.entity.SysPermission;
import com.example.entity.SysRole;
import com.example.entity.SysUser;
import com.example.service.SysRoleService;
import com.example.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class LoginController {

    @Autowired
    private SysUserService userService;

    @Autowired
    private SysRoleService roleService;

    @GetMapping("/")
    public String index() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username, @RequestParam String password,
                         HttpSession session) {
        if (userService.login(username, password)) {
            session.setAttribute("username", username);

            SysUser user = userService.findByUsername(username);
            if (user != null && user.getRoleId() != null) {
                SysRole role = roleService.findById(user.getRoleId());
                if (role != null && role.getPermissions() != null) {
                    Set<String> permissionCodes = new HashSet<>();
                    for (SysPermission p : role.getPermissions()) {
                        permissionCodes.add(p.getPermissionCode());
                    }
                    session.setAttribute("permissionCodes", permissionCodes);
                    session.setAttribute("roleName", role.getRoleName());
                }
            }
            return "redirect:/main";
        }
        return "redirect:/login?error=1";
    }

    @GetMapping("/main")
    public String main(HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        return "main";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}