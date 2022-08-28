package com.kh.campervalley.mypage.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.community.camper.model.dto.Camper;
import com.kh.campervalley.community.camper.model.dto.Status;
import com.kh.campervalley.community.review.model.dto.CampsiteReviewExt;
import com.kh.campervalley.mypage.community.model.dto.CampsiteBookmarkExt;

import lombok.NonNull;

@Mapper
public interface MypageCommunityDao {

	// --------------------- EJ start
	List<CampsiteBookmarkExt> selectCampsiteBookmark(String memberId, RowBounds rowBounds);
	
	@Select("select count(*) from campsite_bookmark where member_id = #{memberId}")
	int getTotalCampsiteBookmark(String memberId);
	// --------------------- EJ end
	
	@Select("select count(*) from camper where member_id = #{memberId}")
	int selectTotalMyCamper(@NonNull String memberId);

	@Select("select * from camper where member_id = #{memberId} order by camper_no desc")
	List<Camper> selectMyCamperList(String memberId, RowBounds rowBounds);

	@Select("select r.*, (select count(*) from review_comment where review_no = r.review_no) comment_count, (select count(*) from review_recommend where review_no = r.review_no and status = 'Y') recommend_count from campsite_review r where member_id=#{memberId} order by r.review_no desc")
	List<CampsiteReviewExt> selectMyReviewList(@NonNull String memberId, RowBounds rowBounds);

	@Select("select count(*) from campsite_review where member_id = #{memberId}")
	int selectTotalMyReview(@NonNull String memberId);

	@Update("update camper set status = #{status} where camper_no = #{camperNo}")
	int updateCamperStatusByCamperNo(Camper camper);

	List<Camper> searchMyCamperList(Map<String, Object> map, RowBounds rowBounds);
	
	List<CampsiteReviewExt> searchMyReviewList(Map<String, Object> map, RowBounds rowBounds);

	int searchTotalMyCamper(Map<String, Object> map);
	
	int searchTotalMyReview(Map<String, Object> map);

}
