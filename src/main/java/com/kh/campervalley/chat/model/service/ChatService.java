package com.kh.campervalley.chat.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campervalley.chat.model.dto.ChatLog;
import com.kh.campervalley.chat.model.dto.ChatMember;

public interface ChatService {
//
//	List<ChatMember> findChatMemberByMemberId(String buyerId);
//
	int insertChatLog(Map<String, Object> payload);

	ChatMember findChatMemberByMemberId(Map<String, Object> map);

	int createChatroom(Map<String, Object> map);

	List<ChatLog> findChatLogByChatroomId(String chatroomId);

	List<ChatLog> findRecentChatLogList(Map<String, Object> map);

	int updateLastCheck(Map<String, Object> payload);

	List<ChatMember> findChatMember(String memberId);

	Map<String, Integer> getTotalUnreadCnt(List<ChatMember> chatMemberList, String memberId);

	

}
