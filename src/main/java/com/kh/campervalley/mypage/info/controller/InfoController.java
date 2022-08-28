package com.kh.campervalley.mypage.info.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.common.CamperValleyUtils;
import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.review.model.dto.CampsiteReviewExt;
import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.member.model.service.MemberService;
import com.kh.campervalley.mypage.community.model.dto.CampsiteBookmarkExt;
import com.kh.campervalley.mypage.community.model.service.MypageCommunityService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage/info")
@Slf4j
public class InfoController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	private MypageCommunityService mypageCommunityService;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/edit")
	public void mypageUpdate(@AuthenticationPrincipal Member member) {
	}
	
	@PostMapping("/edit")
	public String mypageUpdate(Member updateMember,
								@AuthenticationPrincipal Member loginMember,
								@RequestParam("profileImgFile") MultipartFile upFile,
								@RequestParam("changeImg") String changeImg,
								RedirectAttributes redirectAttr) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		try {
			
			String saveDirectory = application.getRealPath("/resources/upload/member");
			
			if (upFile.getSize() > 0) {
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = CamperValleyUtils.getRenamedFilename(originalFilename);
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);

				updateMember.setProfileImg(renamedFilename);
				
			}
			if(loginMember.getProfileImg() != null && changeImg.equals("1")) {
				File delFile = new File(saveDirectory, loginMember.getProfileImg());
				if(delFile.exists()) {
					delFile.delete();
				}
			}
			
			
			if(updateMember.getPassword().equals(""))
				updateMember.setPassword(loginMember.getPassword());
			else
				updateMember.setPassword(bcryptPasswordEncoder.encode(updateMember.getPassword()));
			
			int result = memberService.updateMember(updateMember);
			loginMember.setNickname(updateMember.getNickname());
			loginMember.setPassword(updateMember.getPassword());
			loginMember.setEmail(updateMember.getEmail());
			loginMember.setTel(updateMember.getTel());
			if(changeImg.equals("1"))
				loginMember.setProfileImg(updateMember.getProfileImg());
			
			Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
					loginMember, loginMember.getPassword());
			
			redirectAttr.addFlashAttribute("msg", "회원정보가 성공적으로 수정되었습니다.");
		} catch (Exception e) {
			log.error("회원정보 수정 오류", e);
			throw e; 
		}
		return "redirect:/mypage/info/edit";
	}
	
	@GetMapping("/main")
	public ModelAndView mypageMain(@AuthenticationPrincipal Member member) {
		ModelAndView mav = new ModelAndView();
		
		try {
			List<CampsiteBookmarkExt> bookmarkList =  mypageCommunityService
													.selectCampsiteBookmark(member.getMemberId(), 0, 2);
			List<CampsiteReviewExt> reviewList = mypageCommunityService.selectMyReviewList(0,3,member.getMemberId());
			List<Camper> camperList = mypageCommunityService.selectMyCamperList(0,3,member.getMemberId());
			
			mav.addObject("bookmarkList", bookmarkList);
			mav.addObject("reviewList", reviewList);
			mav.addObject("camperList", camperList);
		} catch (Exception e) {
			log.error("마이페이지-메인 조회 오류", e);
			throw e; 
		}
		
		return mav;
	}
	
	@GetMapping("/withdrawal")
	public void withdrawal() {}
	
	@PostMapping("/withdrawal")
	public String withdrawal(RedirectAttributes redirectAttr, @AuthenticationPrincipal Member member) {
		String delDirectory = application.getRealPath("/resources/upload/member");
		try {
			if(member.getProfileImg()!= null) {
				File delFile = new File(delDirectory, member.getProfileImg());
				if(delFile.exists()) {
					delFile.delete();
				}
			}
			int result = memberService.withdrawal(member.getMemberId());
			SecurityContextHolder.clearContext();
			redirectAttr.addFlashAttribute("msg", "탈퇴 되었습니다.");
		} catch (Exception e) {
			log.error("회원탈퇴오류", e);
			throw e; 
		}
		
		return "redirect:/";
	}

}
