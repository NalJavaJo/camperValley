package com.kh.campervalley.mypage.advertiser.model.common;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.kh.campervalley.mypage.advertiser.model.service.AdvertiserService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class AdvertiserSchedule {

	@Autowired
	private AdvertiserService advertiserService;

	@PostConstruct
	public void advertiserInit() {
		log.debug("[서버실행시 1회 실행]");
		todayInsertPerformance();
	}

	@Scheduled(cron = "0 0 0 * * *")
	public void dailyInsertPerformance() {
		// oracle clude systimestamp와 차이가 있기때문에 display_at = (sysdate + 1) 적용
		log.debug("[매일 자정 실행] 운영중인 광고 익일 일일성과 insert");

//		List<Integer> advertisementNoList = advertiserService.selectAdvertisementForDailyInsertPerform();
		List<Integer> advertisementNoList = advertiserService.selectAdvertisementForInsertPerform();
		log.debug("advertisementNoList = {}", advertisementNoList);

		if (advertisementNoList.size() > 0) {
//			int result = advertiserService.dailyInsertPerformance(advertisementNoList);
			int result = advertiserService.InsertTodayPerformance(advertisementNoList);
		}
	}
	
	public void todayInsertPerformance() {
		List<Integer> advertisementNoList = advertiserService.selectAdvertisementForInsertPerform();
		log.debug("advertisementNoList = {}", advertisementNoList);

		if (advertisementNoList.size() > 0) {
			int result = advertiserService.InsertTodayPerformance(advertisementNoList);
		}
	}

}