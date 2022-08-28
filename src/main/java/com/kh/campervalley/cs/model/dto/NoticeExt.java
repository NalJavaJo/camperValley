package com.kh.campervalley.cs.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.campervalley.member.model.dto.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class NoticeExt extends Notice {
	private int attachCount;
	private List<NoticeAttach> attachments = new ArrayList<>();
	private Member member;
	private int prev;
	private int next;
	private String prevtitle;
	private String nexttitle;
	
	public NoticeExt(int noticeNo, String memberId, Category category, String title, String content,
			LocalDateTime createdAt, int readCount, int attachCount, int prev, int next, String prevtitle, String nexttitle) {
		super(noticeNo, memberId, category, title, content, createdAt, readCount);
		this.attachCount = attachCount;
		this.prev = prev;
		this.next = next;
		this.prevtitle = prevtitle;
		this.nexttitle = nexttitle;
	}
	
	public void addAttachment(@NonNull NoticeAttach attach) {
		attachments.add(attach);
		
	}
}
