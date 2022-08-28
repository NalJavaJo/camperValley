package com.kh.campervalley.mypage.advertiser.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class PayExt extends Pay {

	private int paidSum;

	public PayExt(String merchantUid, int advertiserNo, String impUid, String payMethod, int paidAmount, String status,
			String buyerEmail, String buyerName, String buyerTel, long paidAt, String pgProvider, int paidSum) {
		super(merchantUid, advertiserNo, impUid, payMethod, paidAmount, status, buyerEmail, buyerName, buyerTel, paidAt,
				pgProvider);
		this.paidSum = paidSum;
	}

}
