package com.kh.campervalley.member.model.service;

import java.util.Map;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.member.model.dto.Member;

import lombok.NonNull;

public interface MemberService{
	public static final String ROLE_USER = "ROLE_USER";
	public static final String ROLE_BLACK = "ROLE_BLACK";
	public static final String ROLE_ADMIN = "ROLE_ADMIN";
	int insertMember(Member member);
	Member selectOneMember(Map<String, Object> map);
	String selectIDByNameAndEmail(Map<String, Object> map);
	int updateMember(Member member);
	int updatePassword(Map<String, Object> map);
	int withdrawal(@NonNull String memberId);
}
