package com.example.service;

import com.example.entity.SysPost;

import java.util.List;

public interface SysPostService {
    List<SysPost> findAll();
    SysPost findById(Integer postId);
    void save(SysPost post);
    void update(SysPost post);
    void deleteById(Integer postId);
    boolean existsByCode(String postCode);
}