package com.kh.campervalley.cs.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campervalley.cs.model.dto.Notice;
import com.kh.campervalley.cs.model.dto.NoticeAttach;
import com.kh.campervalley.cs.model.dto.NoticeExt;

@Mapper
public interface CsDao {

	List<Notice> selectFaqList(Map<String, Object> map, RowBounds rowBounds);

	int faqDelete(int noticeNo);

	Notice selectOneFaq(int noticeNo);

	int faqUpdate(Notice notice);

	int faqInsert(Notice notice);

	int selectTotalFaqList(Map<String, Object> map);

	List<NoticeExt> selectNoticeList(Map<String, Object> map, RowBounds rowBounds);

	int noticeInsert(NoticeExt notice);

	int insertAttachment(NoticeAttach attach);

	NoticeExt selectOneNoticeCollection(int noticeNo);

	NoticeExt selectOneNotice(int noticeNo);

	List<NoticeAttach> selectAttchmentListByNoticeNo(int noticeNo);

	NoticeAttach selectOneAttachment(int noticeAttachNo);

	int deleteAttachment(int noticeAttachNo);

	int noticeUpdate(NoticeExt notice);

	int noticeDelete(int noticeNo);

	int selectTotalNoticeList(Map<String, Object> map);

	int readCntUpdate(int noticeNo);

	NoticeExt movePage(int noticeNo);
	
	
	
}
