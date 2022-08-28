package com.kh.campervalley.usedProduct.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.campervalley.common.CamperValleyUtils;
import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.mypage.advertiser.model.dto.AdZone;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertisementExt;
import com.kh.campervalley.mypage.advertiser.model.service.AdvertiserService;
import com.kh.campervalley.tradereview.model.dto.TradeReviewExt;
import com.kh.campervalley.tradereview.model.service.TradereviewService;
import com.kh.campervalley.usedProduct.model.dto.ProductCategory;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.dto.WishProduct;
import com.kh.campervalley.usedProduct.model.service.UsedProductService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping(value = "/usedProduct")
public class UsedProductController  {
	@Autowired
    ServletContext application;
	
	@Autowired
	private UsedProductService usedProductService;
	@Autowired
	private TradereviewService tradereviewService;
	
	@Autowired
	private AdvertiserService advertiserService;

	/* 메인페이지 */
	@GetMapping("/main/mainPage")
	public ModelAndView mainPage(ModelAndView mav, @AuthenticationPrincipal Member loginMember) {
		try {
			List<AdvertisementExt> adList = advertiserService.getDisplayAdList(3, AdZone.usedProductHome);
			if(loginMember != null) {
				int wishCnt = usedProductService.getWishCount(loginMember.getMemberId());
				
				mav.addObject("wishCnt", wishCnt);				
			}
			log.debug("adList = {}", adList);
			
			mav.addObject("adList", adList);
		} catch (Exception e) {
			log.error("광고목록 조회 오류", e);
			throw e;
		}
		return mav;
	};
	
	/* 상품 등록 */
	@GetMapping("/product/registForm")
	public void registForm() {};
	
	@PostMapping("/product/productEnroll")
    @ResponseBody
    public ModelAndView productEnroll(@ModelAttribute UsedProduct usedProduct, RedirectAttributes redirectAttr,
                                        @RequestParam MultipartFile[] upFiles, @AuthenticationPrincipal Member loginMember) {
        // 이미지 파일 복사
        String saveDirectory = application.getRealPath("/resources/upload/usedProduct");

        File file;
        
            for(int i = 0; i <= upFiles.length - 1; i++) {
                String fileName = upFiles[i].getOriginalFilename();
                String renamedFilename = CamperValleyUtils.getRenamedFilename(fileName);
                file = new File(saveDirectory, renamedFilename);
                
                try {
                    FileCopyUtils.copy( upFiles[i].getInputStream(), new FileOutputStream(file));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                   
                    if(i == 0) usedProduct.setProductImg1(renamedFilename);
                    else if(i == 1) usedProduct.setProductImg2(renamedFilename);
                    else if(i == 2)  usedProduct.setProductImg3(renamedFilename);
                    else if(i == 3)  usedProduct.setProductImg4(renamedFilename);
                    else if(i == 4)  usedProduct.setProductImg5(renamedFilename);
                    
            }
            // 로그인한 회원의 아이디
            usedProduct.setSellerId(loginMember.getMemberId()); 
            
            log.debug("usedProduct1234 = {}", usedProduct);
            
            // DB 
            int result = usedProductService.productInsert(usedProduct);
            
            ModelAndView mav = new ModelAndView();
            mav.setViewName("jsonView");
            return mav;
    
    };

	/* 카테고리 검색 */
	@PostMapping("/main/getProductList") 
	@ResponseBody
	public ModelAndView getProductList(@RequestParam(name = "page") int page, @RequestParam(name = "adCount") int beforeAd,
			@AuthenticationPrincipal Member loginMember) {
		ModelAndView mav = new ModelAndView();
		List<AdvertisementExt> feedAdList = advertiserService.getDisplayFeedAdList(beforeAd, 10, AdZone.usedProductFeed);
		mav.addObject("feedAdList", feedAdList);
		int adListSize = beforeAd + feedAdList.size();
		
		List<UsedProduct> list = usedProductService.getProductList(page, adListSize);
		if(loginMember != null) {
			int wishCnt = usedProductService.getWishCount(loginMember.getMemberId());
			mav.addObject("wishCnt", wishCnt);				
		}
		mav.addObject("list", list);
		mav.setViewName("jsonView");
		return mav;
	}
	
	@GetMapping("/main/cateDisplay")
	public ModelAndView cateDisplay(ModelAndView mav,
					@RequestParam(value = "page", required=false, defaultValue = "0") String page,
					@RequestParam(value = "cateNo") String cateNo,
					@RequestParam(value = "order", required=false) String order,
					@AuthenticationPrincipal Member loginMember) {
		usedProductService.cateProductList(cateNo, Integer.parseInt(page), order, mav);
		
		List<AdvertisementExt> adList = advertiserService.getDisplayAdList(3, AdZone.usedProductHome);
		if(loginMember != null) {
			int wishCnt = usedProductService.getWishCount(loginMember.getMemberId());
			mav.addObject("wishCnt", wishCnt);				
		}
		mav.addObject("adList", adList);
		
		mav.addObject("display", "/usedProduct/main/cateDisplay.jsp");
		mav.setViewName("usedProduct/main/mainPage");
		
		return mav;
	}
	
	//카테고리 세부 값 가져오기
	@PostMapping("/main/cateList")
	@ResponseBody
	public ModelAndView cateList() {
		List<ProductCategory> list = usedProductService.cateList();

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/* 검색어 검색 */
	@GetMapping("/main/searchDisplay")
	public String searchDisplay(Model model, @RequestParam(value = "keyword") String keyword,
								@RequestParam(value = "page", required = false, defaultValue = "0") String page,
								@RequestParam(value = "order", required = false) String order,
								@AuthenticationPrincipal Member loginMember) {
		
		usedProductService.searchProductList(keyword, Integer.parseInt(page), order, model);
		
		// 검색어
		String searchResult="";
		
		if (keyword.substring(0, 1).equals("@")) {
			searchResult = " 회원이 올린 상품";			
		} else {
			searchResult = " 의 검색 결과";
		}
		
		List<AdvertisementExt> adList = advertiserService.getDisplayAdList(3, AdZone.usedProductHome);
		if(loginMember != null) {
			int wishCnt = usedProductService.getWishCount(loginMember.getMemberId());
			model.addAttribute("wishCnt", wishCnt);				
		}
		
		model.addAttribute("adList", adList);
		
		model.addAttribute("searchResult", searchResult);
		model.addAttribute("display", "/usedProduct/main/searchDisplay.jsp");
		
		return "/usedProduct/main/mainPage";
		
	};
	
	/* 상품 상세보기 - 상품 정보 */
	// 상품 리스트 - > 상세페이지
	@GetMapping("/product/productDetail")
	public String productDetail(@RequestParam String no, Model model, @AuthenticationPrincipal Member loginMember) {

		usedProductService.viewUpdate(no); //조회수 증가
		/*----- EJ start -----*/
		if(loginMember != null) {
			int wishCnt = usedProductService.getWishCount(loginMember.getMemberId());
			model.addAttribute("wishCnt", wishCnt);				
		}
		/*----- EJ end -----*/
		/*----- JH start -----*/
		// 별점평균, 판매상품/거래리뷰 갯수
		TradeReviewExt member = tradereviewService.getProfileInfo(no);
		Map<String, Object> counts = tradereviewService.selectCounts(no);
		
		model.addAttribute("counts", counts);
		model.addAttribute("member", member);
		/*----- JH end -----*/
		
		// 상품 정보 받아옴
		log.debug("no = {}", no);
		UsedProduct usedProduct = usedProductService.productDetail(Integer.parseInt(no));
		
		model.addAttribute("usedProduct", usedProduct);
		model.addAttribute("/usedProduct/product/productDetail.jsp");
		return "/usedProduct/product/productDetail";
	}
	
	/*----- SJ START ----- */
	@GetMapping("/product/productUpdate")
	public void productUpdate(@RequestParam String no, Model model) {
		try {
			UsedProduct usedProduct = usedProductService.productDetail(Integer.parseInt(no));
			model.addAttribute("usedProduct", usedProduct);
		} catch (Exception e) {
			log.error("상품 수정 오류", e);
			throw e;
		}
	};
	
	@PostMapping("/product/productUpdate")
	@ResponseBody
	public ModelAndView productUpdate(
			ModelAndView mav, 
			@ModelAttribute UsedProduct usedProduct,
			@RequestParam() MultipartFile[] upFiles, 
			@RequestParam(required = false) String productImg1,
			@RequestParam(required = false) String productImg2,
			@RequestParam(required = false) String productImg3,
			@RequestParam(required = false) String productImg4,
			@RequestParam(required = false) String productImg5) throws Exception {
		
		String saveDirectory = application.getRealPath("/resources/upload/usedProduct");
		UsedProduct originalUsedProduct = usedProductService.productDetail(usedProduct.getProductNo());
		
		List<String> originalFilenameList = new ArrayList<>();
    	originalFilenameList.add(originalUsedProduct.getProductImg1());
    	originalFilenameList.add(originalUsedProduct.getProductImg2());
    	originalFilenameList.add(originalUsedProduct.getProductImg3());
    	originalFilenameList.add(originalUsedProduct.getProductImg4());
    	originalFilenameList.add(originalUsedProduct.getProductImg5());
		
		List<String> delProductImgList = new ArrayList<>();
		delProductImgList.add(productImg1);
		delProductImgList.add(productImg2);
		delProductImgList.add(productImg3);
		delProductImgList.add(productImg4);
		delProductImgList.add(productImg5);
		
		log.debug("productImg1 = {}", productImg1);
		log.debug("productImg2 = {}", productImg2);
		log.debug("productImg3 = {}", productImg3);
		log.debug("productImg4 = {}", productImg4);
		log.debug("productImg5 = {}", productImg5);
		
		List<String> afterDelProductImgList = new ArrayList<>();
		if(delProductImgList != null) {
			for(int i = 0; i < delProductImgList.size(); i++) {
				String fileName = delProductImgList.get(i);
				if(fileName != null) {
					File delFile = new File(saveDirectory, fileName);
					log.debug("fileName = {}", fileName);
					log.debug("delFile = {}", delFile);
					if(delFile.exists()) {
						delFile.delete();
					}
				} else if(originalFilenameList.get(i) != null){
					afterDelProductImgList.add(originalFilenameList.get(i));
				}
			}
		}
		log.debug("afterDelProductImgList = {}", afterDelProductImgList);
		
        File[] fileArr = new File[upFiles.length];
        
        if(upFiles.length == 0) {
        	usedProduct.setProductImg1(originalUsedProduct.getProductImg1());
        	usedProduct.setProductImg2(originalUsedProduct.getProductImg2());
        	usedProduct.setProductImg3(originalUsedProduct.getProductImg3());
        	usedProduct.setProductImg4(originalUsedProduct.getProductImg4());
        	usedProduct.setProductImg5(originalUsedProduct.getProductImg5());
        }
        else {
        	
        	for(int i = 0 ; i < upFiles.length; i++) {
        		String fileName = upFiles[i].getOriginalFilename();
        		String renamedFilename = CamperValleyUtils.getRenamedFilename(fileName);
        		fileArr[i] = new File(saveDirectory, renamedFilename);
        	}
        	
        	int startJ = 0;
        	int delFileIndex = 0;
        	for(int i = 0; i < 5; i++) {
        		for(int j = startJ; j < upFiles.length; j++) {
        			if(i < afterDelProductImgList.size() && afterDelProductImgList.get(delFileIndex) != null) {
        				originalFilenameList.set(delFileIndex, afterDelProductImgList.get(delFileIndex));
        				delFileIndex++;
        				break;
        			} else {
        				originalFilenameList.set(i, fileArr[j].getName());
        				try {
        					FileCopyUtils.copy(upFiles[j].getInputStream(), new FileOutputStream(fileArr[j]));
        				} catch (Exception e) {
        					e.printStackTrace();
        				}
        				startJ = ++j;
        				break;
        			}
        		}
        	}
        	log.debug("originalFilenameList = {}", originalFilenameList);
        	
        	usedProduct.setProductImg1(originalFilenameList.get(0));
        	usedProduct.setProductImg2(originalFilenameList.get(1));
        	usedProduct.setProductImg3(originalFilenameList.get(2));
        	usedProduct.setProductImg4(originalFilenameList.get(3));
        	usedProduct.setProductImg5(originalFilenameList.get(4));
        	
        }
        log.debug("usedProduct = {}", usedProduct);
        int result = usedProductService.updateUsedProduct(usedProduct);
        
		mav.setViewName("jsonView");
		return mav;
	}
	/*----- SJ END ----- */
	
	/* 관심상품 */
	@GetMapping("/product/findHeart")
	@ResponseBody
	public ModelAndView findHeart( @RequestParam String productNo, @AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		
		Map<String, Object> map = new HashMap<>();
		map.put("productNo", Integer.parseInt(productNo));
		map.put("memberId", memberId);
		
		WishProduct wishProduct = usedProductService.findHeart(map);
		System.out.println("wishProduct" + wishProduct);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("wishProduct", wishProduct);		
		mav.setViewName("jsonView");
		return mav;
	}
			
	@GetMapping("/product/saveHeart")
	@ResponseBody
	public UsedProduct saveHeart(@RequestParam String productNo, @AuthenticationPrincipal Member loginMember) {
		WishProduct wishProduct = new WishProduct();
		
		// 글 번호 세팅
		wishProduct.setProductNo(Integer.parseInt(productNo));
		
		// memberId 세팅
		wishProduct.setMemberId(loginMember.getMemberId());
		
		// +1된 하트 갯수 가져오기
		UsedProduct usedProduct = usedProductService.saveHeart(wishProduct, productNo);
		
		usedProduct.setHeart(usedProduct.getHeart());
		
		return usedProduct;
	}
	
	@GetMapping("/product/removeHeart")
	@ResponseBody
	public UsedProduct removeHeart(@RequestParam String productNo, @AuthenticationPrincipal Member loginMember) {
		WishProduct wishProduct = new WishProduct();
		
		// 글 번호 세팅
		wishProduct.setProductNo(Integer.parseInt(productNo));
		
		// memberId 세팅
		wishProduct.setMemberId(loginMember.getMemberId());
		
		// +1된 하트 갯수 가져오기
		UsedProduct usedProduct = usedProductService.removeHeart(wishProduct, productNo);
		
		return usedProduct;
	}
	
	/* 상품 삭제 */
	@PostMapping("/product/productDelete")
	public String productDelete(@RequestParam String productNo) throws Exception {	
		
		int result = usedProductService.productDelete(Integer.parseInt(productNo));		
		
		return "redirect:/usedProduct/main/mainPage";
	}
	
	/* 판매자 정보 */
	@GetMapping("/product/getSellerInfo")
	@ResponseBody
	public ModelAndView getSellerInfo(@RequestParam String productNo) {
		System.out.println(productNo);
		
		// 판매자
		Member member = usedProductService.getSellerInfo(Integer.parseInt(productNo));
		log.debug("member = {}", member);
		// 물건 총 개수
		int sellerProdNum = usedProductService.getSellerProdNum(Integer.parseInt(productNo));
		System.out.println(member.getProfileImg());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("profileImg", member.getProfileImg());
		mav.addObject("member", member);
		mav.addObject("sellerId", member.getMemberId());
		mav.addObject("sellerProdNum", sellerProdNum);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	/*----- JH START ----- */
	/* 판매자 정보 - 판매자 상품정보 목록 비동기 요청 */
	@GetMapping("/productList")
	public ModelAndView reviewList(
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam String sellerId, 
			ModelAndView mav) {
		try {
			int numPerPage = UsedProductService.NUM_PER_PAGE_MODAL;
			List<UsedProduct> productList = usedProductService.selectProductListByMemberId(cPage, numPerPage, sellerId);
			
			// 페이지바
			int totalContent = usedProductService.selectTotalProductByMemberId(sellerId);
			String pagebar = CamperValleyUtils.getPagebarAsync(cPage, numPerPage, totalContent, "Product");
			mav.addObject("productList", productList);
			mav.addObject("pagebar", pagebar);
			mav.setViewName("jsonView");
		} catch(Exception e) {
			log.error("판매자 판매상품 목록 조회 오류", e);
			throw e;
		}
		return mav;
	}
	/*----- JH END -----*/
}