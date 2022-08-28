package com.kh.campervalley.mypage.advertiser.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Advertiser {

	private int advertiserNo;
	private String memberId;
	private String bizLicenseNo;
	private String bizName;
	private BizStatus bizStatus;
	private LocalDateTime createdAt;
	private LocalDateTime deletedAt;

}
