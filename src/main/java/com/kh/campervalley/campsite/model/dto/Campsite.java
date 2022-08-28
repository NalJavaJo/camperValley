package com.kh.campervalley.campsite.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Campsite {
	@NonNull
	private long contentId;			// 콘텐츠ID
	private String facltNm;			// 야영장명
	private String lineIntro;		// 한줄소개
	private String intro;			// 소개
	private String facltDivNm;		// 사업주체구분
	private String induty;			// 업종
	private String lctCl;			// 입지구분
	private String addr1;			// 주소
	private String addr2;			// 주소상세
	private String mapX;			// 경도(X)
	private String mapY;			// 위도(Y)
	private String tel;				// 전화
	private String homepage;		// 홈페이지
	private String resveCl;			// 예약구분
	private String operPdCl;		// 운영기간
	private String operDeCl;		// 운영일
	private String posblFcltyCl;	// 주변이용가능시설
	private String themaEnvrnCl; 	// 테마환경
	private String firstImageUrl; 	// 대표이미지
}
