package com.kh.campervalley.mypage.community.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.common.CamperValleyUtils;
import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.service.CamperService;
import com.kh.campervalley.community.review.model.dto.CampsiteReviewExt;
import com.kh.campervalley.community.review.model.dto.ReviewPhoto;
import com.kh.campervalley.community.review.model.service.ReviewService;
import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.mypage.community.model.dto.CampsiteBookmarkExt;
import com.kh.campervalley.mypage.community.model.service.MypageCommunityService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage/community")
@Slf4j
public class MypageCommunityController {
	
	@Autowired
	private MypageCommunityService mypageCommunityService;
	
	@Autowired
	private CamperService camperService;
	
	@Autowired
	private ReviewService reviewService;

	@Autowired
	ServletContext application;
	

	
	// --------------------- EJ start
	@GetMapping("/bookmark")
	public ModelAndView bookmarkList(ModelAndView mav, @AuthenticationPrincipal Member loginMember, 
			@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request) {
		
		try {
			int numPerPage = MypageCommunityService.MY_BOOKMARK_NUM_PER_PAGE;
			String url = request.getRequestURI();
			
			String memberId = loginMember.getMemberId();
			List<CampsiteBookmarkExt> bookmarkList =  mypageCommunityService.selectCampsiteBookmark(memberId, cPage, numPerPage);
			// log.debug("bookmarkList = {}", bookmarkList);
			
			int totalBookmark = mypageCommunityService.getTotalCampsiteBookmark(memberId);
			String pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalBookmark, url);

			mav.addObject("pagebar", pagebar);
			mav.addObject("bookmarkList", bookmarkList);
		} catch (Exception e) {
			log.error("관심캠핑장 조회 오류", e);
			throw e;
		}
		return mav;
		
	}
	// --------------------- EJ end
	// --------------------- JE start
	@GetMapping("/myReview")
	public ModelAndView searchId(@RequestParam(defaultValue = "1") int cPage,
				@RequestParam(required = false) String searchOption,
				@RequestParam(required = false) String searchKeyword, 
				@AuthenticationPrincipal Member member ,ModelAndView mav, HttpServletRequest request) throws Exception {
		
		try {
			int numPerPage = MypageCommunityService.MY_REVIEW_NUM_PER_PAGE;
			List<CampsiteReviewExt> list = null;
			int totalContent;
			String url = request.getRequestURI();
			String pagebar = "";
			if(searchOption == null && searchKeyword == null) {
				list = mypageCommunityService.selectMyReviewList(
											cPage, numPerPage, member.getMemberId());
				totalContent = mypageCommunityService.selectTotalMyReview(member.getMemberId());
				pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalContent, url);
			} else if(searchOption != null && searchKeyword != null) {
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", member.getMemberId());
				map.put("searchOption", searchOption);
				map.put("searchKeyword", searchKeyword);
				url += "?searchOption=" + searchOption + "&searchKeyword=" + searchKeyword;
				list = mypageCommunityService.searchMyReviewList(
						cPage, numPerPage, map);
				totalContent = mypageCommunityService.searchTotalMyReview(map);
				pagebar = CamperValleyUtils.getMultiParamPagebar(cPage, numPerPage, totalContent, url);
			}		
			mav.addObject("list", list);
			mav.addObject("member", member);
			mav.addObject("pagebar", pagebar);
			mav.setViewName("mypage/community/myReview");
		} catch (Exception e) {
			log.error("마이페이지-작성후기 목록조회 오류",e);
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/myCamper")
	public ModelAndView myCamperList(@RequestParam(defaultValue = "1") int cPage,
				@RequestParam(required = false) String searchOption,
				@RequestParam(required = false) String searchKeyword, 
				@AuthenticationPrincipal Member member ,ModelAndView mav, HttpServletRequest request)  throws Exception{
		
		try {
			int numPerPage = MypageCommunityService.MY_CAMPER_NUM_PER_PAGE;
			List<Camper> list = null;
			int totalContent;
			String url = request.getRequestURI();
			String pagebar = "";

			if(searchOption == null && searchKeyword == null) {
				
				list = mypageCommunityService.selectMyCamperList(
											cPage, numPerPage, member.getMemberId());
				totalContent = mypageCommunityService.selectTotalMyCamper(member.getMemberId());
				pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalContent, url);
				
			} else if(searchOption != null && searchKeyword != null) {
				
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", member.getMemberId());
				map.put("searchOption", searchOption);
				map.put("searchKeyword", searchKeyword);
				url += "?searchOption=" + searchOption + "&searchKeyword=" + searchKeyword;
				list = mypageCommunityService.searchMyCamperList(
										cPage, numPerPage, map);
				totalContent = mypageCommunityService.searchTotalMyCamper(map);
				pagebar = CamperValleyUtils.getMultiParamPagebar(cPage, numPerPage, totalContent, url);
				
			}
			
			mav.addObject("list", list);
			mav.addObject("member", member);
			mav.addObject("pagebar", pagebar);
			mav.setViewName("mypage/community/myCamper");
			
		} catch (Exception e) {
			log.error("마이페이지-캠퍼모집글 목록조회 오류",e);
			throw e;
		}
		return mav;
	}
	
	@PostMapping("/myCamper/status/update")
	public ResponseEntity<?> camperDetail(Camper camper) {
		
		Map<String, Object> map = new HashMap<>();
		try {
			
			int result = mypageCommunityService.updateCamperStatusByCamperNo(camper);
			map.put("msg", "모집상태 변경에 성공했습니다.");
			
		} catch(Exception e) {
			log.error("캠퍼모집 상태 업데이트 오류", e);
			map.put("error", e.getMessage());

			return ResponseEntity
					.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
					.body(map);
		} 
		
		return ResponseEntity
				.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE)
				.body(map);
		
	}
	
	@PostMapping("/myCamper/camperUpdate") 
	public String camperUpdate(Camper camper, RedirectAttributes redirectAttr,
				@RequestHeader(name = "Referer", required = false) String referer) throws Exception{
		
		try {
			int result = camperService.updateCamper(camper);
			redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 수정했습니다.");
		} catch(Exception e) {
			log.error("캠퍼모집 수정 오류", e);
			throw e;
		}
		return "redirect:/mypage/community/myCamper";
	}
	
	@PostMapping("/myReview/delete")
	public String reviewDelete(
			@RequestParam int reviewNo, 
			RedirectAttributes redirectAttr) throws Exception{
		
		try {
			String delDirectory = application.getRealPath("/resources/upload/community/review");
			List<ReviewPhoto> photos = reviewService.selectOneReview(reviewNo).getPhotos();

			if(photos != null && !photos.isEmpty() && photos.get(0).getRenamedFilename() != null) {
				for(ReviewPhoto photo : photos) {
					File delFile = new File(delDirectory, photo.getRenamedFilename());
					if(delFile.exists()) {
						delFile.delete();
					}
				}
			}
			
			int result = reviewService.deleteReview(reviewNo);
			redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 삭제했습니다.");
		} catch (Exception e) {
			log.error("후기 삭제 오류", e);
			throw e;
		}
		return "redirect:/mypage/community/myReview";
	}
	
	@PostMapping("/myCamper/delete")
	public String camperDelete(
			@RequestParam int camperNo, 
			RedirectAttributes redirectAttr) {
		
		try {
			int result = camperService.deleteCamper(camperNo);
			redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 삭제했습니다.");
		} catch(Exception e) {
			log.error("캠퍼모집글 삭제 오류", e);
			throw e;
		}
		return "redirect:/mypage/community/myCamper";
	}
	
	// --------------------- JE end
}
