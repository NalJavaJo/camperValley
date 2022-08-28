package com.kh.security.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.campervalley.member.model.dto.Member;

@Mapper
public interface SecurityDao {
	
	Member loadUserByUsername(String username);
	
}
