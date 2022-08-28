package com.kh.campervalley.cs.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campervalley.cs.model.dto.Notice;
import com.kh.campervalley.cs.model.dto.NoticeAttach;
import com.kh.campervalley.cs.model.dto.NoticeExt;

public interface CsService {

	List<Notice> selectFaqList(Map<String, Object> map);

	int faqDelete(int noticeNo);

	Notice selectOneFaq(int noticeNo);

	int faqUpdate(Notice notice);

	int faqInsert(Notice notice);

	int selectTotalFaqList(Map<String, Object> map);

	List<NoticeExt> selectNoticeList(Map<String, Object> map);

	int noticeInsert(NoticeExt notice);

	NoticeExt selectOneNoticeCollection(int noticeNo);

	NoticeExt selectOneNotice(int noticeNo);

	NoticeAttach selectOneAttachment(int noticeAttachNo);

	int deleteAttachment(int noticeAttachNo);

	int noticeUpdate(NoticeExt notice);

	int noticeDelete(int noticeNo);

	int selectTotalNoticeList(Map<String, Object> map);

	int readCntUpdate(int noticeNo);

	NoticeExt movePage(int noticeNo);

}
