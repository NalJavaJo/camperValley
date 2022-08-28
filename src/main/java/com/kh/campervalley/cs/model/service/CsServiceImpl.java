package com.kh.campervalley.cs.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campervalley.cs.model.dao.CsDao;
import com.kh.campervalley.cs.model.dto.Notice;
import com.kh.campervalley.cs.model.dto.NoticeAttach;
import com.kh.campervalley.cs.model.dto.NoticeExt;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class CsServiceImpl implements CsService {
	
	@Autowired
	private CsDao csDao;
	
	@Override
	public List<Notice> selectFaqList(Map<String, Object> map) {
		int offset = (int)map.get("offset");
		int numPerPage = (int)map.get("numPerPage");
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return csDao.selectFaqList(map, rowBounds);
	}
	
	@Override
	public int faqDelete(int noticeNo) {
		return csDao.faqDelete(noticeNo);
	}
	
	@Override
	public Notice selectOneFaq(int noticeNo) {
		return csDao.selectOneFaq(noticeNo);
	}
	
	@Override
	public int faqUpdate(Notice notice) {
		return csDao.faqUpdate(notice);
	}
	
	@Override
	public int faqInsert(Notice notice) {
		return csDao.faqInsert(notice);
	}
	
	@Override
	public int selectTotalFaqList(Map<String, Object> map) {
		return csDao.selectTotalFaqList(map);
	}
	
	@Override
	public List<NoticeExt> selectNoticeList(Map<String, Object> map) {
		int offset = (int)map.get("offset");
		int numPerPage = (int)map.get("numPerPage");
		RowBounds rowBounds = new RowBounds(offset, numPerPage);
		return csDao.selectNoticeList(map, rowBounds);
	}
	
	@Override
	public int noticeInsert(NoticeExt notice) {
		int result = csDao.noticeInsert(notice);
		log.debug("notice#no = {}", notice.getNoticeNo());
		
		List<NoticeAttach> attachments = notice.getAttachments();
		if(!attachments.isEmpty())  {
			for(NoticeAttach attach : attachments) {
				attach.setNoticeNo(notice.getNoticeNo());
				result = csDao.insertAttachment(attach);
			}
		}
		return result;
	}
	
	@Override
	public NoticeExt selectOneNoticeCollection(int noticeNo) {
		return csDao.selectOneNoticeCollection(noticeNo);
	}
	
	@Override
	public NoticeExt selectOneNotice(int noticeNo) {
		NoticeExt notice = csDao.selectOneNotice(noticeNo);
		List<NoticeAttach> attachments = csDao.selectAttchmentListByNoticeNo(noticeNo);
		notice.setAttachments(attachments);
		return notice;
	}
	
	@Override
	public NoticeAttach selectOneAttachment(int noticeAttachNo) {
		return csDao.selectOneAttachment(noticeAttachNo);
	}
	
	@Override
	public int deleteAttachment(int noticeAttachNo) {
		return csDao.deleteAttachment(noticeAttachNo);
	}
	
	@Override
	public int noticeUpdate(NoticeExt notice) {
		int result = csDao.noticeUpdate(notice);
		
		List<NoticeAttach> attachments = notice.getAttachments();
		if(!attachments.isEmpty()) {
			for(NoticeAttach attach : attachments)
				result = csDao.insertAttachment(attach);
		}
		
		return result;
	}
	
	@Override
	public int noticeDelete(int noticeNo) {
		return csDao.noticeDelete(noticeNo);
	}
	
	@Override
	public int selectTotalNoticeList(Map<String, Object> map) {
		return csDao.selectTotalNoticeList(map);
	}
	
	@Override
	public int readCntUpdate(int noticeNo) {
		return csDao.readCntUpdate(noticeNo);
	}
	
	@Override
	public NoticeExt movePage(int noticeNo) {
		return csDao.movePage(noticeNo);
	}

}
