package com.kh.campervalley.mypage.advertiser.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class AdvertisementExt extends Advertisement {

	private int adClickCnt;
	private int adViewCnt;
	private AdAttach adAttach;
	private List<AdPerformance> performanceList = new ArrayList<>();

	public AdvertisementExt(int advertisementNo, int advertiserNo, String adName, AdZone adZone, String adLink,
			int adCpc, int adDailyBudget, boolean adStatus, LocalDateTime createdAt, LocalDateTime updatedAt,
			LocalDateTime deletedAt, int adClickCnt, int adViewCnt, AdAttach adAttach, List<AdPerformance> performanceList) {
		super(advertisementNo, advertiserNo, adName, adZone, adLink, adCpc, adDailyBudget, adStatus, createdAt,
				updatedAt, deletedAt);
		this.adClickCnt = adClickCnt;
		this.adViewCnt = adViewCnt;
		this.adAttach = adAttach;
		this.performanceList = performanceList;
	}

	public void addAdPerformance(@NonNull AdPerformance adPerformance) {
		if (adPerformance != null)
			performanceList.add(adPerformance);
	}

}
