package com.kh.campervalley.mypage.advertiser.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LicenseFile {

	private int licenseFileNo;
	private int advertiserNo;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;

}
