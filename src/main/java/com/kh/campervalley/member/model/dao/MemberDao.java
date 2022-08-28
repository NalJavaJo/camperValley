package com.kh.campervalley.member.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.campervalley.member.model.dto.Member;

import lombok.NonNull;

@Mapper
public interface MemberDao {

	int insertMember(Member member);

	int insertAuthority(Map map);

	Member selectOneMember(Map map);

	String selectIDByNameAndEmail(Map<String, Object> map);

	int updateMember(Member member);

	int updatePassword(Map<String, Object> map);

	int updateMemberWithdrawal(@NonNull String memberId);

}
