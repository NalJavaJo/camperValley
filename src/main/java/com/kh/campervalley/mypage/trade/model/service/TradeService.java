package com.kh.campervalley.mypage.trade.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campervalley.mypage.trade.dto.WishExt;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.dto.UsedProductExt;

import lombok.NonNull;

public interface TradeService {
	
	public static final int TRADE_NUM_PER_REQUEST= 7;
	
	List<UsedProduct> sellingListByMemberId(Map<String, Object> map);
	/* --JH-- */
	List<UsedProductExt> purchasedListByMemberId(Map<String, Object> map);
	/* --JH-- */
	List<UsedProduct> selectMoreSellingProduct(int offset, int numPerReq, String memberId);

	List<WishExt> wishListByMemberId(Map<String, Object> map);

	int wishDelete(int wishNo);

	List<WishExt> selectMoreWishProduct(int offset, String type, int numPerReq, String memberId);

	List<UsedProduct> soldListByMemberId(Map<String, Object> map);

	List<UsedProduct> selectMoreSoldProduct(int offset, int numPerReq, String memberId);
	
	List<UsedProductExt> selectMorePuschasedProduct(int offset, int numPerReq, @NonNull String memberId);
	
	int updateProductSetDelete(int productNo);

}
