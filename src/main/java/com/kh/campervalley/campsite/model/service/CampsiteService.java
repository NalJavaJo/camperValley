package com.kh.campervalley.campsite.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campervalley.campsite.model.dto.CampsiteExt;
import com.kh.campervalley.campsite.model.dto.CampsiteFacility;
import com.kh.campervalley.campsite.model.dto.CampsiteImage;

public interface CampsiteService {
	
	int insertCampsiteList(List<CampsiteExt> campsiteList);

	int campsiteListReset();

	List<CampsiteExt> selectContentIdList();
	
	int insertCampsiteImage(CampsiteImage campImage);
	
	List<CampsiteExt> recentCampsiteList();
	
	List<CampsiteExt> searchCampsiteList(Map<String, Object> searchParam);
	
	List<CampsiteExt> searchCampsiteThemeList(Map<String, Object> searchParam);
	
	CampsiteExt selectOneCampsite(long contentId);

	List<CampsiteImage> selectCampsiteImageListByContentId(long contentId);

	CampsiteFacility selectOneCampsiteFacility(long contentId);

	// --------------------- EJ start
	int insertBookmark(Map<String, Object> param);

	int deleteBookmark(Map<String, Object> param);
	
	Boolean isBookmark(Map<String, Object> param);
	// --------------------- EJ end
}
