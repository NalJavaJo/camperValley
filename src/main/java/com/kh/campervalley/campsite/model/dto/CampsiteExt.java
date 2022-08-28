package com.kh.campervalley.campsite.model.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class CampsiteExt extends Campsite {
	private CampsiteFacility campsiteFacility;
	private CampsiteImage campsiteImage;
	private List<CampsiteFacility> facilities = new ArrayList<>();
	
	public CampsiteExt(@NonNull long contentId, String facltNm, String lineIntro, String intro, String facltDivNm,
			String induty, String lctCl, String addr1, String addr2, String mapX, String mapY, String tel,
			String homepage, String resveCl, String operPdCl, String operDeCl, String posblFcltyCl, String themaEnvrnCl,
			String firstImageUrl) {
		super(contentId, facltNm, lineIntro, intro, facltDivNm, induty, lctCl, addr1, addr2, mapX, mapY, tel, homepage, resveCl,
				operPdCl, operDeCl, posblFcltyCl, themaEnvrnCl, firstImageUrl);
		// TODO Auto-generated constructor stub
	}
	
	public CampsiteExt(@NonNull long contentId, String facltNm, String lineIntro, String intro, String facltDivNm,
			String induty, String lctCl, String addr1, String addr2, String mapX, String mapY, String tel,
			String homepage, String resveCl, String operPdCl, String operDeCl, String posblFcltyCl, String themaEnvrnCl,
			String firstImageUrl, CampsiteFacility campsiteFacility, CampsiteImage campsiteImage, List<CampsiteFacility> facilities) {
		super(contentId, facltNm, lineIntro, intro, facltDivNm, induty, lctCl, addr1, addr2, mapX, mapY, tel, homepage, resveCl,
				operPdCl, operDeCl, posblFcltyCl, themaEnvrnCl, firstImageUrl);
		this.campsiteFacility = campsiteFacility;
		this.campsiteImage = campsiteImage;
		this.facilities = facilities;
	}
	
	public void addCampsiteFacility(@NonNull CampsiteFacility facility) {
		facilities.add(facility);
	}
	
}
