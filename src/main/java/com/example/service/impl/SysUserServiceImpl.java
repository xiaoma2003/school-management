package com.example.service.impl;

import com.example.entity.SysUser;
import com.example.mapper.SysUserMapper;
import com.example.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@Service
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private SysUserMapper userMapper;

    @Override
    public List<SysUser> findAll() {
        return userMapper.findAll();
    }

    @Override
    public SysUser findById(Integer userId) {
        return userMapper.findById(userId);
    }

    @Override
    public SysUser findByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public void save(SysUser user) {
        user.setPassword(MD5(user.getPassword()));
        userMapper.insert(user);
    }

    @Override
    public void update(SysUser user) {
        userMapper.update(user);
    }

    @Override
    public void deleteById(Integer userId) {
        userMapper.deleteById(userId);
    }

    @Override
    public boolean existsByUsername(String username) {
        return userMapper.countByUsername(username) > 0;
    }

    @Override
    public boolean login(String username, String password) {
        SysUser user = userMapper.findByUsername(username);
        if (user != null && user.getStatus() == 1) {
            return user.getPassword().equals(MD5(password));
        }
        return false;
    }

    private String MD5(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(str.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            return str;
        }
    }
}