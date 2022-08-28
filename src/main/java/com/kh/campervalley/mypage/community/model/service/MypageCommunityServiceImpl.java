package com.kh.campervalley.mypage.community.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.dto.Status;
import com.kh.campervalley.community.review.model.dto.CampsiteReviewExt;
import com.kh.campervalley.mypage.community.model.dao.MypageCommunityDao;
import com.kh.campervalley.mypage.community.model.dto.CampsiteBookmarkExt;

import lombok.NonNull;

@Service
public class MypageCommunityServiceImpl implements MypageCommunityService{
	@Autowired
	MypageCommunityDao mypageCommunityDao;
	
	// --------------------- EJ start
	@Override
	public List<CampsiteBookmarkExt> selectCampsiteBookmark(String memberId, int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return mypageCommunityDao.selectCampsiteBookmark(memberId, rowBounds);
	}
	
	@Override
	public int getTotalCampsiteBookmark(String memberId) {
		return mypageCommunityDao.getTotalCampsiteBookmark(memberId);
	}
	// --------------------- EJ end
	
	@Override
	public List<Camper> selectMyCamperList(int cPage, int numPerPage, String memberId) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		
		return mypageCommunityDao.selectMyCamperList(memberId, rowBounds) ;
	}

	@Override
	public int selectTotalMyCamper(@NonNull String memberId) {
		return mypageCommunityDao.selectTotalMyCamper(memberId);
	}

	@Override
	public List<CampsiteReviewExt> selectMyReviewList(int cPage, int numPerPage, @NonNull String memberId) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		
		return mypageCommunityDao.selectMyReviewList(memberId, rowBounds);
	}

	@Override
	public int selectTotalMyReview(@NonNull String memberId) {
		return mypageCommunityDao.selectTotalMyReview(memberId);
	}

	@Override
	public int updateCamperStatusByCamperNo(Camper camper) {
		return mypageCommunityDao.updateCamperStatusByCamperNo(camper);
	}

	@Override
	public List<Camper> searchMyCamperList(int cPage, int numPerPage, Map<String, Object> map) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return mypageCommunityDao.searchMyCamperList(map, rowBounds);
	}

	@Override
	public int searchTotalMyCamper(Map<String, Object> map) {
		return mypageCommunityDao.searchTotalMyCamper(map);
	}

	@Override
	public List<CampsiteReviewExt> searchMyReviewList(int cPage, int numPerPage, Map<String, Object> map) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return mypageCommunityDao.searchMyReviewList(map, rowBounds);
	}

	@Override
	public int searchTotalMyReview(Map<String, Object> map) {
		return mypageCommunityDao.searchTotalMyReview(map);
	}

}
