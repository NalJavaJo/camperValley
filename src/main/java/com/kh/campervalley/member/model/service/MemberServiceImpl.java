package com.kh.campervalley.member.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.member.model.dao.MemberDao;
import com.kh.campervalley.member.model.dto.Member;

import lombok.NonNull;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDao memberDao;

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertMember(Member member) {
		int result = memberDao.insertMember(member);
		Map<String, Object> map =  new HashMap<>();
		map.put("memberId", member.getMemberId());
		map.put("auth", MemberService.ROLE_USER);
		result = memberDao.insertAuthority(map);
		return result;
	}

	@Override
	public Member selectOneMember(Map<String, Object> map) {

		return memberDao.selectOneMember(map);
	}

	@Override
	public String selectIDByNameAndEmail(Map<String, Object> map) {
		return memberDao.selectIDByNameAndEmail(map);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int updatePassword(Map<String, Object> map) {
		return memberDao.updatePassword(map);
	}

	@Override
	public int withdrawal(@NonNull String memberId) {
		return memberDao.updateMemberWithdrawal(memberId);
	}
}
