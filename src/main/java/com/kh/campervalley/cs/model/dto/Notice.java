package com.kh.campervalley.cs.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	
	private int noticeNo;
	private String memberId;
	private Category category;
	private String title;
	private String content;
	private LocalDateTime createdAt;
	private int readCount;
	
}
