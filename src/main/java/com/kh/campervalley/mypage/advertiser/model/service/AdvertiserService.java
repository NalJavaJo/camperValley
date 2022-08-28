package com.kh.campervalley.mypage.advertiser.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campervalley.mypage.advertiser.model.dto.AdZone;
import com.kh.campervalley.mypage.advertiser.model.dto.Admoney;
import com.kh.campervalley.mypage.advertiser.model.dto.Advertisement;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertisementExt;
import com.kh.campervalley.mypage.advertiser.model.dto.Advertiser;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertiserExt;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertiserMoneyExt;
import com.kh.campervalley.mypage.advertiser.model.dto.LicenseFile;
import com.kh.campervalley.mypage.advertiser.model.dto.Pay;

import lombok.NonNull;

public interface AdvertiserService {

	public static final int ADVERTISER_NUM_PER_PAGE = 15;

	public static final int ADVERTISEMENT_NUM_PER_PAGE = 10;

	int insertAdvertiser(AdvertiserExt advertiser);

	List<AdvertiserExt> selectAdvertiserList(int cPage, int numPerPage);

	List<AdvertiserExt> selectAdvertiserFilteredList(Map<String, Object> param, int cPage, int numPerPage);

	int selectTotalAdvertiser();

	int selectFilteredTotalAdvertiser(Map<String, Object> param);

	LicenseFile selectOneLicenseFile(int no);

	int updateAdvertiserPermission(int advertiserNo, String memberId);

	int updateAdvertiserPause(int advertiserNo, String memberId);

	AdvertiserMoneyExt selectOneAdvertiserMoney(String memberId);

	Admoney selectOneAdmoney(int advertiserNo);

	List<Pay> selectNotCanceledPay(Map<String, Object> param);

	int chargeAdmoney(Pay pay);

	List<Pay> selectPayByMerchantUidList(List<String> merchantUidList);

	int refundAdmoney(Pay pay);

	int insertAdvertisement(AdvertisementExt advertisement);

	List<AdvertisementExt> selectAdListByAdvertiserNo(int advertiserNo, int cPage, int numPerPage);

	int selectTotalAdvertisement(int advertiserNo);

	int deleteAdvertisement(int advertisementNo);

	Advertiser selectAdvertiserByMemberId(@NonNull String memberId);

	boolean checkBalanceAndCpc(Advertisement advertisement, String memberId);

	int updateAdvertisement(Advertisement advertisement);

	List<Integer> selectAdvertisementForInsertPerform();
	
	List<Integer> selectAdvertisementForDailyInsertPerform();

	int dailyInsertPerformance(List<Integer> advertisementNoList);
	
	int InsertTodayPerformance(List<Integer> advertisementNoList);

	List<AdvertisementExt> selectDisplayAd(Map<String, Object> param);

	int updatePerformView(int advertisementNo);

	int updatePerformClick(int advertisementNo);

	List<AdvertisementExt> getDisplayAdList(int length, AdZone adZone);

	List<AdvertisementExt> getDisplayFeedAdList(int beforeAd, int i, AdZone adZone);

	List<Map<String, Object>> selectChartData(Map<String, Object> param);

	int exitAdvertiser(int advertiserNo, String memberId);

	boolean isPauseAdvertiser(String memberId);

	boolean isAdvertiser(String memberId);

}
