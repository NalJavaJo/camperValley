package com.kh.campervalley.usedProduct.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.usedProduct.model.dto.ProductCategory;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.dto.WishProduct;

@Mapper
public interface UsedProductDao {

	int productInsert(UsedProduct usedProduct);

	int getProductNo();

	List<UsedProduct> getProductList(Map<String, Object> param);

	List<ProductCategory> cateList();

	List<UsedProduct> cateProductList(Map<String, Object> map);

	int cateProductCount(Map<String, Object> map);

	String cateName(String cateNo);

	void viewUpdate(String no);

	UsedProduct productDetail(int productNo);

	void updateUpHeart(UsedProduct usedProduct);

	int insertHeart(WishProduct wishProduct);

	UsedProduct getHeartCount(UsedProduct usedProduct);

	void updateDownHeart(UsedProduct usedProduct);

	int deleteHeart(WishProduct wishProduct);

	WishProduct findHeart(Map<String, Object> map);

	int productDelete(int productNo) throws Exception;

	List<UsedProduct> searchProductList(Map<String, Object> param);

	int searchProductCount(Map<String, Object> param);

	Member getSellerInfo(int productNo);

	int getSellerProdNum(int productNo);
	
	/*----- EJ START ----- */
	List<UsedProduct> selectProductList(RowBounds rowBounds);
	
	int updateIsDelete(int productNo);
	
	int getWishCount(String memberId);	
	
	public int updateUsedProductAfterSelling(Map<String, Object> param);
	/*----- EJ END ----- */

	/*----- JH START ----- */
	List<UsedProduct> selectProductListByMemberId(RowBounds rowBounds, String memberId);

	int selectTotalProductByMemberId(String memberId);
	/*----- JH END ----- */

	/*----- SJ START ----- */
	int updateUsedProduct(UsedProduct usedProduct);
	/*----- SJ END ----- */

}