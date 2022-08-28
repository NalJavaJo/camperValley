package com.kh.campervalley.mypage.advertiser.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.mypage.advertiser.model.dto.AdAttach;
import com.kh.campervalley.mypage.advertiser.model.dto.Admoney;
import com.kh.campervalley.mypage.advertiser.model.dto.Advertisement;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertisementExt;
import com.kh.campervalley.mypage.advertiser.model.dto.Advertiser;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertiserExt;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertiserMoneyExt;
import com.kh.campervalley.mypage.advertiser.model.dto.LicenseFile;
import com.kh.campervalley.mypage.advertiser.model.dto.Pay;

import lombok.NonNull;

@Mapper
public interface AdvertiserDao {

	int insertAdvertiser(AdvertiserExt advertiser);

	@Insert("insert into admoney values (seq_admoney_no.nextval, #{advertiserNo}, default)")
	int insertAdmoney(int advertiserNo);

	@Insert("insert into license_file values (seq_license_file_no.nextval, #{advertiserNo}, #{originalFilename}, #{renamedFilename}, (sysdate + 9/24))")
	int insertLicenseFile(LicenseFile licenseFile);

	List<AdvertiserExt> selectAdvertiserList(RowBounds rowBounds);

	List<AdvertiserExt> selectAdvertiserFilteredList(Map<String, Object> param, RowBounds rowBounds);

	int selectTotalAdvertiser();

	int selectFilteredTotalAdvertiser(Map<String, Object> param);

	@Select("select * from license_file where license_file_no = #{no}")
	LicenseFile selectOneLicenseFile(int no);

	@Update("update advertiser set biz_status = 'Y' where advertiser_no = #{advertiserNo}")
	int updateAdvertiserStatus(int advertiserNo);

	@Insert("insert into authority values (#{auth}, #{memberId})")
	int insertAuthority(Map<String, Object> map);

	@Delete("delete from authority where member_id = #{memberId} and auth = #{auth}")
	int deleteAuthority(Map<String, Object> map);

	@Update("update advertisement set ad_status = 0, updated_at = (sysdate + 9/24) where advertiser_no = (select ader.advertiser_no from advertiser ader where member_id = #{memberId} and deleted_at is null)")
	int updateAdOff(String memberId);
	
	AdvertiserMoneyExt selectOneAdvertiserMoney(String memberId);

	@Select("select * from admoney where advertiser_no = #{advertiserNo}")
	Admoney selectOneAdmoney(int advertiserNo);

	@Insert("insert into pay values (#{merchantUid}, #{advertiserNo}, #{impUid}, #{payMethod}, #{paidAmount}, #{status}, #{buyerEmail}, #{buyerName}, #{buyerTel}, #{paidAt}, #{pgProvider})")
	int insertPay(Pay pay);

	@Update("update admoney set balance = balance + #{paidAmount} where advertiser_no = #{advertiserNo}")
	int updateAdmoneyCharge(Pay pay);

	List<Pay> selectNotCanceledPay(Map<String, Object> param);

	List<Pay> selectPayByMerchantUidList(List<String> merchantUidList);

	@Update("update pay set status = 'cancel' where merchant_uid = #{merchantUid}")
	int updatePayRefund(String merchantUid);

	@Update("update admoney set balance = balance - #{paidAmount} where advertiser_no = #{advertiserNo}")
	int updateAdmoneyRefund(Pay pay);

	int insertAdvertisement(AdvertisementExt advertisement);

	@Insert("insert into ad_attach values (seq_ad_attach_no.nextval, #{advertisementNo}, #{originalFilename}, #{renamedFilename}, (sysdate + 9/24))")
	int insertAdAttach(AdAttach adAttach);

	@Insert("insert into ad_performance values (seq_ad_performance_no.nextval, #{advertisementNo}, trunc(sysdate + 9/24), default, default)")
	int insertAdPerformance(int advertisementNo);

	List<AdvertisementExt> selectAdListByAdvertiserNo(int advertiserNo, RowBounds rowBounds);

	@Select("select count(*) from advertisement where advertiser_no = #{advertiserNo} and deleted_at is null")
	int selectTotalAdvertisement(int advertiserNo);

	@Update("update advertisement set deleted_at = (sysdate + 9/24) where advertisement_no = #{advertisementNo}")
	int updateDelAtAdvertisement(int advertisementNo);

	Advertiser selectAdvertiserByMemberId(@NonNull String memberId);

	int checkBalanceAndCpc(Advertisement advertisement);

	@Update("update advertisement set ad_cpc = #{adCpc}, ad_daily_budget = #{adDailyBudget}, ad_status = #{adStatus}, updated_at = (sysdate + 9/24) where advertisement_no = #{advertisementNo}")
	int updateAdvertisement(Advertisement advertisement);

	@Select("select count(*) from ad_performance where advertisement_no = #{advertisementNo} and trunc(display_at) = trunc(sysdate + 9/24)")
	int checkTodayPerformanceCnt(int advertisementNo);

	List<Integer> selectAdvertisementForInsertPerform();

	List<Integer> selectAdvertisementForDailyInsertPerform();

	int dailyInsertPerformance(List<Integer> advertisementNoList);

	int InsertTodayPerformance(List<Integer> advertisementNoList);

	List<AdvertisementExt> selectDisplayAd(Map<String, Object> param);

	@Update("update ad_performance set daily_view_cnt = daily_view_cnt + 1 where advertisement_no = #{advertisementNo} and trunc(display_at) = trunc(sysdate + 9/24)")
	int updatePerformView(int advertisementNo);

	@Update("update ad_performance set daily_click_cnt = daily_click_cnt + 1 where advertisement_no = #{advertisementNo} and trunc(display_at) = trunc(sysdate + 9/24)")
	int updatePerformClick(int advertisementNo);

	Map<String, Object> selectOneAdmoneyNo(int advertisementNo);

	@Update("update admoney set balance = balance - ( select ad_cpc from advertisement where advertisement_no = #{advertisementNo} ) where admoney_no = #{admoneyNo}")
	int updateAdmoneyAfterClick(Map<String, Object> param);

	@Update("update advertisement set ad_status = 0 where (advertiser_no = #{advertiserNo} and ad_cpc > #{newBalance}) or ((ad_daily_budget - #{todayCost}) < #{adCpc})")
	int updateAdvertisementOff(Map<String, Object> param);

	List<Map<String, Object>> selectChartData(Map<String, Object> param);

	@Update("update advertiser set deleted_at = (sysdate + 9/24) where advertiser_no = #{advertiserNo}")
	int updateAdvertiserDeletedAt(int advertiserNo);

	boolean isPauseAdvertiser(String memberId);

	boolean isAdvertiser(String memberId);

	@Update("update advertisement set ad_status = 0, deleted_at = (sysdate + 9/24) where advertiser_no = #{advertiserNo}")
	int updateAdvertisementExit(int advertiserNo);

}
