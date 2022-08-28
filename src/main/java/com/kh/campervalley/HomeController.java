package com.kh.campervalley;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.mypage.advertiser.model.dto.AdZone;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertisementExt;
import com.kh.campervalley.mypage.advertiser.model.service.AdvertiserService;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	@Autowired
	private AdvertiserService advertiserService;
	
	@GetMapping("/")
	public ModelAndView index(HttpServletRequest request, ModelAndView mav, @AuthenticationPrincipal Member loginMember) {
		log.debug("GET / 요청!");
		Map<String, Object> param = new HashMap<>();
		try {
			HttpSession session = request.getSession();
			if(loginMember != null) {
				boolean isPauseAdvertiser = advertiserService.isPauseAdvertiser(loginMember.getMemberId());
				boolean isAdvertiser = advertiserService.isAdvertiser(loginMember.getMemberId());
				log.debug("isPauseAdvertiser = {}", isPauseAdvertiser);
				log.debug("isAdvertiser = {}", isAdvertiser);
				
				// 권한정지광고주 true, 권한보유 광고주 false
				session.setAttribute("isPauseAdvertiser", isPauseAdvertiser);
				session.setAttribute("isAdvertiser", isAdvertiser);
			}
			
			List<AdvertisementExt> adList = advertiserService.getDisplayAdList(3, AdZone.mainHome);
			//log.debug("adList = {}", adList);

			mav.addObject("adList", adList);
			mav.setViewName("index");
		} catch(Exception e) {
			log.error("홈페이지 로드 오류", e);
			throw e;
		}
		return mav;
	}
	
}
