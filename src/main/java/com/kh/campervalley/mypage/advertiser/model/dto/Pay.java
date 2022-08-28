package com.kh.campervalley.mypage.advertiser.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pay {

	private String merchantUid;
	private int advertiserNo;
	private String impUid;
	private String payMethod;
	private int paidAmount;
	private String status;
	private String buyerEmail;
	private String buyerName;
	private String buyerTel;
	private long paidAt;
	private String pgProvider;

}
