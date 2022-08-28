package com.kh.campervalley.mypage.advertiser.model.dto;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class AdvertiserMoneyExt extends Advertiser {

	private Admoney admoney;

	public AdvertiserMoneyExt(int advertiserNo, String memberId, String bizLicenseNo, String bizName,
			BizStatus bizStatus, LocalDateTime createdAt, LocalDateTime deletedAt, Admoney admoney) {
		super(advertiserNo, memberId, bizLicenseNo, bizName, bizStatus, createdAt, deletedAt);
		this.admoney = admoney;
	}

}
