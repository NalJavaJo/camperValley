package com.kh.campervalley.community.camper.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campervalley.community.camper.model.dao.CamperDao;
import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.dto.CamperExt;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CamperServiceImpl implements CamperService {

	@Autowired
	private CamperDao camperDao;

	@Override
	public int insertCamper(Camper camper) {
		return camperDao.insertCamper(camper);
	}

	@Override
	public List<CamperExt> selectCamperList(int numPerPage) {
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(0, limit);
		return camperDao.selectCamperList(rowBounds);
	}

	@Override
	public List<CamperExt> selectMoreCamperList(int cPage, int numPerPage, Map<String, Object> param) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return camperDao.selectMoreCamperList(rowBounds, param);
	}

	@Override
	public CamperExt selectCamperOne(int camperNo) {
		return camperDao.selectCamperOne(camperNo);
	}

	@Override
	public int deleteCamper(int camperNo) {
		return camperDao.deleteCamper(camperNo);
	}

	@Override
	public int updateCamper(Camper camper) {
		return camperDao.updateCamper(camper);
	}
	
}
