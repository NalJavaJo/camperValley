package com.kh.campervalley.chat.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campervalley.chat.model.dao.ChatDao;
import com.kh.campervalley.chat.model.dto.ChatLog;
import com.kh.campervalley.chat.model.dto.ChatMember;

@Transactional(rollbackFor = Exception.class)
@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	ChatDao chatDao;

	@Override
	public ChatMember findChatMemberByMemberId(Map<String, Object> map) {
		return chatDao.findChatMemberByMemberId(map);
	}
//
	@Override
	public int insertChatLog(Map<String, Object> payload) {
		return chatDao.insertChatLog(payload);
	}

	@Override
	public List<ChatLog> findChatLogByChatroomId(String chatroomId) {
		return chatDao.findChatLogByChatroomId(chatroomId);
	}

	@Override
	public int createChatroom(Map<String, Object> map) {
		int result = 0;
		
		result = chatDao.insertChatMember(map);
		
		return result;
	}
	@Override
	public List<ChatLog> findRecentChatLogList(Map<String, Object> map) {
		return chatDao.findRecentChatLogList(map);
	}
	@Override
	public int updateLastCheck(Map<String, Object> payload) {
		return chatDao.updateLastCheck(payload);
	}
	@Override
	public List<ChatMember> findChatMember(String memberId) {
		return chatDao.findChatMember(memberId);
	}
	
	@Override
	public Map<String, Integer> getTotalUnreadCnt(List<ChatMember> chatMemberList, String memberId) {

        Map<String, Integer> unreadCntMap = new HashMap<>();
        
    	int unreadCnt = 0;
		
		for(ChatMember chatMember : chatMemberList) {
		    if(chatMember.getSellerId().equals(memberId) ) {
		        unreadCnt = chatDao.getUnreadCntBySeller(chatMember);
		    }
		    else if( chatMember.getBuyerId().equals(memberId) ) {
		        unreadCnt = chatDao.getUnreadCntByBuyer(chatMember);
		    }
		    unreadCntMap.put(chatMember.getChatroomId(), unreadCnt);
		}
		
   		
        return unreadCntMap;
		
	}

}
