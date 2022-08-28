package com.kh.campervalley.usedProduct.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.usedProduct.model.dao.UsedProductDao;
import com.kh.campervalley.usedProduct.model.dto.ProductCategory;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.dto.WishProduct;

import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UsedProductServiceImpl implements UsedProductService {

	@Autowired
	private UsedProductDao usedProductDao;
	
	@Override
	public int productInsert(UsedProduct usedProduct) {
		return usedProductDao.productInsert(usedProduct);
	}

	@Override
	public int getProductNo() {
		return usedProductDao.getProductNo();
	}

	@Override
	public List<UsedProduct> getProductList(int page, int adListSize) {
		// EJ start
		int adInPage = 0;
		int prevPageAds = 0;
		int AD_INTERVAL = 6;

		int numPerPage = 10;
		int offset = (page - 1) * numPerPage;
		if(adListSize > 0) {
			for(int i = 1; i <= adListSize; i++) {
				//log.debug("adList.i = {}", i);
				
				if(i * AD_INTERVAL <= offset)
					prevPageAds++;
				
				if(i * AD_INTERVAL > offset && i * AD_INTERVAL < offset + numPerPage)
					adInPage++;
			}
		}
		log.debug("prevPageAds = {}", prevPageAds);
		log.debug("adInPage = {}", adInPage);
		offset = offset - prevPageAds;
		int limit = numPerPage - adInPage;
		log.debug("offset = {}", offset);
		log.debug("limit = {}", limit);
		RowBounds rowBounds = new RowBounds(offset, limit);
		List<UsedProduct> list = usedProductDao.selectProductList(rowBounds);
		return list;
		// EJ end
		
//		Map<String, Object> param = new HashMap<>();
//		int start;
//		int end;
//		int default_count = 10;
//		int pageSize = 10;
//		
//		if(page > 0) {
//			start = default_count + 1 + (page - 1) * pageSize;
//			end = default_count + page * pageSize;
//			param.put("start", start);
//			param.put("end", end);
//			
//			System.out.println("start = " + start);
//			System.out.println("end = " + end);
//		}
//		return usedProductDao.getProductList(param);
	}

	@Override
	public void cateProductList(String cateNo, int page, String order, ModelAndView mav) {
		
		Map<String, Object> map = new HashMap<>();
		
		int pageSize = 20;
		if(page == 0) {
			page = 1;
		}
		
		int start = (page - 1) * pageSize;
		int end = (page) * pageSize;
		
		String cateName = usedProductDao.cateName(cateNo);
	
		
		
		map.put("start", start);
		map.put("end", end);
		map.put("order", order);
		map.put("cateNo", Integer.parseInt(cateNo));
		
		// 목록 조회
		List<UsedProduct> list = usedProductDao.cateProductList(map);
		// 개수 조회
		int cnt = usedProductDao.cateProductCount(map);

		mav.addObject("cateName", cateName);
		mav.addObject("cateNo", cateNo);
		mav.addObject("list", list);
		mav.addObject("start", start);
		mav.addObject("end", end);
		mav.addObject("cnt", cnt);
		mav.addObject("page", page);
		mav.addObject("order", order);
	}

	@Override
	public List<ProductCategory> cateList() {
		return usedProductDao.cateList();
	}

	@Override
	public void viewUpdate(String no) {
		usedProductDao.viewUpdate(no);
	}

	@Override
	public UsedProduct productDetail(int productNo) {
		return usedProductDao.productDetail(productNo);
	}

	@Override
	public UsedProduct saveHeart(WishProduct wishProduct, String productNo) {
		UsedProduct usedProduct = new UsedProduct();
		usedProduct.setProductNo(wishProduct.getProductNo());
		
		// 해당 게시글 heart +1
		usedProductDao.updateUpHeart(usedProduct);
		
		// wishProduct테이블에 추가
		int result = usedProductDao.insertHeart(wishProduct);
		
		if (result == 1) {
			// 갱신된 하트 갯스 가져오기
			usedProduct = usedProductDao.getHeartCount(usedProduct);
		}
		return usedProduct;
	}

	@Override
	public UsedProduct removeHeart(WishProduct wishProduct, String productNo) {
		UsedProduct usedProduct = new UsedProduct();
		usedProduct.setProductNo(wishProduct.getProductNo());
		
		// 해당 게시글 heart -1
		usedProductDao.updateDownHeart(usedProduct);
		
		// wishProduct테이블에 추가
		int result = usedProductDao.deleteHeart(wishProduct);
		
		if (result == 1) {
			// 갱신된 하트 갯스 가져오기
			usedProduct = usedProductDao.getHeartCount(usedProduct);
		}
		return usedProduct;
	}

	@Override
	public WishProduct findHeart(Map<String, Object> map) {
		return usedProductDao.findHeart(map);
	}

	@Override
	public int productDelete(int productNo) throws Exception {
		return usedProductDao.updateIsDelete(productNo);
	}

	@Override
	public void searchProductList(String keyword, int page, String order, Model model) {

		Map<String, Object> param = new HashMap<>();
		
		// 검색어
		if (keyword.substring(0, 1).equals("@")) {
			keyword = keyword.substring(1, keyword.length());
			param.put("nickname", keyword);
		} else {
			
			param.put("productTitle", keyword);
		}
		
		// 페이징 처리
		int pageSize = 20;
		if(page == 0) {
			page = 1;
		}
		
		int start = (page - 1) * pageSize;
		int end = (page) * pageSize;
	
		param.put("start", start);
		param.put("end", end);
		param.put("order", order);
		
		// 목록 조회
		List<UsedProduct> list = usedProductDao.searchProductList(param);
		
		int count = usedProductDao.searchProductCount(param);
		
		log.debug("list = {}", list);
		log.debug("list = {}", list);
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", count);
		model.addAttribute("page", page);
		model.addAttribute("keyword", keyword);
		model.addAttribute("order", order);
		
	}

	@Override
	public Member getSellerInfo(int productNo) {
		return usedProductDao.getSellerInfo(productNo);
	}

	@Override
	public int getSellerProdNum(int productNo) {
		 return usedProductDao.getSellerProdNum(productNo);
	}

	/*----- EJ START ----- */
	@Override
	public int getWishCount(String memberId) {
		return usedProductDao.getWishCount(memberId);
	}
	
	@Override
	public int updateUsedProductAfterSelling(Map<String, Object> param) {
		return usedProductDao.updateUsedProductAfterSelling(param);
	}
	/*----- EJ END ----- */
	
	/*----- JH START ----- */
	@Override
	public List<UsedProduct> selectProductListByMemberId(int cPage, int numPerPage, String memberId) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return usedProductDao.selectProductListByMemberId(rowBounds, memberId);
	}

	@Override
	public int selectTotalProductByMemberId(String memberId) {
		return usedProductDao.selectTotalProductByMemberId(memberId);
	}
	/*----- JH END ----- */
	
	/*----- SJ START ----- */
	@Override
	public int updateUsedProduct(UsedProduct usedProduct) {
		return usedProductDao.updateUsedProduct(usedProduct);
	}
	/*----- SJ END ----- */
	
}