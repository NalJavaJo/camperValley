package com.kh.campervalley.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.admin.model.dto.Todo;
import com.kh.campervalley.cs.model.dto.NoticeExt;
import com.kh.campervalley.member.model.dto.Member;

@Mapper
public interface AdminDao {

	List<Member> selectMemberList(Map<String, Object> map, RowBounds rowBounds);

	Member selectOneMember(String memberId);

	int memberUpdate(Member memberId);

	List<NoticeExt> selectProductList(Map<String, Object> map, RowBounds rowBounds);

	int selectTotalProductList(Map<String, Object> map);

	int productDelete(Integer productNo);

	int camperDelete(Integer camperNo);

	List<NoticeExt> selectCamperList(Map<String, Object> map, RowBounds rowBounds);

	int selectTotalCamperList(Map<String, Object> map);

	int reviewDelete(Integer reviewNo);

	List<NoticeExt> selectReviewList(Map<String, Object> map, RowBounds rowBounds);

	int selectTotalReviewList(Map<String, Object> map);

	int deleteMemberRole(Map<String, Object> map);

	int insertAuthority(Map<String, Object> map);

	int deleteBlack(Map<String, Object> map);

	int insertBlack(Map<String, Object> map);

	int selectTotalMemberList(Map<String, Object> map);
	
	int insertTodo(Todo todo);

	List<Todo> selectTodoList();

	int updateTodo(Map<String, Object> param);

	int deleteTodo(int todoNo);

	List<Member> selectReportList(Map<String, Object> map, RowBounds rowBounds);

	int deleteBuyerBlack(Map<String, Object> map);

	int insertBuyerBlack(Map<String, Object> map);

	int updateReport(int reportNo);

	int selectTotalReportList(Map<String, Object> map);

	@Select("select count(*) from camper where created_at >= TO_CHAR(sysdate -7, 'yyyy-mm-dd')")
	int todayCamper();

	@Select("select count(*) from campsite_review where created_at >= TO_CHAR(sysdate -7, 'yyyy-mm-dd')")
	int todayReview();

	@Select("select count(*) from used_product where product_enroll_time >= TO_CHAR(sysdate -7, 'yyyy-mm-dd')")
	int todayProduct();

	@Select("select count(*) from member where enroll_date >= TO_CHAR(LOCALTIMESTAMP, 'yyyy-mm-dd')")
	int sysdate();

	@Select("select count(*) from member where to_date(enroll_date, 'yyyy-mm-dd') between to_date(LOCALTIMESTAMP -1, 'yyyy-mm-dd') and to_date(LOCALTIMESTAMP -1, 'yyyy-mm-dd')")
	int minus1();
	
	@Select("select count(*) from member where to_date(enroll_date, 'yyyy-mm-dd') between to_date(LOCALTIMESTAMP -2, 'yyyy-mm-dd') and to_date(LOCALTIMESTAMP -2, 'yyyy-mm-dd')")
	int minus2();
	
	@Select("select count(*) from member where to_date(enroll_date, 'yyyy-mm-dd') between to_date(LOCALTIMESTAMP -3, 'yyyy-mm-dd') and to_date(LOCALTIMESTAMP -3, 'yyyy-mm-dd')")
	int minus3();
	
	@Select("select count(*) from member where to_date(enroll_date, 'yyyy-mm-dd') between to_date(LOCALTIMESTAMP -4, 'yyyy-mm-dd') and to_date(LOCALTIMESTAMP -4, 'yyyy-mm-dd')")
	int minus4();
	
	@Select("select count(*) from member where to_date(enroll_date, 'yyyy-mm-dd') between to_date(LOCALTIMESTAMP -5, 'yyyy-mm-dd') and to_date(LOCALTIMESTAMP -5, 'yyyy-mm-dd')")
	int minus5();

	@Select("select count(*) from member where to_date(enroll_date, 'yyyy-mm-dd') between to_date(LOCALTIMESTAMP -6, 'yyyy-mm-dd') and to_date(LOCALTIMESTAMP -6, 'yyyy-mm-dd')")
	int minus6();

	@Select("select * from (select * from notice order by created_at desc) where rownum <= 4")
	List<NoticeExt> selectNoticeList();

	@Select("select nvl(sum(paid_amount), 0) from pay where to_char(to_date('19700101090000', 'YYYYMMDDHH24MISS') +(paid_at/86400),'yyyy-mm-dd') between to_char(sysdate, 'yyyy-mm-dd') and to_char(sysdate, 'yyyy-mm-dd') and status = 'paid'")
	int adSysdate();
	
	@Select("select nvl(sum(paid_amount), 0) from pay where to_char(to_date('19700101090000', 'YYYYMMDDHH24MISS') +(paid_at/86400),'yyyy-mm-dd') between to_char(sysdate -1, 'yyyy-mm-dd') and to_char(sysdate -1, 'yyyy-mm-dd') and status = 'paid'")
	int adMinus1();
	
	@Select("select nvl(sum(paid_amount), 0) from pay where to_char(to_date('19700101090000', 'YYYYMMDDHH24MISS') +(paid_at/86400),'yyyy-mm-dd') between to_char(sysdate -2, 'yyyy-mm-dd') and to_char(sysdate -2, 'yyyy-mm-dd') and status = 'paid'")
	int adMinus2();

	@Select("select nvl(sum(paid_amount), 0) from pay where to_char(to_date('19700101090000', 'YYYYMMDDHH24MISS') +(paid_at/86400),'yyyy-mm-dd') between to_char(sysdate -3, 'yyyy-mm-dd') and to_char(sysdate -3, 'yyyy-mm-dd') and status = 'paid'")
	int adMinus3();

	@Select("select nvl(sum(paid_amount), 0) from pay where to_char(to_date('19700101090000', 'YYYYMMDDHH24MISS') +(paid_at/86400),'yyyy-mm-dd') between to_char(sysdate -4, 'yyyy-mm-dd') and to_char(sysdate -4, 'yyyy-mm-dd') and status = 'paid'")
	int adMinus4();

	@Select("select nvl(sum(paid_amount), 0) from pay where to_char(to_date('19700101090000', 'YYYYMMDDHH24MISS') +(paid_at/86400),'yyyy-mm-dd') between to_char(sysdate -5, 'yyyy-mm-dd') and to_char(sysdate -5, 'yyyy-mm-dd') and status = 'paid'")
	int adMinus5();

}
