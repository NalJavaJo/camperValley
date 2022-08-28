package com.kh.campervalley.admin.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.admin.model.dto.Todo;
import com.kh.campervalley.admin.model.service.AdminService;
import com.kh.campervalley.common.CamperValleyUtils;
import com.kh.campervalley.cs.model.dto.NoticeExt;
import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertiserExt;
import com.kh.campervalley.mypage.advertiser.model.dto.LicenseFile;
import com.kh.campervalley.mypage.advertiser.model.service.AdvertiserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ServletContext application;

	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/reportManagement")
	public ModelAndView reportManagement(ModelAndView mav,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request) {
		try {
			int numPerPage = 10;
			int offset = (cPage - 1) * numPerPage;
			
			Map<String, Object> map = new HashMap<>();
			map.put("numPerPage", numPerPage);
			map.put("offset", offset);
			
			List<Member> list = adminService.selectReportList(map);
			int totalContent = adminService.selectTotalReportList(map);
			log.debug("list = {}", list);
			
			String url = request.getRequestURI();
			String pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalContent, url);
			
			mav.addObject("list", list);
			mav.addObject("map", map);
			mav.addObject("pagebar", pagebar);
			
			mav.setViewName("admin/reportManagement");
		} catch (Exception e) {
			log.error("신고 관리 오류", e);
			throw e;
		}
		
		return mav;
	}

	@GetMapping("/memberList")
	public ModelAndView memberList(ModelAndView mav,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request) {
		try {
			
			int numPerPage = 10;
			int offset = (cPage - 1) * numPerPage;
			
			Map<String, Object> map = new HashMap<>();
			map.put("searchKeyword", searchKeyword);
			map.put("numPerPage", numPerPage);
			map.put("offset", offset);
			
			List<Member> list = adminService.selectMemberList(map);
			int totalContent = adminService.selectTotalMemberList(map);
			log.debug("list = {}", list);
			
			String url = request.getRequestURI();
			String pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalContent, url);
			log.debug("map = {}" + map);
			
			mav.addObject("list", list);
			mav.addObject("map", map);
			mav.addObject("pagebar", pagebar);
			
			mav.setViewName("admin/memberList");
		} catch (Exception e) {
			log.error("회원 관리 오류", e);
			throw e;
		}
		return mav;
	}
	
	@PostMapping("/memberUpdate")
	public String memberUpdate(Member member, RedirectAttributes redirectAttr, 
			@RequestParam(required = false) boolean ROLE_ADMIN, 
			@RequestParam(required = false) boolean ROLE_BLACK) {
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("ROLE_ADMIN", ROLE_ADMIN);
			map.put("ROLE_BLACK", ROLE_BLACK);
			map.put("memberId", member.getMemberId());
			
			adminService.updateMemberRole(map);
			
			int result = adminService.memberUpdate(member);
			redirectAttr.addFlashAttribute("msg", "회원 정보가 수정되었습니다.");
		} catch (Exception e) {
			log.error("회원 정보 수정 오류", e);
		}
		return "redirect:/admin/memberList";
	}
	
	@PostMapping("/updateBuyerBlack")
	public String insertBuyerBlack(Member member,
			RedirectAttributes redirectAttr, 
			@RequestParam(required = false) boolean ROLE_BLACK, @RequestParam int reportNo) {
		
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("ROLE_BLACK", ROLE_BLACK);
			map.put("memberId", member.getMemberId());
			
			adminService.updateBuyerBlack(map);
			
			int result = adminService.updateReport(reportNo);
			redirectAttr.addFlashAttribute("msg", "신고가 처리되었습니다.");
		} catch (Exception e) {
			log.error("신고 처리 오류", e);
		}

		return "redirect:/admin/reportManagement";
	}
	
	
	
	// --------------------- EJ start
	@Autowired
	private AdvertiserService advertiserService;
	
	@GetMapping("/advertiser")
	public ModelAndView advertiser(@RequestParam Map<String, Object> param, @RequestParam(defaultValue = "1") int cPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			int numPerPage = AdvertiserService.ADVERTISER_NUM_PER_PAGE;

			List<AdvertiserExt> list = null;
			int totalAdvertiser = 0;
			String url = request.getRequestURI();
			String pagebar = "";
			if (param.isEmpty()) {
				list = advertiserService.selectAdvertiserList(cPage, numPerPage);
				totalAdvertiser = advertiserService.selectTotalAdvertiser();
				pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalAdvertiser, url);
			} else {
				String tail = "?" + param.toString().replaceAll(", ", "&").replace("{", "").replace("}", "");
				list = advertiserService.selectAdvertiserFilteredList(param, cPage, numPerPage);
				totalAdvertiser = advertiserService.selectFilteredTotalAdvertiser(param);
				pagebar = CamperValleyUtils.getMultiParamPagebar(cPage, numPerPage, totalAdvertiser, url + tail);
			}

			mav.addObject("list", list);
			mav.addObject("pagebar", pagebar);
			mav.setViewName("admin/advertiser");
		} catch (Exception e) {
			log.error("광고주목록 조회 오류", e);
			throw e;
		}
		return mav;
	}

	@GetMapping("/advertiser/fileDownload")
	@ResponseBody
	public Resource licenseFileDownload(@RequestParam int no, HttpServletResponse response) throws Exception {
		Resource resource = null;
		try {
			LicenseFile license = advertiserService.selectOneLicenseFile(no);

			String saveDirectory = application.getRealPath("/resources/upload/mypage/advertiser/license");
			File downFile = new File(saveDirectory, license.getRenamedFilename());

			String location = "file:" + downFile;
			resource = resourceLoader.getResource(location);

			String filename = URLEncoder.encode(license.getOriginalFilename(), "utf-8");
			response.addHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"");

		} catch (Exception e) {
			log.error("사업자등록증 다운로드 오류", e);
			throw e;
		}
		return resource;
	}

	@PostMapping("/advertiser/updateRole")
	public ResponseEntity<?> updateAdvertiserStatus(@RequestParam int advertiserNo, @RequestParam String memberId, @RequestParam String actionType) {
		Map<String, Object> map = new HashMap<>();

		int result = 0;
		try {
			if (actionType.equals("PERMISSION")) {
				result = advertiserService.updateAdvertiserPermission(advertiserNo, memberId);
				map.put("msg", "광고주 승인상태 변경 완료");
			} else {
				result = advertiserService.updateAdvertiserPause(advertiserNo, memberId);
				map.put("msg", "광고주 권한 정지");
			}
		} catch (Exception e) {
			log.error("광고주 승인상태 변경 오류", e);
			map.put("msg", "광고주 승인상태 변경 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}

		return ResponseEntity.ok(map);
	}
	// --------------------- EJ end

	@GetMapping("/usedProductManagement")
	public ModelAndView usedProductManagement(ModelAndView mav, 
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request) {
		try {
			int numPerPage = 10;
			int offset = (cPage - 1) * numPerPage;
			
			Map<String, Object> map = new HashMap<>();
			map.put("searchType", searchType);
			map.put("searchKeyword", searchKeyword);
			map.put("numPerPage", numPerPage);
			map.put("offset", offset);
			
			List<NoticeExt> list = adminService.selectProductList(map);
			int totalContent = adminService.selectTotalProductList(map);
			log.debug("list = {}", list);
			
			String url = request.getRequestURI();
			String pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalContent, url);
			log.debug("map = {}" + map);
			
			mav.addObject("list", list);
			mav.addObject("map", map);
			mav.addObject("pagebar", pagebar);
			
			mav.setViewName("admin/usedProductManagement");
		} catch (Exception e) {
			log.error("캠핑용품거래목록 조회 오류", e);
		}
		return mav;
	}
	

	@GetMapping("/camperManagement")
	public ModelAndView camperManagement(ModelAndView mav, 
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request) {
		try {
			int numPerPage = 10;
			int offset = (cPage - 1) * numPerPage;
			
			Map<String, Object> map = new HashMap<>();
			map.put("searchType", searchType);
			map.put("searchKeyword", searchKeyword);
			map.put("numPerPage", numPerPage);
			map.put("offset", offset);
			
			List<NoticeExt> list = adminService.selectCamperList(map);
			int totalContent = adminService.selectTotalCamperList(map);
			log.debug("list = {}", list);
			
			String url = request.getRequestURI();
			String pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalContent, url);
			log.debug("map = {}" + map);
			
			mav.addObject("list", list);
			mav.addObject("map", map);
			mav.addObject("pagebar", pagebar);
			
			mav.setViewName("admin/camperManagement");
		} catch (Exception e) {
			log.error("캠퍼모집 목록 조회 오류", e);
		}
		return mav;
	}
	
	@GetMapping("/reviewManagement")
	public ModelAndView reviewManagement(ModelAndView mav, 
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request) {
		try {
			int numPerPage = 10;
			int offset = (cPage - 1) * numPerPage;
			
			Map<String, Object> map = new HashMap<>();
			map.put("searchType", searchType);
			map.put("searchKeyword", searchKeyword);
			map.put("numPerPage", numPerPage);
			map.put("offset", offset);
			
			List<NoticeExt> list = adminService.selectReviewList(map);
			int totalContent = adminService.selectTotalReviewList(map);
			log.debug("list = {}", list);
			
			String url = request.getRequestURI();
			String pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalContent, url);
			log.debug("map = {}" + map);
			
			mav.addObject("list", list);
			mav.addObject("map", map);
			mav.addObject("pagebar", pagebar);
			
			mav.setViewName("admin/reviewManagement");
		} catch (Exception e) {
			log.error("캠핑장후기 목록 조회 오류", e);
		}
		return mav;
	}
	
	@PostMapping("/usedProductDelete")
	public String usedProductDelete(@RequestParam("deleteList") List<Integer> usedProductNo, RedirectAttributes redirectAttr) {
		try {
			for (Integer productNo : usedProductNo) adminService.productDelete(productNo);
			redirectAttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		} catch (Exception e) {
			log.error("중고거래 삭제 오류", e);
		}
		return "redirect:/admin/usedProductManagement";
	}
	
	@PostMapping("/camperDelete")
	public String camperDelete(@RequestParam("deleteList") List<Integer> camperBoardNo, RedirectAttributes redirectAttr) {
		try {
			for (Integer camperNo : camperBoardNo) adminService.camperDelete(camperNo);
			redirectAttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		} catch (Exception e) {
			log.error("캠퍼모집 삭제 오류", e);
		}
		return "redirect:/admin/camperManagement";
	}
	
	@PostMapping("/reviewDelete")
	public String reviewDelete(@RequestParam("deleteList") List<Integer> reviewBoardNo, RedirectAttributes redirectAttr) {
		try {
			for (Integer reviewNo : reviewBoardNo) adminService.reviewDelete(reviewNo);
			redirectAttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		} catch (Exception e) {
			log.error("캠퍼모집 삭제 오류", e);
		}
		return "redirect:/admin/reviewManagement";
	}

	
	@GetMapping("/dashboard")
	public ModelAndView dashboard(ModelAndView mav) {
		try {
			List<NoticeExt> list = adminService.selectNoticeList();
			
			List<Todo> todo = adminService.selectTodoList();
			
			mav.addObject("list", list);
			mav.addObject("todo", todo);
			
			mav.addObject("camper", adminService.todayCamper());
			mav.addObject("review", adminService.todayReview());
			mav.addObject("product", adminService.todayProduct());
			
			mav.addObject("sysdate", adminService.sysdate());
			mav.addObject("minus1", adminService.minus1());
			mav.addObject("minus2", adminService.minus2());
			mav.addObject("minus3", adminService.minus3());
			mav.addObject("minus4", adminService.minus4());
			mav.addObject("minus5", adminService.minus5());
			mav.addObject("minus6", adminService.minus6());
			
			mav.addObject("adSysdate", adminService.adSysdate());
			mav.addObject("adMinus1", adminService.adMinus1());
			mav.addObject("adMinus2", adminService.adMinus2());
			mav.addObject("adMinus3", adminService.adMinus3());
			mav.addObject("adMinus4", adminService.adMinus4());
			mav.addObject("adMinus5", adminService.adMinus5());
		} catch (Exception e) {
			log.error("관리자 대시보드 조회 오류", e);
		}
		return mav;
	}
	
	@PostMapping("/insertTodo")
	public String insertTodo(Todo todo) {
		try {
			int result = adminService.insertTodo(todo);
			
		} catch (Exception e) {
			log.error("todoList 등록 오류", e);
			throw e;
		}
		return "redirect:/admin/dashboard";
	}
	
	@PostMapping("/updateTodo")
	public String updateTodo(@RequestParam int todoNo, @RequestParam boolean isCompleted) {
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("todoNo", todoNo);
			param.put("isCompleted", isCompleted);
			
			int result = adminService.updateTodo(param); 
			
		} catch (Exception e) {
			log.error("todoList 수정 오류", e);
			throw e;
		}
		
		return "redirect:/admin/dashboard";
	}
	
	@PostMapping("/deleteTodo")
	public String deleteTodo(@RequestParam int todoNo) {
		
		try {
			int result = adminService.deleteTodo(todoNo);
		} catch (Exception e) {
			log.error("todoList 삭제 오류", e);
		}
		
		return "redirect:/admin/dashboard";
	}

}
