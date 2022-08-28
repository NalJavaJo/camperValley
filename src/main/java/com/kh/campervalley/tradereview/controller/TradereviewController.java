package com.kh.campervalley.tradereview.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.common.CamperValleyUtils;
import com.kh.campervalley.tradereview.model.dto.ReviewReport;
import com.kh.campervalley.tradereview.model.dto.TradeReview;
import com.kh.campervalley.tradereview.model.dto.TradeReviewExt;
import com.kh.campervalley.tradereview.model.service.TradereviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/tradereview")
public class TradereviewController {

	@Autowired
	private TradereviewService tradereviewService;
	
	@PostMapping("/reviewEnroll")
	public String reviewEnroll(TradeReview tradeReview, RedirectAttributes redirectAttr) {
		try {
			int result = tradereviewService.insertReview(tradeReview);
			redirectAttr.addFlashAttribute("msg", "거래후기를 성공적으로 등록했습니다.");
		} catch(Exception e) {
			log.error("거래후기 등록 오류", e);
			throw e;
		}
		return "redirect:/mypage/trade/purchased";
	}
	
	@PostMapping("/reviewUpdate")
	public String reviewUpdate(TradeReview tradeReview, RedirectAttributes redirectAttr) {
		try {
			int result = tradereviewService.updateReview(tradeReview);
			redirectAttr.addFlashAttribute("msg", "거래후기가 수정되었습니다.");
		} catch(Exception e) {
			log.error("거래후기 수정 오류", e);
			throw e;
		}
		return "redirect:/mypage/trade/purchased";
	}
	
	@PostMapping("/reviewDelete")
	public String reviewDelete(@RequestParam int reviewNo, RedirectAttributes redirectAttr) {
		try {
			int result = tradereviewService.deleteReview(reviewNo);
			redirectAttr.addFlashAttribute("msg", "거래후기가 삭제되었습니다.");
		} catch(Exception e) {
			log.error("거래후기 삭제 오류", e);
			throw e;
		}
		return "redirect:/mypage/trade/purchased";
	}
	
	
	@PostMapping("/reportEnroll")
	public String reportEnroll(@RequestParam String productNo, ReviewReport reviewReport, RedirectAttributes redirectAttr) {
		try {
			log.debug("reviewReport = {}", reviewReport);
			int result = tradereviewService.insertReport(reviewReport);
			redirectAttr.addFlashAttribute("msg", "신고가 접수되었습니다.");
		} catch(Exception e) {
			log.error("거래후기신고 등록 오류", e);
			throw e;
		}
		return "redirect:/usedProduct/product/productDetail?no=" + productNo;
	}
	
	@GetMapping("/reviewList")
	public ModelAndView reviewList(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam String sellerId, 
			ModelAndView mav,
			HttpServletRequest request) {
		try {
			int numPerPage = TradereviewService.NUM_PER_PAGE;
			List<TradeReviewExt> reviewList = tradereviewService.selectReviewListByMemberId(cPage, numPerPage, sellerId);
			
			// 페이지바
			int totalContent = tradereviewService.selectTotalReviewByMemberId(sellerId);
			String pagebar = CamperValleyUtils.getPagebarAsync(cPage, numPerPage, totalContent, "Review");
			log.debug("totalContent = {}", totalContent);
			mav.addObject("reviewList", reviewList);
			mav.addObject("pagebar", pagebar);
			mav.setViewName("jsonView");
		} catch(Exception e) {
			log.error("판매자 거래리뷰 목록 조회 오류", e);
			throw e;
		}
		return mav;
	}
	
}
