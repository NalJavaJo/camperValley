package com.kh.campervalley.tradereview.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campervalley.tradereview.model.dao.TradereviewDao;
import com.kh.campervalley.tradereview.model.dto.ReviewReport;
import com.kh.campervalley.tradereview.model.dto.TradeReview;
import com.kh.campervalley.tradereview.model.dto.TradeReviewExt;

@Service
public class TradereviewServiceImpl implements TradereviewService {

	@Autowired
	private TradereviewDao tradereviewDao;

	@Override
	public int insertReview(TradeReview tradeReview) {
		return tradereviewDao.insertReview(tradeReview);
	}

	@Override
	public int deleteReview(int reviewNo) {
		return tradereviewDao.deleteReview(reviewNo);
	}

	@Override
	public int updateReview(TradeReview tradeReview) {
		return tradereviewDao.updateReview(tradeReview);
	}

	@Override
	public TradeReviewExt getProfileInfo(String no) {
		return tradereviewDao.getProfileInfo(no);
	} 
	
	@Override
	public Map<String, Object> selectCounts(String no) {
		return tradereviewDao.selectCounts(no);
	}

	@Override
	public List<TradeReviewExt> selectReviewListByMemberId(int cPage, int numPerPage, String memberId) {
		int offset = (cPage - 1) * numPerPage;
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return tradereviewDao.selectReviewListByMemberId(rowBounds, memberId);
	}
	
	@Override
	public int selectTotalReviewByMemberId(String memberId) {
		return tradereviewDao.selectTotalReviewByMemberId(memberId);
	}

	@Override
	public int insertReport(ReviewReport reviewReport) {
		return tradereviewDao.insertReport(reviewReport);
	}

}
