package com.kh.campervalley.community.camper.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.dto.CamperExt;
import com.kh.campervalley.community.camper.model.service.CamperService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/community/camper")
public class CamperController {

	@Autowired
	private CamperService camperService;
	
	@GetMapping("/camperList")
	public ModelAndView camperList(
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKeyword,
			ModelAndView mav) {
		mav.addObject("searchType", searchType);
		mav.addObject("searchKeyword", searchKeyword);
		mav.setViewName("/community/camper/camperList");
		return mav;
	}
	
	// 비동기 요청처리
	@GetMapping("/moreCamperList")
	public ModelAndView moreCamperList(
			@RequestParam int cPage, 
			@RequestParam(required = false) String isChk, 
			@RequestParam(required = false) String searchType, 
			@RequestParam(required = false) String searchKeyword, 
			ModelAndView mav) {
		try {
			Map<String, Object> param = new HashMap<>();
			
			param.put("isChk", isChk);
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			int numPerPage = CamperService.CAMPER_NUM_PER_PAGE;
			List<CamperExt> camperList = camperService.selectMoreCamperList(cPage, numPerPage, param);
			mav.addObject("camperList", camperList);
			mav.addObject("param", param);
			mav.setViewName("jsonView");
		} catch(Exception e) {
			log.error("캠퍼모집 목록 추가 조회 오류", e);
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/camperEnroll")
	public void camperEnroll() {}
	
	@PostMapping("/camperEnroll")
	public String camperEnroll(Camper camper, RedirectAttributes redirectAttr) {
		try {
			int result = camperService.insertCamper(camper);
			redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 등록했습니다.");
		} catch(Exception e) {
			log.error("캠퍼모집글 등록 오류");
			throw e;
		}
		return "redirect:/community/camper/camperList";
	}
	
	// 비동기 요청처리
	@GetMapping("/camperDetail")
	public ModelAndView camperDetail(@RequestParam int camperNo, ModelAndView mav) {
		try {
			CamperExt camper = camperService.selectCamperOne(camperNo);
			mav.addObject("camper", camper);
			mav.setViewName("jsonView");
		} catch(Exception e) {
			log.error("캠퍼모집 상세 조회 오류", e);
			throw e;
		}
		return mav;
	}
	
	@PostMapping("/camperDelete")
	public String camperDelete(@RequestParam int camperNo, RedirectAttributes redirectAttr) {
		try {
			int result = camperService.deleteCamper(camperNo);
			redirectAttr.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
		} catch(Exception e) {
			log.error("캠퍼모집 삭제 오류", e);
			throw e;
		}
		return "redirect:/community/camper/camperList";
	}
	
	
	@PostMapping("/camperUpdate") 
	public String camperUpdate(Camper camper, RedirectAttributes redirectAttr) {
		try {
			log.debug("camper = {}", camper);
			int result = camperService.updateCamper(camper);
			redirectAttr.addFlashAttribute("msg", "게시글이 수정되었습니다.");
		} catch(Exception e) {
			log.debug("캠퍼모집 수정 오류", e);
			throw e;
		}
		return "redirect:/community/camper/camperList";
	}
	 
}
