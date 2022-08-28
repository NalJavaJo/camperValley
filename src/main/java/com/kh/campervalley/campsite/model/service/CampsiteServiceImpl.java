package com.kh.campervalley.campsite.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campervalley.campsite.model.dao.CampsiteDao;
import com.kh.campervalley.campsite.model.dto.CampsiteExt;
import com.kh.campervalley.campsite.model.dto.CampsiteFacility;
import com.kh.campervalley.campsite.model.dto.CampsiteImage;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CampsiteServiceImpl implements CampsiteService {

	@Autowired
	private CampsiteDao campsiteDao;
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertCampsiteList(List<CampsiteExt> campsiteList) {
		int result = 0;
		for(int i = 0; i < campsiteList.size(); i++) {
			result = campsiteDao.insertCampsite(campsiteList.get(i));
			result = campsiteDao.insertCampsiteFacility(campsiteList.get(i).getCampsiteFacility());
		}
		return result;
	}
	
	@Override
	public int campsiteListReset() {
		return campsiteDao.campsiteListReset();
	}
	
	@Override
	public List<CampsiteExt> selectContentIdList() {
		return campsiteDao.selectContentIdList();
	}
	
	@Override
	public int insertCampsiteImage(CampsiteImage campImage) {
		return campsiteDao.insertCampsiteImage(campImage);
	}
	
	@Override
	public List<CampsiteExt> recentCampsiteList() {
		return campsiteDao.recentCampsiteList();
	}

	@Override
	public List<CampsiteExt> searchCampsiteList(Map<String, Object> searchParam) {
		return campsiteDao.searchCampsiteList(searchParam);
	}
	
	@Override
	public List<CampsiteExt> searchCampsiteThemeList(Map<String, Object> searchParam) {
		return campsiteDao.searchCampsiteThemeList(searchParam);
	}
	
	@Override
	public CampsiteExt selectOneCampsite(long contentId) {
		return campsiteDao.selectOneCampsite(contentId);
	}
	
	@Override
	public List<CampsiteImage> selectCampsiteImageListByContentId(long contentId) {
		return campsiteDao.selectCampsiteImageListByContentId(contentId);
	}
	
	@Override
	public CampsiteFacility selectOneCampsiteFacility(long contentId) {
		return campsiteDao.selectOneCampsiteFacility(contentId);
	}
	
	// --------------------- EJ start
	@Override
	public int insertBookmark(Map<String, Object> param) {
		return campsiteDao.insertBookmark(param);
	}
	
	@Override
	public int deleteBookmark(Map<String, Object> param) {
		return campsiteDao.deleteBookmark(param);
	}
	
	@Override
	public Boolean isBookmark(Map<String, Object> param) {
		return campsiteDao.isBookmark(param);
	}
	// --------------------- EJ end
}
