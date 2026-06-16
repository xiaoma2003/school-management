package com.example.service.impl;

import com.example.entity.SysPost;
import com.example.mapper.SysPostMapper;
import com.example.service.SysPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysPostServiceImpl implements SysPostService {

    @Autowired
    private SysPostMapper postMapper;

    @Override
    public List<SysPost> findAll() {
        return postMapper.findAll();
    }

    @Override
    public List<SysPost> search(String postName, String postCode) {
        return postMapper.search(postName, postCode);
    }

    @Override
    public SysPost findById(Integer postId) {
        return postMapper.findById(postId);
    }

    @Override
    public void save(SysPost post) {
        postMapper.insert(post);
    }

    @Override
    public void update(SysPost post) {
        postMapper.update(post);
    }

    @Override
    public void deleteById(Integer postId) {
        postMapper.deleteById(postId);
    }

    @Override
    public boolean existsByCode(String postCode) {
        return postMapper.countByCode(postCode) > 0;
    }
}