package com.kh.campervalley.mypage.advertiser.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdPerformance {

	private int adPerformanceNo;
	private int advertisementNo;
	private LocalDate displayAt;
	private int dailyClickCnt;
	private int dailyViewCnt;

}
