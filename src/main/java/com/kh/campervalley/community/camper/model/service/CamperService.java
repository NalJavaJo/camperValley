package com.kh.campervalley.community.camper.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.dto.CamperExt;

public interface CamperService {

	int CAMPER_NUM_PER_PAGE = 5;
	
	int insertCamper(Camper camper);

	List<CamperExt> selectCamperList(int numPerPage);

	List<CamperExt> selectMoreCamperList(int cPage, int numPerPage, Map<String, Object> param);

	CamperExt selectCamperOne(int camperNo);

	int deleteCamper(int camperNo);

	int updateCamper(Camper camper);
	
}
