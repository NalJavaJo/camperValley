package com.kh.campervalley.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.campervalley.chat.model.dto.ChatLog;
import com.kh.campervalley.chat.model.dto.ChatMember;

@Mapper
public interface ChatDao {

	int insertChatMember(Map<String, Object> map);

	@Select("select * from chat_member where seller_id in (#{sellerId}, #{buyerId}) and buyer_id in (#{sellerId}, #{buyerId})")
	ChatMember findChatMemberByMemberId(Map<String, Object> map);

	@Insert("insert into chat_log(no, chatroom_id, member_id, msg, time) values (seq_chat_log_no.nextval, #{chatroomId}, #{memberId}, #{msg}, #{time})")
	int insertChatLog(Map<String, Object> payload);

	@Select("select * from chat_log where chatroom_id = #{chatroomId} order by time")
	List<ChatLog> findChatLogByChatroomId(String chatroomId);

	List<ChatLog> findRecentChatLogList(Map<String, Object> map);

	@Update("update chat_member set buyer_last_check = #{lastCheck} where chatroom_id = #{chatroomId} and seller_id = #{sellerId} and buyer_id = #{buyerId}")
	int updateLastCheck(Map<String, Object> payload);

	@Select("select * from chat_member where seller_id = #{memberId} or buyer_id = #{memberId}")
	List<ChatMember> findChatMember(String memberId);

	int getUnreadCntBySeller(ChatMember chatMember);

	int getUnreadCntByBuyer(ChatMember chatMember);
}
