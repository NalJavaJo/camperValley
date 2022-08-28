package com.kh.campervalley.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campervalley.chat.model.dto.ChatLog;
import com.kh.campervalley.chat.model.dto.ChatMember;
import com.kh.campervalley.chat.model.service.ChatService;
import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.usedProduct.model.service.UsedProductService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	ChatService chatService;

	@Autowired
	UsedProductService usedProductService;

	@GetMapping("/chat")
	public void chat(@AuthenticationPrincipal Member member, @RequestParam("no") String no, Model model) {
		// seller, buyer 정보
		Member seller = usedProductService.getSellerInfo(Integer.parseInt(no));
		String sellerId = seller.getMemberId();
		String buyerId = member.getMemberId();
		String buyerImg = member.getProfileImg();

		Map<String, Object> map = new HashMap<>();
		map.put("sellerId", sellerId);
		map.put("buyerId", buyerId);
		map.put("buyerImg", buyerImg);

		ChatMember chatMember = chatService.findChatMemberByMemberId(map);

		log.debug("chatMember = {}", chatMember);

		String chatroomId = null;
		if (chatMember != null) {
			// 채팅방이 존재하는 경우

			chatroomId = chatMember.getChatroomId();

			log.debug("chatroomId = {}", chatroomId);

			// 채팅내역 가져오기
			List<ChatLog> chatLogList = chatService.findChatLogByChatroomId(chatroomId);
			log.debug("chatLogList = {}", chatLogList);
			model.addAttribute("chatLogList", chatLogList);

		} else {
				// 채팅방에 처음 입장한 경우
				// chatroomId생성
				chatroomId = getChatroomId();
				log.debug("chatroomId = {}", chatroomId);

				// 채팅방멤버 생성 (member, admin)
				ChatMember chatMemberList = new ChatMember();

				map.put("chatroomId", chatroomId);

				int result = chatService.createChatroom(map);

				log.debug("result = {}", result);
		}
		List<ChatLog> list = chatService.findRecentChatLogList(map);
		
        List<ChatMember> chatMemberList = chatService.findChatMember(buyerId);
        int totalUnreadCnt = 0;
        
        Map<String, Integer> unreadCntMap = null;
        if(chatMemberList.size() > 0) {
       	  unreadCntMap = chatService.getTotalUnreadCnt(chatMemberList, buyerId);
       	 
       	  for(ChatLog chatlog : list) {
       		 if(unreadCntMap.get(chatlog.getChatroomId()) != null) {
       			 chatlog.setUnreadCount(unreadCntMap.get(chatlog.getChatroomId()));
       		 }     		 
       	  }
       	 
        }
		log.debug("Recentlist = {}", list);

		model.addAttribute("list", list);

		log.debug("chatroomId = {}", chatroomId);
		model.addAttribute("chatroomId", chatroomId);
		model.addAttribute("sellerId", sellerId);
		log.debug("sellerId = {}", sellerId);
		model.addAttribute("no", no);

	}

	private String getChatroomId() {
		final int LEN = 8;
		Random rnd = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < LEN; i++) {
			if (rnd.nextBoolean()) {
				if (rnd.nextBoolean())
					sb.append((char) (rnd.nextInt(26) + 'A'));
				else
					sb.append((char) (rnd.nextInt(26) + 'a'));
			} else {
				sb.append(rnd.nextInt(10));
			}
		}
		return sb.toString();
	}

    /**
     * 로그인 성공시 후처리
     */
    @PostMapping("/loginSuccess")
    public String loginSuccess(@AuthenticationPrincipal Member member, HttpSession session, Model model) {
        log.debug("loginSuccess");
        

        
        // 관리자가 아닌경우에만 안읽은 메세지 수 체크
//        List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) member.getAuthorities();
//        if(!authorities.contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
            // 관리자와의 1:1채팅 안읽은 메세지 카운팅
            String memberId = member.getMemberId();
            
//            ChatMember chatMember = chatService.findChatMemberByMember(memberId);
             List<ChatMember> chatMemberList = chatService.findChatMember(memberId);
             int totalUnreadCnt = 0;
             
             Map<String, Integer> unreadCntMap = null;
             if(chatMemberList.size() > 0) {
            	 unreadCntMap = chatService.getTotalUnreadCnt(chatMemberList, memberId);
             
            	 for(String key : unreadCntMap.keySet()) {
            		 log.debug("key = {}", key);
            		 log.debug("value = {}", unreadCntMap.get(key));
            		 totalUnreadCnt += unreadCntMap.get(key);
            	 }
             }
             log.debug("totalUnreadCnt = {}", totalUnreadCnt);
             
//            int unreadCount = 0;
//            if(chatMember != null) {
//                unreadCount = chatService.getUnreadCount(chatMember);
//                // 세션스코프에 저장 (리다이렉트이기때문)
//                session.setAttribute("unreadCount", unreadCount);
//            }
//            log.debug("unreadCount = {}", unreadCount);
////        }
        
        // security redirect 사용하기
        SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
        String location = "/";
        if (savedRequest != null)
            location = savedRequest.getRedirectUrl();

        log.debug("location = {}", location);

        return "redirect:" + location;
    }
    

}
