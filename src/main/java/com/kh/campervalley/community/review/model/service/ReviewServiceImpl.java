package com.kh.campervalley.community.review.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campervalley.community.review.model.dao.ReviewDao;
import com.kh.campervalley.community.review.model.dto.CampsiteReview;
import com.kh.campervalley.community.review.model.dto.CampsiteReviewExt;
import com.kh.campervalley.community.review.model.dto.ReviewPhoto;

@Service
@Transactional(rollbackFor = Exception.class)
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public List<Map<String, Object>> autoComplete(Map<String, Object> paramMap) {
		return reviewDao.autoComplete(paramMap);
	}
	
	@Override
	public int insertReview(CampsiteReviewExt review) {
		int result = reviewDao.insertReview(review);
		
		List<ReviewPhoto> photos = review.getPhotos();
		if(!photos.isEmpty()) {
			for(ReviewPhoto photo : photos) {
				photo.setReviewNo(review.getReviewNo());
				result = reviewDao.insertReviewPhoto(photo);
			}
		}
		return result;
	}
	
	@Override
	public List<CampsiteReview> selectReviewList(int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return reviewDao.selectReviewList(rowBounds);
	}
	
	@Override
	public int selectTotalReview() {
		return reviewDao.selectTotalReview();
	}
	
	@Override
	public List<CampsiteReview> searchReviewList(Map<String, Object> searchParam, int cPage, int numPerPage) {
		int offset = (cPage - 1) * numPerPage;
		int limit = numPerPage;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return reviewDao.searchReviewList(searchParam, rowBounds);
	}
	
	@Override
	public int searchTotalReview(Map<String, Object> searchParam) {
		return reviewDao.searchTotalReview(searchParam);
	}
	
	@Override
	public int updateReadCount(int reviewNo) {
		// TODO Auto-generated method stub
		return reviewDao.updateReadCount(reviewNo);
	}
	
	@Override
	public CampsiteReviewExt selectOneReview(int reviewNo) {
		return reviewDao.selectOneReview(reviewNo);
	}
	
	@Override
	public ReviewPhoto selectOneReviewPhoto(int reviewPhotoNo) {
		return reviewDao.selectOneReviewPhoto(reviewPhotoNo);
	}
	
	@Override
	public int deleteReviewPhoto(int reviewPhotoNo) {
		return reviewDao.deleteReviewPhoto(reviewPhotoNo);
	}
	
	@Override
	public int updateReview(CampsiteReviewExt review) {
		int result = reviewDao.updateReview(review);
		List<ReviewPhoto> photos = review.getPhotos();
		if(!photos.isEmpty()) {
			for(ReviewPhoto photo : photos) {
				result = reviewDao.insertReviewPhoto(photo);
			}
		}
		return result;
	}
	
	@Override
	public int deleteReview(int reviewNo) {
		return reviewDao.deleteReview(reviewNo);
	}
	
}
