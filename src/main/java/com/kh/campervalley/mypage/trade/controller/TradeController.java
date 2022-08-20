package com.kh.campervalley.mypage.trade.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.mypage.trade.dto.WishExt;
import com.kh.campervalley.mypage.trade.model.service.TradeService;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.service.UsedProductService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage/trade")
@Slf4j
public class TradeController {
	@Autowired
	private TradeService tradeService;
	
	@Autowired
	private UsedProductService usedProductService;
	
	@Autowired
	ServletContext application;
	
	int numPerReq = tradeService.TRADE_NUM_PER_REQUEST;
	
	@GetMapping("/purchased")
	public ModelAndView purchased(@AuthenticationPrincipal Member member) {
		ModelAndView mav = new ModelAndView();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("numPerReq", TradeService.TRADE_NUM_PER_REQUEST);
			
			List<UsedProduct> list = tradeService.purchasedListByMemberId(map);
			log.debug("list={}",list);
			
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
		
	}
	
	@GetMapping("/selling")
	public ModelAndView selling(@AuthenticationPrincipal Member member) {
		ModelAndView mav = new ModelAndView();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("numPerReq", numPerReq );
			
			List<UsedProduct> list = tradeService.sellingListByMemberId(map);
			log.debug("list={}",list);
			
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//판매상품 추가 조회
	@GetMapping("/moreSellingProduct")
	public ResponseEntity<?> addSellingProduct(
						int offset, @AuthenticationPrincipal Member member) {
		Map<String, Object> map = new HashMap<>();
		try {
			List<UsedProduct> list = tradeService.selectMoreSellingProduct(
					offset, numPerReq, member.getMemberId());
			map.put("list", list);
			log.debug("{}", list);
		} catch(Exception e) {
			log.error("판매상품 목록 추가 조회 오류", e);
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
	
	@GetMapping("/moreSoldProduct")
	public ResponseEntity<?> addSoldProduct(
						int offset, @AuthenticationPrincipal Member member) {
		Map<String, Object> map = new HashMap<>();
		try {
			List<UsedProduct> list = tradeService.selectMoreSoldProduct(
					offset, numPerReq, member.getMemberId());
			map.put("list", list);
			log.debug("{}", list);
		} catch(Exception e) {
			log.error("판매상품 목록 추가 조회 오류", e);
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
	
	
	
	@GetMapping("/sold")
	public  ModelAndView sold(@AuthenticationPrincipal Member member) {
		ModelAndView mav = new ModelAndView();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("numPerReq", numPerReq );
			
			List<UsedProduct> list = tradeService.soldListByMemberId(map);
			log.debug("list={}",list);
			
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@GetMapping("/wish")
	public ModelAndView wish(@AuthenticationPrincipal Member member) {
		ModelAndView mav = new ModelAndView();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("numPerReq", numPerReq );
			
			List<WishExt> list = tradeService.wishListByMemberId(map);
			
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@GetMapping("/moreWishProduct")
	public ResponseEntity<?> addWishProduct(
					int offset, String type, @AuthenticationPrincipal Member member) {
		Map<String, Object> map = new HashMap<>();
		try {
			List<WishExt> list = tradeService.selectMoreWishProduct(
					offset,type, numPerReq, member.getMemberId());
			map.put("list", list);
			log.debug("{}",list);
			
			} catch(Exception e) {
			log.error("관심상품 추가 조회 오류", e);
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
	
	/* 상품 삭제 */
	@PostMapping("/productDelete")
	public String productDelete(UsedProduct usedProduct, RedirectAttributes redirectAttr) throws Exception {	
		log.debug(usedProduct.getProductImg1());
		
		String delDirectory = application.getRealPath("/resources/upload/usedProduct");
		if(usedProduct.getProductImg1() != null) {
			File delFile = new File(delDirectory, usedProduct.getProductImg1());
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		if(usedProduct.getProductImg2() != null) {
			File delFile = new File(delDirectory, usedProduct.getProductImg2());
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		if(usedProduct.getProductImg3() != null) {
			File delFile = new File(delDirectory, usedProduct.getProductImg3());
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		if(usedProduct.getProductImg4() != null) {
			File delFile = new File(delDirectory, usedProduct.getProductImg4());
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		if(usedProduct.getProductImg5() != null) {
			File delFile = new File(delDirectory, usedProduct.getProductImg5());
			if(delFile.exists()) {
				delFile.delete();
			}
		}
		
		int result = usedProductService.productDelete(usedProduct.getProductNo());	
		redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 삭제했습니다.");
		
		return "redirect:/mypage/trade/selling";
	}
	
	/* 상품삭제 */
	@PostMapping("/wishDelete")
	public String wishDelete(WishExt wishExt, RedirectAttributes redirectAttr) throws Exception {	
		
		int result = tradeService.wishDelete(wishExt.getWishNo());	
		redirectAttr.addFlashAttribute("msg", "관심상품에서 삭제되었습니다.");
		
		return "redirect:/mypage/trade/wish";
	}


}
