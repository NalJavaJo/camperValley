package com.kh.campervalley.community.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.community.review.model.dto.CampsiteReview;
import com.kh.campervalley.community.review.model.dto.CampsiteReviewExt;
import com.kh.campervalley.community.review.model.dto.ReviewComment;
import com.kh.campervalley.community.review.model.dto.ReviewPhoto;
import com.kh.campervalley.community.review.model.dto.ReviewRecommend;

@Mapper
public interface ReviewDao {
	
	List<Map<String, Object>> autoComplete(Map<String, Object> paramMap);

	int insertReview(CampsiteReviewExt review);

	int insertReviewPhoto(ReviewPhoto photo);

	List<CampsiteReview> selectReviewList(RowBounds rowBounds);

	int selectTotalReview();

	List<CampsiteReview> searchReviewList(Map<String, Object> searchParam, RowBounds rowBounds);

	int searchTotalReview(Map<String, Object> searchParam);

	int updateReadCount(int reviewNo);
	
	CampsiteReviewExt selectOneReview(int reviewNo);

	ReviewPhoto selectOneReviewPhoto(int reviewPhotoNo);

	int deleteReviewPhoto(int reviewPhotoNo);

	int updateReview(CampsiteReviewExt review);

	int deleteReview(int reviewNo);

	int insertReviewComment(ReviewComment comment);

	int deleteReviewComment(int reviewCommentNo);

	int updateReviewComment(ReviewComment comment);

	ReviewRecommend recommendCheck(Map<String, Object> param);

	int insertReviewRecommend(Map<String, Object> param);

	int setReviewRecommendStatusY(ReviewRecommend recommend);

	int setReviewRecommendStatusN(ReviewRecommend recommend);

	List<ReviewComment> selectReviewCommentList(int reviewNo);

	List<ReviewPhoto> selectReviewPhotoList(int reviewNo);

}
