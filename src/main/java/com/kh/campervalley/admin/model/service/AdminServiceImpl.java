package com.kh.campervalley.admin.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campervalley.admin.model.dao.AdminDao;
import com.kh.campervalley.admin.model.dto.Todo;
import com.kh.campervalley.cs.model.dto.NoticeExt;
import com.kh.campervalley.member.model.dto.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminDao adminDao;
	
	@Override
	public List<Member> selectMemberList(Map<String, Object> map) {
		int offset = (int)map.get("offset");
		int numPerPage = (int)map.get("numPerPage");
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return adminDao.selectMemberList(map, rowBounds);
	}
	
	@Override
	public int selectTotalMemberList(Map<String, Object> map) {
		return adminDao.selectTotalMemberList(map);
	}
	
	@Override
	public Member selectOneMember(String memberId) {
		return adminDao.selectOneMember(memberId);
	}
	
	@Override
	public int memberUpdate(Member memberId) {
		return adminDao.memberUpdate(memberId);
	}
	
	@Override
	public List<NoticeExt> selectProductList(Map<String, Object> map) {
		int offset = (int)map.get("offset");
		int numPerPage = (int)map.get("numPerPage");
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return adminDao.selectProductList(map, rowBounds);
	}
	
	@Override
	public int selectTotalProductList(Map<String, Object> map) {
		return adminDao.selectTotalProductList(map);
	}
	
	@Override
	public int productDelete(Integer productNo) {
		return (int) adminDao.productDelete(productNo);
	}
	
	@Override
	public List<NoticeExt> selectCamperList(Map<String, Object> map) {
		int offset = (int)map.get("offset");
		int numPerPage = (int)map.get("numPerPage");
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return adminDao.selectCamperList(map, rowBounds);
	}
	
	@Override
	public int selectTotalCamperList(Map<String, Object> map) {
		return adminDao.selectTotalCamperList(map);
	}
	
	@Override
	public int camperDelete(Integer camperNo) {
		return (int) adminDao.camperDelete(camperNo);
	}
	
	@Override
	public int reviewDelete(Integer reviewNo) {
		return (int) adminDao.reviewDelete(reviewNo);
	}
	
	@Override
	public List<NoticeExt> selectReviewList(Map<String, Object> map) {
		int offset = (int)map.get("offset");
		int numPerPage = (int)map.get("numPerPage");
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return adminDao.selectReviewList(map, rowBounds);
	}
	
	@Override
	public int selectTotalReviewList(Map<String, Object> map) {
		return adminDao.selectTotalReviewList(map);
	}
	
	@Override
	public int updateMemberRole(Map<String, Object> map) {
		
		int result = 0;
		//log.debug("impl.ROLE_ADMIN = {}", map.get("ROLE_ADMIN"));
		result = adminDao.deleteMemberRole(map);
		if(Boolean.parseBoolean(map.get("ROLE_ADMIN").toString()) == true) {
			result = adminDao.insertAuthority(map);
		}
		
		result = adminDao.deleteBlack(map);
		if(Boolean.parseBoolean(map.get("ROLE_BLACK").toString()) == true) {
			result = adminDao.insertBlack(map);
		}
		
		return result;
	}
	
	@Override
	public List<NoticeExt> selectNoticeList() {
		return adminDao.selectNoticeList();

	}
	
	@Override
	public int todayCamper() {
		return adminDao.todayCamper();
	}
	
	@Override
	public int todayReview() {
		return adminDao.todayReview();
	}
	
	@Override
	public int todayProduct() {
		return adminDao.todayProduct();
	}
	
	@Override
	public int sysdate() {
		return adminDao.sysdate();
	}
	
	@Override
	public int minus1() {
		return adminDao.minus1();
	}
	
	@Override
	public int minus2() {
		return adminDao.minus2();
	}
	
	@Override
	public int minus3() {
		return adminDao.minus3();
	}
	
	@Override
	public int minus4() {
		return adminDao.minus4();
	}
	
	@Override
	public int minus5() {
		return adminDao.minus5();
	}
	
	@Override
	public int minus6() {
		return adminDao.minus6();
	}
	
	@Override
	public int adSysdate() {
		return adminDao.adSysdate();
	}
	
	@Override
	public int adMinus1() {
		return adminDao.adMinus1();
	}
	
	@Override
	public int adMinus2() {
		return adminDao.adMinus2();
	}
	
	@Override
	public int adMinus3() {
		return adminDao.adMinus3();
	}
	
	@Override
	public int adMinus4() {
		return adminDao.adMinus4();
	}
	
	@Override
	public int adMinus5() {
		return adminDao.adMinus5();
	}
	
	@Override
	public int insertTodo(Todo todo) {
		return adminDao.insertTodo(todo);
	}
	
	@Override
	public List<Todo> selectTodoList() {
		return adminDao.selectTodoList();
	}
	
	@Override
	public int updateTodo(Map<String, Object> param) {
		return adminDao.updateTodo(param);
	}

	@Override
	public int deleteTodo(int todoNo) {
		return adminDao.deleteTodo(todoNo);
	}
	
	@Override
	public List<Member> selectReportList(Map<String, Object> map) {
		int offset = (int)map.get("offset");
		int numPerPage = (int)map.get("numPerPage");
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return adminDao.selectReportList(map, rowBounds);
	}
	
	@Override
	public int selectTotalReportList(Map<String, Object> map) {
		return adminDao.selectTotalReportList(map);
	}
	
	@Override
	public int updateBuyerBlack(Map<String, Object> map) {
		int result = 0;
		result = adminDao.deleteBuyerBlack(map);
		if(Boolean.parseBoolean(map.get("ROLE_BLACK").toString()) == true) {
			result = adminDao.insertBuyerBlack(map);
		}
		return result;
	}

	@Override
	public int updateReport(int reportNo) {
		return adminDao.updateReport(reportNo);
	}

}
