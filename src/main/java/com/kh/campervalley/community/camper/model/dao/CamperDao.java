package com.kh.campervalley.community.camper.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.dto.CamperExt;

@Mapper
public interface CamperDao {

	int insertCamper(Camper camper);

	List<CamperExt> selectCamperList(RowBounds rowBounds);

	List<CamperExt> selectMoreCamperList(RowBounds rowBounds, Map<String, Object> param);

	CamperExt selectCamperOne(int camperNo);

	int deleteCamper(int camperNo);

	int updateCamper(Camper camper);

}
