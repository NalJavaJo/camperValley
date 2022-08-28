package com.kh.campervalley.mypage.trade.dto;

import com.kh.campervalley.campsite.model.dto.CampsiteExt;
import com.kh.campervalley.campsite.model.dto.CampsiteFacility;
import com.kh.campervalley.campsite.model.dto.CampsiteImage;
import com.kh.campervalley.usedProduct.model.dto.UsedProduct;
import com.kh.campervalley.usedProduct.model.dto.WishProduct;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class WishExt extends WishProduct {
	
	private String productTitle;
	private String productImg1;
	private String productPrice;
	private String productLocation;
	
	public WishExt(int wishNo, String memberId, int productNo, String productTitle, String productImg1,
			String productPrice, String productLocation) {
		super(wishNo, memberId, productNo);
		this.productTitle = productTitle;
		this.productImg1 = productImg1;
		this.productPrice = productPrice;
		this.productLocation = productLocation;
	}
	
}
