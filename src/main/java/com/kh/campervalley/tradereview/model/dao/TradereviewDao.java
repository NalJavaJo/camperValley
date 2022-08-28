package com.kh.campervalley.tradereview.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.tradereview.model.dto.ReviewReport;
import com.kh.campervalley.tradereview.model.dto.TradeReview;
import com.kh.campervalley.tradereview.model.dto.TradeReviewExt;

@Mapper
public interface TradereviewDao {

	int insertReview(TradeReview tradeReview);

	int deleteReview(int reviewNo);

	int updateReview(TradeReview tradeReview);

	TradeReviewExt getProfileInfo(String memberId);

	Map<String, Object> selectCounts(String memberId);

	List<TradeReviewExt> selectReviewListByMemberId(RowBounds rowBounds, String memberId);

	int selectTotalReviewByMemberId(String memberId);

	int insertReport(ReviewReport reviewReport);

}
