package com.example.controller;

import com.example.entity.SysClass;
import com.example.entity.SysDept;
import com.example.entity.SysEquipment;
import com.example.service.SysClassService;
import com.example.service.SysDeptService;
import com.example.service.SysEquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/equipment")
public class SysEquipmentController {

    @Autowired
    private SysEquipmentService equipmentService;

    @Autowired
    private SysDeptService deptService;

    @Autowired
    private SysClassService classService;

    @GetMapping("/list")
    public String list(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        List<SysEquipment> equipments = equipmentService.findAll();
        model.addAttribute("equipments", equipments);
        return "equipment/list";
    }

    @GetMapping("/add")
    public String add(Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        model.addAttribute("depts", deptService.findAll());
        model.addAttribute("classes", classService.findAll());
        return "equipment/add";
    }

    @PostMapping("/save")
    public String save(SysEquipment equipment, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        if (equipment.getEquipmentId() == null) {
            equipmentService.save(equipment);
        } else {
            equipmentService.update(equipment);
        }
        return "redirect:/equipment/list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        SysEquipment equipment = equipmentService.findById(id);
        model.addAttribute("equipment", equipment);
        model.addAttribute("depts", deptService.findAll());
        model.addAttribute("classes", classService.findAll());
        return "equipment/edit";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        equipmentService.deleteById(id);
        return "redirect:/equipment/list";
    }

    @PostMapping("/updateStatus")
    @ResponseBody
    public String updateStatus(@RequestParam Integer equipmentId,
                               @RequestParam Integer status,
                               @RequestParam(required = false) String remark,
                               HttpSession session) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        equipmentService.updateStatus(equipmentId, status, remark);
        return "success";
    }
}
