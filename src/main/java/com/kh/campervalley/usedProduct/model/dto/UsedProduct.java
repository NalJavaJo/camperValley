package com.kh.campervalley.usedProduct.model.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import com.kh.campervalley.cs.model.dto.Category;
import com.kh.campervalley.member.model.dto.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UsedProduct {

	private int productNo;
	private String sellerId;
	private int cateNo;
	private String productTitle;
	private String productContent;
	private String productImg1;
	private String productImg2;
	private String productImg3;
	private String productImg4;
	private String productImg5;
	private String productPrice;
	private String productLocation;
	private int productDeliveryFee;
	private String productEnrollTime;
	private int productViews;
	private Date transactionDate;
	private String buyerId;
	private String isDelete;
	private String heart;
}
