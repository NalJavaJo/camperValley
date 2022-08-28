package com.kh.campervalley.campsite.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campervalley.campsite.model.dto.CampsiteExt;
import com.kh.campervalley.campsite.model.dto.CampsiteFacility;
import com.kh.campervalley.campsite.model.dto.CampsiteImage;

@Mapper
public interface CampsiteDao {

	int insertCampsite(CampsiteExt campsite);
	
	int insertCampsiteFacility(CampsiteFacility campsiteFacility);

	@Delete("delete from campsite")
	int campsiteListReset();
	
	@Select("select content_id from campsite")
	List<CampsiteExt> selectContentIdList();
	
	int insertCampsiteImage(CampsiteImage campsiteImage);
	
	List<CampsiteExt> recentCampsiteList();
	
	List<CampsiteExt> searchCampsiteList(Map<String, Object> searchParam);
	
	List<CampsiteExt> searchCampsiteThemeList(Map<String, Object> searchParam);
	
	CampsiteExt selectOneCampsite(long contentId);

	List<CampsiteImage> selectCampsiteImageListByContentId(long contentId);

	CampsiteFacility selectOneCampsiteFacility(long contentId);

	// --------------------- EJ start
	@Insert("insert into campsite_bookmark values (seq_campsite_bookmark_no.nextval, #{memberId}, #{contentId})")
	int insertBookmark(Map<String, Object> param);
	
	@Delete("delete from campsite_bookmark where member_id = #{memberId} and content_id = #{contentId}")
	int deleteBookmark(Map<String, Object> param);
	
	@Select("select count(*) from campsite_bookmark where member_id = #{memberId} and content_id = #{contentId}")
	Boolean isBookmark(Map<String, Object> param);
	// --------------------- EJ end
	
}
