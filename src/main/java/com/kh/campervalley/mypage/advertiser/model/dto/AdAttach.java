package com.kh.campervalley.mypage.advertiser.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdAttach {

	private int adAttachNo;
	private int advertisementNo;
	private String originalFilename;
	private String renamedFilename;
	private LocalDateTime createdAt;

}
