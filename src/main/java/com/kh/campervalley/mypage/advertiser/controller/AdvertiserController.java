package com.kh.campervalley.mypage.advertiser.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.campervalley.common.CamperValleyUtils;
import com.kh.campervalley.member.model.dto.Member;
import com.kh.campervalley.mypage.advertiser.model.dto.AdAttach;
import com.kh.campervalley.mypage.advertiser.model.dto.Admoney;
import com.kh.campervalley.mypage.advertiser.model.dto.Advertisement;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertisementExt;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertiserExt;
import com.kh.campervalley.mypage.advertiser.model.dto.AdvertiserMoneyExt;
import com.kh.campervalley.mypage.advertiser.model.dto.LicenseFile;
import com.kh.campervalley.mypage.advertiser.model.dto.Pay;
import com.kh.campervalley.mypage.advertiser.model.service.AdvertiserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage/advertiser")
@PropertySource("classpath:datasource.properties")
@Slf4j
public class AdvertiserController {
	
	@Autowired
	private AdvertiserService advertiserService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/register")
	public void registerAdvertiser() { }

	@PostMapping("/register")
	public String registerAdvertiser(AdvertiserExt advertiser, @RequestParam("adImg") MultipartFile upFile) {
		try {
			String saveDirectory = application.getRealPath("/resources/upload/mypage/advertiser/license");
			log.debug("saveDirectory = {}", saveDirectory);

			if (upFile.getSize() > 0) {
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = CamperValleyUtils.getRenamedFilename(originalFilename);
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);

				LicenseFile licenseFile = new LicenseFile();
				licenseFile.setOriginalFilename(originalFilename);
				licenseFile.setRenamedFilename(renamedFilename);
				advertiser.setLicenseFile(licenseFile);
			}
			log.debug("advertiser = {}", advertiser);

			int result = advertiserService.insertAdvertiser(advertiser);

		} catch (IOException e) {
			log.error("사업자등록증파일 저장 오류", e);
		} catch (Exception e) {
			log.error("광고주등록 신청 오류", e);
			throw e;
		}

		return "redirect:/mypage/info/main";
	}
	
	@GetMapping("/exit")
	public ModelAndView exitAdvertiser(ModelAndView mav, @AuthenticationPrincipal Member loginMember) {
		String memberId = loginMember.getMemberId();
		try {
			AdvertiserMoneyExt advertiser = advertiserService.selectOneAdvertiserMoney(memberId);
			log.debug("advertiser = {}", advertiser);
			mav.addObject("advertiser", advertiser);
		} catch(Exception e) {
			log.error("광고주 정보 조회 오류", e);
			throw e;
		}
		return mav;
	}
	
	@PostMapping("/exit")
	public String submitAdvertiserExitFrm(@RequestParam int advertiserNo, @RequestParam String memberId, HttpServletRequest request) {
		try {
			int result = advertiserService.exitAdvertiser(advertiserNo, memberId);
			HttpSession session = request.getSession();
			
//			boolean isPauseAdvertiser = advertiserService.isPauseAdvertiser(memberId);
//			boolean isAdvertiser = advertiserService.isAdvertiser(memberId);
//			session.setAttribute("isPauseAdvertiser", isPauseAdvertiser);
//			session.setAttribute("isAdvertiser", isAdvertiser);
			session.invalidate();
		} catch (Exception e) {
			log.error("광고주 탈퇴요청 오류", e);
			throw e;
		}
		return "redirect:/";
	}
	
	@GetMapping("/dashboard")
	public ModelAndView advertiserDashBoard(ModelAndView mav, @AuthenticationPrincipal Member loginMember, 
			@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request) {
		String memberId = loginMember.getMemberId();
		try {
			int numPerPage = AdvertiserService.ADVERTISEMENT_NUM_PER_PAGE;
			String url = request.getRequestURI();
			
			// 광고주 계정 상태
			AdvertiserMoneyExt advertiser = advertiserService.selectOneAdvertiserMoney(memberId);

			// 차트
			Map<String, Object> chartParam = new HashMap<>();
			chartParam.put("advertiserNo", advertiser.getAdvertiserNo());
			chartParam.put("startDate", LocalDate.now().minusDays(6));
			chartParam.put("endDate", LocalDate.now());
			List<Map<String, Object>> chartData = advertiserService.selectChartData(chartParam);

			List<String> dateList = new ArrayList<>();
			List<Integer> viewList = new ArrayList<>();
			List<Integer> clickList = new ArrayList<>();
			for (int i = 0; i < 7; i++) {
				dateList.add("'" + LocalDate.now().minusDays(6 - i) + "'");
				viewList.add(0);
				clickList.add(0);
				for (int j = 0; j < chartData.size(); j++) {
					String date = chartData.get(j).get("DISPLAY_AT").toString().substring(0, 10);
					if (date.equals(LocalDate.now().minusDays(6 - i).toString())) {
						viewList.set(i, Integer.parseInt(chartData.get(j).get("SUM_VIEW").toString()));
						clickList.set(i, Integer.parseInt(chartData.get(j).get("SUM_CLICK").toString()));
						break;
					}
				}
			}
			mav.addObject("dateList", dateList);
			mav.addObject("viewList", viewList);
			mav.addObject("clickList", clickList);

			// 운영광고목록
			List<AdvertisementExt> adList = advertiserService.selectAdListByAdvertiserNo(advertiser.getAdvertiserNo(), cPage, numPerPage);
			int totalAdvertisement = advertiserService.selectTotalAdvertisement(advertiser.getAdvertiserNo());
			String pagebar = CamperValleyUtils.getPagebar(cPage, numPerPage, totalAdvertisement, url);

			mav.addObject("advertiser", advertiser);
			mav.addObject("adList", adList);
			mav.addObject("pagebar", pagebar);
		} catch (Exception e) {
			log.error("광고주 대시보드 조회 오류", e);
			throw e;
		}

		return mav;
	}
	
	@GetMapping("/admoney")
	public ModelAndView loadAdmoneyPage(@RequestParam("no") int advertiserNo, ModelAndView mav) {
		Map<String, Object> param = new HashMap<>();
		try {
			Admoney admoney = advertiserService.selectOneAdmoney(advertiserNo);
			
			param.put("advertiserNo",advertiserNo);
			param.put("maxCancelAmount", admoney.getBalance());
			List<Pay> canRefundList = advertiserService.selectNotCanceledPay(param);

			mav.addObject("admoney", admoney);
			mav.addObject("canRefundList", canRefundList);
		} catch (Exception e) {
			log.error("애드머니충전 페이지 요청 오류", e);
			throw e;
		}
		return mav;
	}
	
	@PostMapping("/admoneyCharge")
	public ResponseEntity<?> chargeAdmoney(Pay pay) {
		Admoney admoney = null;
		try {

			// Pay 테이블 insert && Admoney 테이블 내의 결제회원의 잔액정보 update
			int result = advertiserService.chargeAdmoney(pay);

			// update처리된 잔액정보 조회
			admoney = advertiserService.selectOneAdmoney(pay.getAdvertiserNo());

		} catch (Exception e) {
			log.error("애드머니 충전내역 저장 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(admoney);
		}
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(admoney);
	};
	
	@Value("${api.impRestKey}")
	private String IMP_REST_KEY;
	
	@Value("${api.impRestSecret}")
	private String IMP_SECRET_KEY;
	
	final String IMP_TOKEN_URL = "https://api.iamport.kr/users/getToken";
	final String IMP_CANCEL_URL = "https://api.iamport.kr/payments/cancel";
	
	@ResponseBody
	@PostMapping("/refund")
	public ResponseEntity<?> refundAdmoney(@RequestParam(value = "merchantUidList[]") List<String> merchantUidList,
			@RequestParam(name = "advertiserNo") int advertiserNo, String reason) throws Exception {
		Admoney admoney = null;
		int result = 0;
		try {

			// 환불대상으로 지정한 pay 테이블 record 정보 SELECT
			List<Pay> payList = advertiserService.selectPayByMerchantUidList(merchantUidList);

			/* ---------------- API서버 결제정보 접근을 위한 access token 발급 요청 ---------------- */
			// 요청 헤더
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-type", "application/json");

			// 요청 Body에 전달할 data : REST API키, REST API Secret
			Map<String, String> tokenParams = new HashMap<>();
			tokenParams.put("imp_key", IMP_REST_KEY);
			tokenParams.put("imp_secret", IMP_SECRET_KEY);
			// Map에 담긴 data를 json 타입으로 변환
			String jsonTokenParams = new ObjectMapper().writeValueAsString(tokenParams);

			// 헤더와 데이터를 묶어 하나의 요청으로 생성
			HttpEntity<Map<String, String>> tokenRequest = new HttpEntity(jsonTokenParams, headers);

			// access token 발급 REST API 호출 (POST 방식)
			RestTemplate restTemplate = new RestTemplate();
			Map<String, Object> responseToken = (Map<String, Object>) restTemplate
					.postForObject(IMP_TOKEN_URL, tokenRequest, Map.class).get("response");

			// 응답객체에 담긴 access token 저장
			String ACCESS_TOKEN = (String) responseToken.get("access_token");

			/* ------------------------------ API서버 환불 요청 ------------------------------ */
			// access token 을 요청 헤더의 인증정보 속성으로 추가
			headers.add("Authorization", ACCESS_TOKEN);

			// 환불대상 결제 건별 환불 요청
			for (int i = 0; i < payList.size(); i++) {

				// 환불 요청 Body에 전달할 data : 환불사유, API서버 결제고유값, 환불금액
				Map<String, Object> params = new HashMap<>();
				params.put("reason", reason);
				params.put("imp_uid", payList.get(i).getImpUid());
				params.put("amount", payList.get(i).getPaidAmount());
				String jsonParams = new ObjectMapper().writeValueAsString(params);

				// 헤더와 데이터를 묶어 하나의 요청으로 생성
				HttpEntity<Map<String, String>> request = new HttpEntity(jsonParams, headers);

				// 환불 요청 REST API 호출 (POST 방식)
				Map<String, Object> response = restTemplate.postForObject(IMP_CANCEL_URL, request, Map.class);

				// 정상환불 code = 0
				if (String.valueOf(response.get("code")).equals("0")) {
					// 요청 결과가 '정상환불'일경우 DB 결제정보 테이블 UPDATE && Admoney 테이블 내의 결제회원의 잔액정보 UPDATE
					result = advertiserService.refundAdmoney(payList.get(i));
				} else {
					String errorMID = payList.get(i).getMerchantUid();
					return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMID);
				}
			}

			// 환불처리 종료 후 update된 잔액정보 조회
			admoney = advertiserService.selectOneAdmoney(advertiserNo);

		} catch (RestClientException e) {
			log.error("REST API 호출오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR) // 500
					.body(admoney);
		} catch (Exception e) {
			log.error("애드머니 환불처리 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR) // 500
					.body(admoney);
		}
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(admoney);
	}
	
	@GetMapping("/enrollAd")
	public void loadEnrollAdPage() {}

	@PostMapping("/enrollAd")
	public String submitEnrollAdFrm(AdvertisementExt advertisement, @RequestParam("adImg") MultipartFile upFile) throws Exception {
		log.debug("advertisement = {}", advertisement);
		log.debug("upFile = {}", upFile);
		
		try {
			String saveDirectory = application.getRealPath("/resources/upload/mypage/advertiser/advertisement");

			if (upFile.getSize() > 0) {
				String originalFilename = upFile.getOriginalFilename();
				String renamedFilename = CamperValleyUtils.getRenamedFilename(originalFilename);
				File destFile = new File(saveDirectory, renamedFilename);
				upFile.transferTo(destFile);

				AdAttach attach = new AdAttach();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				advertisement.setAdAttach(attach);
			}
			int result = advertiserService.insertAdvertisement(advertisement);
			
		} catch(Exception e) {
			log.error("광고소재 등록 오류", e);
			throw e;
		}
		return "redirect:/mypage/advertiser/dashboard";
	}
	
	@PostMapping("/deleteAd")
	public ResponseEntity<?> deleteAdvertisement(@RequestParam int advertisementNo) {
		Map<String, Object> map = new HashMap<>();
		try {
			int result = advertiserService.deleteAdvertisement(advertisementNo);
			map.put("msg", "광고소재가 정상적으로 삭제되었습니다.");
		} catch(Exception e) {
			log.error("광고소재 삭제처리 오류", e);
			map.put("msg", "광고소재 삭제처리 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}
	
	@PostMapping("/updateAd")
	public ResponseEntity<?> updateAdvertisement(Advertisement advertisement) {
		log.debug("advertisement = {}", advertisement);
		Map<String, Object> map = new HashMap<>();
		try {
			int result = advertiserService.updateAdvertisement(advertisement);
		} catch(Exception e) {
			log.error("광고소재 정보변경 오류", e);
			map.put("msg", "광고소재 정보변경 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}
	
	@PostMapping("/checkBalance")
	public ResponseEntity<?> checkBalanceAndCpc(Advertisement advertisement, @AuthenticationPrincipal Member loginMember) {
		log.debug("advertisement = {}", advertisement);
		Map<String, Object> map = new HashMap<>();
		try {
			boolean result = advertiserService.checkBalanceAndCpc(advertisement, loginMember.getMemberId());
			map.put("result", result);
			if(!result) {
				map.put("msg", "입력한 CPC대비 잔여 애드머니가 부족하여 광고소재 상태를 변경 할 수 없습니다.");				
			}
		} catch(Exception e) {
			log.error("CPC-잔여애드머니 비교 오류", e);
			map.put("msg", "CPC-잔여애드머니 비교 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}

	@PostMapping("/viewUp")
	public ResponseEntity<?> viewUp(int advertisementNo) {
		log.debug("advertisementNo = {}", advertisementNo);
		Map<String, Object> map = new HashMap<>();
		try {
			int result = advertiserService.updatePerformView(advertisementNo);
			map.put("msg", "[" + advertisementNo + "] 조회수 증가완료");
		} catch (Exception e) {
			log.error("광고 조회수 업데이트 오류", e);
			map.put("msg", "[" + advertisementNo + "] 조회수 증가 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	};

	@PostMapping("/clickUp")
	public ResponseEntity<?> clickUp(int advertisementNo) {
		log.debug("advertisementNo = {}", advertisementNo);
		Map<String, Object> map = new HashMap<>();
		try {
			int result = advertiserService.updatePerformClick(advertisementNo);
			map.put("msg", "[" + advertisementNo + "] 클릭수 증가완료");
		} catch (Exception e) {
			log.error("광고 클릭수 업데이트 오류", e);
			map.put("msg", "[" + advertisementNo + "] 클릭수 증가 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}

	@PostMapping("/searchChart")
	public ResponseEntity<?> searchChartData(int advertiserNo, String date1, String date2) {
		Map<String, Object> map = new HashMap<>();
		try {
			LocalDate startDate = LocalDate.parse(date1, DateTimeFormatter.ISO_DATE);
			LocalDate endDate = LocalDate.parse(date2, DateTimeFormatter.ISO_DATE);
			if (!startDate.isBefore(endDate)) {
				startDate = LocalDate.parse(date2, DateTimeFormatter.ISO_DATE);
				endDate = LocalDate.parse(date1, DateTimeFormatter.ISO_DATE);
			}
			Period period = Period.between(startDate, endDate);

			Map<String, Object> chartParam = new HashMap<>();
			chartParam.put("advertiserNo", advertiserNo);
			chartParam.put("startDate", startDate);
			chartParam.put("endDate", endDate);
			List<Map<String, Object>> chartData = advertiserService.selectChartData(chartParam);

			List<String> dateList = new ArrayList<>();
			List<Integer> viewList = new ArrayList<>();
			List<Integer> clickList = new ArrayList<>();
			for (int i = 0; i < period.getDays() + 1; i++) {
				dateList.add(endDate.minusDays(period.getDays() - i).toString());
				viewList.add(0);
				clickList.add(0);
				for (int j = 0; j < chartData.size(); j++) {
					String date = chartData.get(j).get("DISPLAY_AT").toString().substring(0, 10);
					if (date.equals(endDate.minusDays(period.getDays() - i).toString())) {
						viewList.set(i, Integer.parseInt(chartData.get(j).get("SUM_VIEW").toString()));
						clickList.set(i, Integer.parseInt(chartData.get(j).get("SUM_CLICK").toString()));
						break;
					}
				}
			}
			map.put("dateList", dateList);
			map.put("viewList", viewList);
			map.put("clickList", clickList);
		} catch (Exception e) {
			log.error("차트 기간조회 오류", e);
			map.put("msg", "차트 기간조회 오류");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
		}
		return ResponseEntity.status(HttpStatus.OK).header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE).body(map);
	}

}
