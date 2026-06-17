package com.example.controller;

import com.example.entity.SysPost;
import com.example.service.SysPostService;
import com.example.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/system/post")
public class SysPostController {

    @Autowired
    private SysPostService postService;

    @Autowired
    private SysUserService userService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session,
                       @RequestParam(required = false) String postName,
                       @RequestParam(required = false) String postCode) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysPost> posts;
        if ((postName != null && !postName.isEmpty()) || (postCode != null && !postCode.isEmpty())) {
            posts = postService.search(postName, postCode);
        } else {
            posts = postService.findAll();
        }
        model.addAttribute("posts", posts);
        model.addAttribute("postName", postName);
        model.addAttribute("postCode", postCode);
        return "system/post/list";
    }

    @GetMapping("/add")
    public String add(HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        return "system/post/add";
    }

    @PostMapping("/save")
    public String save(SysPost post, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (post.getPostId() == null) {
            postService.save(post);
        } else {
            postService.update(post);
        }
        return "redirect:/system/post/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysPost post = postService.findById(id);
        model.addAttribute("post", post);
        return "system/post/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session, Model model) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        int userCount = userService.countByPostId(id);
        if (userCount > 0) {
            model.addAttribute("error", "该岗位已被 " + userCount + " 个用户使用，无法删除");
            List<SysPost> posts = postService.findAll();
            model.addAttribute("posts", posts);
            return "system/post/list";
        }
        postService.deleteById(id);
        return "redirect:/system/post/list";
    }
}