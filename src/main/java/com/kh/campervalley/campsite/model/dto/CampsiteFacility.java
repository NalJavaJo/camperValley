package com.kh.campervalley.campsite.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CampsiteFacility {
	@NonNull
	private long contentId;			// 콘텐츠ID
	private int gnrlSiteCo;			// 주요시설 일반야영장
	private int autoSiteCo;			// 주요시설 자동차야영장
	private int glampSiteCo;		// 주요시설 글램핑
	private int caravSiteCo;		// 주요시설 카라반
	private int indvdlCaravSiteCo;	// 주요시설 개인 카라반
	private int siteMg1Width;		// 사이트 크기1 가로
	private int siteMg2Width;		// 사이트 크기2 가로
	private int siteMg3Width;		// 사이트 크기3 가로
	private int siteMg1Vrticl;		// 사이트 크기1 세로
	private int siteMg2Vrticl;		// 사이트 크기2 세로
	private int siteMg3Vrticl;		// 사이트 크기3 세로
	private int siteMg1Co;			// 사이트 크기1 수량
	private int siteMg2Co;			// 사이트 크기2 수량
	private int siteMg3Co;			// 사이트 크기3 수량
	private int siteBottomCl1;		// 잔디
	private int siteBottomCl2;		// 파쇄석
	private int siteBottomCl3;		// 테크
	private int siteBottomCl4;		// 자갈
	private int siteBottomCl5;		// 맨흙
	private String glampInnerFclty;	// 글램핑내부시설
	private String caravInnerFclty;	// 카라반내부시설
	private String trlerAcmpnyAt;	// 개인트레일러동반여부
	private String caravAcmpnyAt;	// 개인카라반동반여부
	private int toiletCo;			// 화장실개수
	private int swrmCo;				// 샤워실개수
	private int wtrplCo;			// 개수대개수
	private String brazierCl;		// 화로대
	private String sbrsCl;			// 부대시설
	private String sbrsEtc;			// 부대시설기타
	private int extshrCo;			// 소화기개수
	private int frprvtWrppCo;		// 방화수개수
	private int frprvtSandCo;		// 방화사개수
	private String eqpmnLendCl;		// 캠핑장비대여
	private String animalCmgCl;		// 애완동물출입
}
