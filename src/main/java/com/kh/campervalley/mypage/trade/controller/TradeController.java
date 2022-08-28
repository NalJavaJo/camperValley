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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.member.model.service.MemberService;
import com.kh.campervalley.mypage.trade.dto.WishExt;
import com.kh.campervalley.mypage.trade.model.service.TradeService;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.dto.UsedProductExt;
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
	private MemberService memberService;
	
	@Autowired
	ServletContext application;
	
	int numPerReq = tradeService.TRADE_NUM_PER_REQUEST;
	
	@GetMapping("/purchased")
	public ModelAndView purchased(@AuthenticationPrincipal Member member) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("numPerReq", TradeService.TRADE_NUM_PER_REQUEST);
			/* --JH-- */
			List<UsedProductExt> list = tradeService.purchasedListByMemberId(map);
			/* --JH-- */
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return mav;
		
	}
	
	@GetMapping("/selling")
	public ModelAndView selling(@AuthenticationPrincipal Member member) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("numPerReq", numPerReq );
			
			List<UsedProduct> list = tradeService.sellingListByMemberId(map);
			
			mav.addObject("list", list);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return mav;
	}
	
	@GetMapping("/moreSellingProduct")
	public ResponseEntity<?> addSellingProduct(
						int offset, @AuthenticationPrincipal Member member) {
		Map<String, Object> map = new HashMap<>();
		try {
			List<UsedProduct> list = tradeService.selectMoreSellingProduct(
					offset, numPerReq, member.getMemberId());
			map.put("list", list);
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
	public ModelAndView sold(@AuthenticationPrincipal Member member) {
		ModelAndView mav = new ModelAndView();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("numPerReq", numPerReq );
			
			List<UsedProduct> list = tradeService.soldListByMemberId(map);
			
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
	
	@GetMapping("/morePuschasedProduct")
	public ResponseEntity<?> addPuschasedProduct(
			int offset, @AuthenticationPrincipal Member member) {
		Map<String, Object> map = new HashMap<>();
		try {
			List<UsedProductExt> list = tradeService.selectMorePuschasedProduct(
					offset,numPerReq, member.getMemberId());
			map.put("list", list);
			
		} catch(Exception e) {
			log.error("구매상품 추가 조회 오류", e);
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
	
	@PostMapping("/productDelete")
	public String productDelete(int productNo, RedirectAttributes redirectAttr) throws Exception {	

		try {
			int result = tradeService.updateProductSetDelete(productNo);
			redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 삭제했습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}					
		
		return "redirect:/mypage/trade/selling";
	}
	
	@PostMapping("/wishDelete")
	public String wishDelete(WishExt wishExt, RedirectAttributes redirectAttr) throws Exception {	
		
		int result = tradeService.wishDelete(wishExt.getWishNo());	
		redirectAttr.addFlashAttribute("msg", "관심상품에서 삭제되었습니다.");
		
		return "redirect:/mypage/trade/wish";
	}

	/*----- EJ start -----*/
	@PostMapping("/buyerExist")
	public ResponseEntity<?> checkBuyerIdExist(@RequestParam String buyerId) {
		Map<String, Object> map = new HashMap<>();
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("attribute", "member_id");
			param.put("value", buyerId);
			Member member = memberService.selectOneMember(param);
			if (member != null) {
				map.put("result", true);
			} else {
				map.put("result", false);
			}

		} catch (Exception e) {
			log.error("구매자아이디 조회오류", e);
			map.put("msg", "구매자아이디 조회오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}

	@PostMapping("/buyerUpdate")
	public ResponseEntity<?> completeProductSelling(int productNo, String buyerId) {
		Map<String, Object> map = new HashMap<>();
		try {
			log.debug("productNo, buyerId = {}, {}", productNo, buyerId);
			Map<String, Object> param = new HashMap<>();
			param.put("productNo", productNo);
			param.put("buyerId", buyerId);
			
			int result = usedProductService.updateUsedProductAfterSelling(param);
			if(result > 0)
				map.put("result", true);
		} catch (Exception e) {
			log.error("판매완료 처리 오류", e);
			map.put("msg", "판매완료 처리 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}
	/*----- EJ end -----*/

}
