package com.kh.campervalley.mypage.community.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.dto.Status;
import com.kh.campervalley.community.review.model.dto.CampsiteReviewExt;
import com.kh.campervalley.mypage.community.model.dto.CampsiteBookmarkExt;

import lombok.NonNull;

public interface MypageCommunityService {
	public static final int MY_CAMPER_NUM_PER_PAGE = 10;
	public static final int MY_REVIEW_NUM_PER_PAGE = 10;
	public static final int MY_BOOKMARK_NUM_PER_PAGE = 5;
	// --------------------- EJ start
	public List<CampsiteBookmarkExt> selectCampsiteBookmark(String memberId, int cPage, int numPerPage);
	public int getTotalCampsiteBookmark(String memberId);
	// --------------------- EJ end
	public List<Camper> selectMyCamperList(int cPage, int limit, String memberId);
	public int selectTotalMyCamper(@NonNull String memberId);
	public List<CampsiteReviewExt> selectMyReviewList(int cPage, int numPerPage, @NonNull String memberId);
	public int selectTotalMyReview(@NonNull String memberId);
	public int updateCamperStatusByCamperNo(Camper camper);
	public List<Camper> searchMyCamperList(int cPage, int numPerPage, Map<String, Object> map);
	public int searchTotalMyCamper(Map<String, Object> map);
	public List<CampsiteReviewExt> searchMyReviewList(int cPage, int numPerPage, Map<String, Object> map);
	public int searchTotalMyReview(Map<String, Object> map);
}
