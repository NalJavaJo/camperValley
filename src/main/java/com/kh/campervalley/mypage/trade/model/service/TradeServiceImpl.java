package com.kh.campervalley.mypage.trade.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campervalley.mypage.trade.dto.WishExt;
import com.kh.campervalley.mypage.trade.model.dao.TradeDao;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.dto.UsedProductExt;

import lombok.NonNull;

@Service
public class TradeServiceImpl implements TradeService {
	
	@Autowired
	TradeDao tradeDao;


	@Override
	public List<UsedProduct> sellingListByMemberId(Map<String, Object> map) {
		return tradeDao.sellingListByMemberId(map);
	}
	/* --JH-- */
	@Override
	public List<UsedProductExt> purchasedListByMemberId(Map<String, Object> map) {
		return tradeDao.purchasedListByMemberId(map);
	}
	/* --JH-- */
	@Override
	public List<UsedProduct> selectMoreSellingProduct(int offset, int numPerReq, @NonNull String memberId) {
		RowBounds rowBounds = new RowBounds(offset, numPerReq);
		
		return tradeDao.selectMoreSellingProduct(memberId, rowBounds);
	}
	
	@Override
	public List<UsedProduct> selectMoreSoldProduct(int offset, int numPerReq, @NonNull String memberId) {
		RowBounds rowBounds = new RowBounds(offset, numPerReq);
		return tradeDao.selectMoreSoldProduct(memberId, rowBounds);
	}
	
	@Override
	public List<WishExt> wishListByMemberId(Map<String, Object> map) {
		return tradeDao.wishListByMemberId(map);
	}
	
	@Override
	public int wishDelete(int wishNo) {
		return tradeDao.wishDelete(wishNo);
	}
	
	@Override
	public List<WishExt> selectMoreWishProduct(int offset, String type, int numPerReq, @NonNull String memberId) {
		RowBounds rowBounds = new RowBounds(offset, numPerReq);
		return tradeDao.selectMoreWishProduct(memberId, rowBounds);
	}
	
	@Override
	public List<UsedProduct> soldListByMemberId(Map<String, Object> map) {
		return tradeDao.soldListByMemberId(map);
	}
	
	@Override
	public List<UsedProductExt> selectMorePuschasedProduct(int offset, int numPerReq, @NonNull String memberId) {
		RowBounds rowBounds = new RowBounds(offset, numPerReq);
		return tradeDao.selectMorePuschasedProduct(memberId, rowBounds);
	}
	@Override
	public int updateProductSetDelete(int productNo) {
		return tradeDao.updateProductSetDelete(productNo);
		
	}
	

}
