package com.kh.campervalley.usedProduct.model.dto;

import java.sql.Date;

import com.kh.campervalley.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class UsedProductExt extends UsedProduct {

	private int reviewNo;
	private int starScore;
	private String content;
	private Member member;

	public UsedProductExt(int productNo, String sellerId, int cateNo, String productTitle, String productContent,
			String productImg1, String productImg2, String productImg3, String productImg4, String productImg5,
			String productPrice, String productLocation, int productDeliveryFee, String productEnrollTime,
			int productViews, Date transactionDate, String buyerId, String isDelete, String heart, 
			int reviewNo, int starScore, String content, Member member) {
		super(productNo, sellerId, cateNo, productTitle, productContent, productImg1, productImg2, productImg3, productImg4,
				productImg5, productPrice, productLocation, productDeliveryFee, productEnrollTime, productViews,
				transactionDate, buyerId, isDelete, heart);
		this.reviewNo = reviewNo;
		this.starScore = starScore;
		this.content = content;
		this.member = member;
	}
	
}
