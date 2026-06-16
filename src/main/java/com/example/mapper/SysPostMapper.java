package com.example.mapper;

import com.example.entity.SysPost;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SysPostMapper {
    List<SysPost> findAll();
    SysPost findById(Integer postId);
    void insert(SysPost post);
    void update(SysPost post);
    void deleteById(Integer postId);
    int countByCode(String postCode);
}